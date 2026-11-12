// Übersetzt die Dialoglogik des Three.js-Prototyps in das Format des Dialogue Managers.
// Eingabe: roh.json (vom Prototyp exportiert: Texte, Bedingungen, Effekte als JavaScript-Quelltext)
// Ausgabe: data/dialogues/<datei>.dialogue
// Aufruf:  node tools/dialog_konverter/konvert.js <roh.json> <zielordner> [datei1,datei2,...]
'use strict';
const fs = require('fs');
const acorn = require('acorn');

const [, , ROH, ZIEL, NUR] = process.argv;
const roh = JSON.parse(fs.readFileSync(ROH, 'utf8'));
const SPK = roh._sprecher || {};
let TODO = 0;
const todos = [];

class Unbekannt extends Error {}
// Konstanten aus dem Prototyp
const KONST = {
  PRIS: ["Die Tür ist zu. Nur damit ihr's wisst.", 'Der Boss redet mit euch, wenn er Lust hat.', "Versucht's gar nicht erst."],
  TAPE_CLUE: "Lil' Riffs Band: Ein gewisser Malcolm will an den Schlüssel eines „Meisters“",
};
// Ursprünglicher Text (t0), wenn ein späterer Überzug darauf zurückgreift
const T0 = {
  'ke.2': "*deutet mit dem Kinn die Straße hinunter* Das Cuckoo's Nest. Hummel sucht eine Aushilfe. Und wo die Nomapes trinken, gibt's immer Arbeit – für die, die keine Fragen stellen.",
  'de.1': 'Der Don ist nicht da. Wenn der Don nicht da ist, trinken die Nomapes doppelt. Und wenn die Nomapes doppelt trinken, hab ich doppelt so viele Hände am Hintern. *lächelt müde*',
  'hu.0': "()=>F('hu')?'Na, was darf\\'s sein?':'Willkommen im Cuckoo\\'s Nest! Bitte, wie kann ich helfen?'",
  'ng.2': 'Ihr seid neu hier. Ich bin Nugget. Und ich hab ein Problem, das gut zu Leuten passt, die neu hier sind.',
};
// Seite im Auftrag (Fabrik auftrag('nomapes') bzw. auftrag('cats'))
let SEITE = null;
let AKT_KNOTEN = '';
const q = s => JSON.stringify(String(s));
const id = k => k.replace(/[.\-]/g, '_');

// ---------- Quelltext → AST ----------
function parseFn(src) {
  const ast = acorn.parseExpressionAt(src, 0, { ecmaVersion: 2022 });
  if (ast.type === 'ArrowFunctionExpression' || ast.type === 'FunctionExpression') return ast;
  return { type: 'ArrowFunctionExpression', body: ast, expression: true, params: [] };
}
const nimm = (n, src) => src.slice(n.start, n.end);

// ---------- Ausdrücke → GDScript ----------
const GAME_FELD = { money: 'GameState.geld', reward: 'GameState.belohnung', day: 'GameState.tag', jobDay: 'GameState.job_tag', missDay: 'GameState.fehl_tag' };
const FUNK = {
  hasDig: () => 'GameState.mitglied("dig")', catsAngry: () => 'GameState.katzen_sauer()', wasRobbed: () => 'GameState.wurde_beraubt()',
  beerPrice: () => 'GameState.bierpreis()', roomPrice: () => 'GameState.zimmerpreis()', shiftOpen: () => 'GameState.schicht_offen()',
  aggrieved: () => 'GameState.veraergert()', robbedBack: () => 'GameState.geraubt_zurueck()', roachN: () => 'GameState.roach_name()',
  heroIsApe: () => 'false',
};

function ex(n, env, src) {
  switch (n.type) {
    case 'Literal':
      if (n.value === null) return 'null';
      if (typeof n.value === 'string') return q(n.value);
      if (typeof n.value === 'boolean') return n.value ? 'true' : 'false';
      return String(n.value);
    case 'TemplateLiteral': {
      const teile = [];
      n.quasis.forEach((qq, i) => { if (qq.value.cooked) teile.push(q(qq.value.cooked)); if (n.expressions[i]) teile.push('GameState.text(' + ex(n.expressions[i], env, src) + ')'); });
      return teile.length ? teile.join(' + ') : '""';
    }
    case 'Identifier':
      if (env[n.name]) return ex(env[n.name], env, src);
      if (n.name === 'side') return SEITE ? q(SEITE) : 'GameState.flag("hqSide")';
      if (KONST[n.name] !== undefined && typeof KONST[n.name] === 'string') return q(KONST[n.name]);
      if (n.name === 'boombox') return 'true';
      if (n.name === 'undefined') return 'null';
      if (n.name === 'ANT') return 'Kapitel.antonia_da()';
      throw new Unbekannt(n.name);
    case 'UnaryExpression':
      if (n.operator === '!') return 'not (' + ex(n.argument, env, src) + ')';
      if (n.operator === '-') return n.argument.type === 'Literal' ? '-' + ex(n.argument, env, src) : `(0 - ${ex(n.argument, env, src)})`;
      if (n.operator === 'typeof') return 'true';
      break;
    case 'LogicalExpression': {
      const l = ex(n.left, env, src), r = ex(n.right, env, src);
      if (n.operator === '&&') return `(${l} and ${r})`;
      if (n.operator === '||' && n.right.type === 'Literal' && n.right.value === 0) return l;
      if (n.operator === '||') return n.right.type === 'Literal' && typeof n.right.value === 'number' ? `GameState.oder(${l}, ${r})` : `(${l} or ${r})`;
      break;
    }
    case 'BinaryExpression': {
      // party[1].hp>0 → Mitglied vorhanden
      if (n.left.type === 'MemberExpression' && /^party\[\d\]\.hp$/.test(nimm(n.left, src))) return gruppe(nimm(n.left, src));
      if (n.left.type === 'UnaryExpression' && n.left.operator === 'typeof') return 'true';
      const op = { '===': '==', '==': '==', '!==': '!=', '!=': '!=' }[n.operator] || n.operator;
      if (!['==', '!=', '<', '>', '<=', '>=', '+', '-', '*', '/', '%'].includes(op)) break;
      // Vergleiche typsicher (ein ungesetztes Flag ist false, kein Text)
      if (op === '==') return `GameState.gleich(${ex(n.left, env, src)}, ${ex(n.right, env, src)})`;
      if (op === '!=') return `not GameState.gleich(${ex(n.left, env, src)}, ${ex(n.right, env, src)})`;
      // Textverkettung: Zahlen in Text umwandeln
      if (op === '+' && (istText(n.left) || istText(n.right))) return `(${textTeil(n.left, env, src)} + ${textTeil(n.right, env, src)})`;
      return `(${ex(n.left, env, src)} ${op} ${ex(n.right, env, src)})`;
    }
    case 'ConditionalExpression':
      return `GameState.wenn(${ex(n.test, env, src)}, ${ex(n.consequent, env, src)}, ${ex(n.alternate, env, src)})`;
    case 'CallExpression': {
      const c = nimm(n.callee, src);
      if (c === 'F') return `GameState.flag(${ex(n.arguments[0], env, src)})`;
      if (FUNK[c]) return FUNK[c]();
      if (c === 'Math.min' || c === 'Math.max') return `${c.slice(5)}(${n.arguments.map(a => ex(a, env, src)).join(', ')})`;
      if (c === 'Math.floor') return `GameState.abrunden(${ex(n.arguments[0], env, src)})`;
      break;
    }
    case 'MemberExpression': {
      const s = nimm(n, src);
      let m;
      if ((m = s.match(/^GAME\.(money|reward|day|jobDay|missDay)$/))) return GAME_FELD[m[1]];
      if ((m = s.match(/^GAME\.journal\.(\w+)\.done$/))) return `GameState.quest_erledigt("${m[1]}")`;
      if ((m = s.match(/^GAME\.journal\.(\w+)$/))) return `GameState.quests.has("${m[1]}")`;
      if (s === 'GAME.quest') return '(GameState.aktuelle_quest != "")';
      if (s === 'GAME.quest.done') return 'GameState.quest_erledigt(GameState.aktuelle_quest)';
      if (s === 'GAME.quest.id') return 'GameState.aktuelle_quest';
      if (s === 'GAME.quest.target') return 'GameState.quest_ziel_figur';
      if (/^party\[\d\](\.hp)?$/.test(s)) return gruppe(s);
      if (s === 'SNEAK.on') return 'Kapitel.schleicht()';
      if (n.computed && n.object.type === 'Identifier' && n.object.name === 'BOSS_N') return `GameState.wenn(GameState.gleich(${ex(n.property, env, src)}, "nomapes"), "Don Orango", "Adikatz")`;
      if (s === 'ANT.gone') return 'Kapitel.antonia_weg()';
      if (s === 'ANT.sus') return 'Kapitel.antonia_misstrauen()';
      if (s === 'ANT.n.state') return 'Kapitel.antonia_zustand()';
      if (n.object.type === 'Identifier' && env[n.object.name]) {
        // z. B. const J=GAME.journal.boom; J.done
        const basis = nimm(env[n.object.name], src_of(env[n.object.name]));
        const neu = acorn.parseExpressionAt(basis + '.' + n.property.name, 0, { ecmaVersion: 2022 });
        return ex(neu, {}, basis + '.' + n.property.name);
      }
      break;
    }
  }
  throw new Unbekannt(nimm(n, src));
}
function istText(n) { return (n.type === 'Literal' && typeof n.value === 'string') || n.type === 'TemplateLiteral' || (n.type === 'BinaryExpression' && n.operator === '+' && (istText(n.left) || istText(n.right))); }
function textTeil(n, env, src) { const e = ex(n, env, src); return istText(n) ? e : `GameState.text(${e})`; }
function gruppe(s) { return s.startsWith('party[2]') ? 'GameState.mitglied("corvin")' : s.startsWith('party[1]') ? 'GameState.mitglied("dig")' : 'true'; }
const SRC = new WeakMap();
function src_of(n) { return SRC.get(n) || ''; }

// ---------- Texte: Funktionen → Zweige {bed:[...], muts:[...], wert} ----------
// wert: {art:'text', s} | {art:'null'} | {art:'zufall', liste:[s]} | {art:'t0'}
function textZweige(fn, src, env = {}) {
  if (fn.expression) return tx(fn.body, [], [], env, src);
  return lauf(fn.body.body, [], [], env, src);
}
function lauf(stmts, bed, muts, env, src) {
  if (!stmts.length) return [{ bed, muts, wert: { art: 'null' } }];
  const [s, ...rest] = stmts;
  switch (s.type) {
    case 'ReturnStatement': return tx(s.argument, bed, muts, env, src);
    case 'BlockStatement': return lauf([...s.body, ...rest], bed, muts, env, src);
    case 'IfStatement': {
      const b = ex(s.test, env, src);
      const a = lauf([s.consequent, ...rest], [...bed, b], muts, env, src);
      const c = lauf(s.alternate ? [s.alternate, ...rest] : rest, [...bed, `not (${b})`], muts, env, src);
      return [...a, ...c];
    }
    case 'VariableDeclaration': {
      const e2 = { ...env };
      for (const d of s.declarations) { e2[d.id.name] = d.init; SRC.set(d.init, src); }
      return lauf(rest, bed, muts, e2, src);
    }
    case 'ExpressionStatement':
      return lauf(rest, bed, [...muts, ...effekt(s.expression, env, src, '')], env, src);
    case 'EmptyStatement': return lauf(rest, bed, muts, env, src);
  }
  throw new Unbekannt(nimm(s, src));
}
function tx(n, bed, muts, env, src) {
  if (!n) return [{ bed, muts, wert: { art: 'null' } }];
  switch (n.type) {
    case 'Literal':
      if (n.value === null) return [{ bed, muts, wert: { art: 'null' } }];
      if (typeof n.value === 'string') return [{ bed, muts, wert: { art: 'text', s: n.value } }];
      break;
    case 'TemplateLiteral': {
      let s = '';
      n.quasis.forEach((qq, i) => { s += qq.value.cooked; if (n.expressions[i]) s += '{{' + ex(n.expressions[i], env, src) + '}}'; });
      return [{ bed, muts, wert: { art: 'text', s } }];
    }
    case 'Identifier':
      if (n.name === 't0') return [{ bed, muts, wert: { art: 't0' } }];
      if (env[n.name]) return tx(env[n.name], bed, muts, env, src_of(env[n.name]) || src);
      break;
    case 'ConditionalExpression': {
      if (n.test.type === 'BinaryExpression' && n.test.left.type === 'UnaryExpression' && n.test.left.operator === 'typeof') return [{ bed, muts, wert: { art: 't0' } }];
      const b = ex(n.test, env, src);
      return [...tx(n.consequent, [...bed, b], muts, env, src), ...tx(n.alternate, [...bed, `not (${b})`], muts, env, src)];
    }
    case 'SequenceExpression': {
      let m = muts;
      for (const e of n.expressions.slice(0, -1)) m = [...m, ...effekt(e, env, src, '')];
      return tx(n.expressions[n.expressions.length - 1], bed, m, env, src);
    }
    case 'BinaryExpression':
      if (n.operator === '+') {
        const out = [];
        for (const a of tx(n.left, bed, muts, env, src)) for (const b of tx(n.right, a.bed, a.muts, env, src)) {
          if (a.wert.art === 'null' || b.wert.art === 'null') { out.push({ bed: b.bed, muts: b.muts, wert: { art: 'null' } }); continue; }
          const aw = a.wert.art === 't0' ? { art: 'text', s: T0[AKT_KNOTEN] || '' } : a.wert;
          if (aw.art !== 'text' || b.wert.art !== 'text') throw new Unbekannt('Verkettung mit Zufall');
          out.push({ bed: b.bed, muts: b.muts, wert: { art: 'text', s: aw.s + b.wert.s } }); continue;
          out.push({ bed: b.bed, muts: b.muts, wert: { art: 'text', s: a.wert.s + b.wert.s } });
        }
        return out;
      }
      break;
    case 'CallExpression': {
      const c = nimm(n.callee, src);
      if (c === 't0') return [{ bed, muts, wert: { art: 't0' } }];
      if (c === 'pick1' && n.arguments[0].type === 'Identifier' && Array.isArray(KONST[n.arguments[0].name])) return [{ bed, muts, wert: { art: 'zufall', liste: KONST[n.arguments[0].name] } }];
      if (c === 'pick1' && n.arguments[0].type === 'ArrayExpression') {
        const liste = n.arguments[0].elements.map(e => { if (e.type !== 'Literal') throw new Unbekannt('pick1'); return e.value; });
        return [{ bed, muts, wert: { art: 'zufall', liste } }];
      }
      if (c === 'snaxLine') {
        // Zeile zufällig; wer Snax/Malcolm hört, merkt sich den Namen
        const inner = tx(n.arguments[0], bed, muts, env, src);
        return inner.map(z => z.wert.art === 'zufall' ? { ...z, wert: { art: 'zufall', liste: z.wert.liste, snax: true } } : z);
      }
      break;
    }
  }
  throw new Unbekannt(nimm(n, src));
}

// ---------- Effekte → DM-Zeilen ----------
const ACHSE = { good: 'gut', law: 'gesetz' };
const EREIGNIS_FN = new Set(['ridePiece', 'alleyCut', 'insectsLeave', 'revealJag', 'giveBoom', 'antGone', 'antCalm', 's3Rescuers', 'goBranx', 'revealCats', 'checkShift']);
function effekt(n, env, src, ein) {
  const L = s => [ein + s];
  if (n.type === 'CallExpression') {
    const c = nimm(n.callee, src), A = n.arguments;
    const a = i => ex(A[i], env, src);
    if (c === 'f0' || c === 'fn' || c === 'f') return [];
    if (c === 'setF') return L(`do GameState.set_flag(${a(0)}${A[1] ? ', ' + a(1) : ''})`);
    if (c === 'FX_.appr') return L(`do GameState.zuneigung_aendern(${a(0)}, ${a(1)})`);
    if (c === 'FX_.money') return L(`do GameState.geld_aendern(${a(0)})`);
    if (c === 'FX_.rep') return L(`do GameState.ansehen_aendern(${a(0)}, ${a(1)})`);
    if (c === 'FX_.align') return L(`do GameState.gesinnung_aendern(${q(ACHSE[A[0].value] || A[0].value)}, ${a(1)})`);
    if (c === 'FX_.quest') {
      const p = {}; for (const pr of A[0].properties) p[pr.key.name || pr.key.value] = pr.value;
      const v = k => p[k] ? ex(p[k], env, src) : null;
      const out = L(`do GameState.quest(${v('id') || '""'}, ${v('n') || '""'}, ${v('obj') || '""'}, ${v('done') ? 'GameState.wahr(' + v('done') + ')' : 'false'}, ${v('side') ? 'GameState.wahr(' + v('side') + ')' : 'false'})`);
      if (p.target) out.push(ein + `set GameState.quest_ziel_figur = ${v('target')}`);
      return out;
    }
    if (c === 'toast') { const t = A[0].type === 'Literal' || A[0].type === 'TemplateLiteral' ? a(0).replace(/<[^>]+>/g, '') : a(0); return L(`do EventBus.hinweis.emit(${t}, ${q({ good: 'gut', bad: 'schlecht' }[A[1] && A[1].value] || (A[1] && A[1].value) || 'info')})`); }
    if (c === 'clue') return L(`do GameState.notiz(${a(0)})`);
    if (c === 'rob') return L(`do GameState.rauben(${a(0)})`);
    if (c === 'showMsg') return L(`do EventBus.meldung.emit(${a(0)})`);
    if (c === 'updateHUD' || c === 'updatePartyUI') return [];
    if (c === 'saveGame') return L('do EventBus.ereignis.emit("autosave")');
    if (c === 'DL.start') return L(`do Kapitel.dialog_danach(${q(id(A[0].value))})`);
    if (c === 'travel') return L(`do EventBus.ereignis.emit(${q('reise:' + A[0].value)})`);
    if (n.callee.type === 'MemberExpression' && n.callee.property.name === 'then' && n.callee.object.type === 'CallExpression') {
      return [...effekt(n.callee.object, env, src, ein), ...(A[0].type === 'ArrowFunctionExpression' ? (A[0].expression ? effekt(A[0].body, env, src, ein) : stmts(A[0].body.body, env, src, ein)) : [])];
    }
    if (c === 'setTimeout') {
      if (A[0].type === 'Identifier') return effekt({ type: 'CallExpression', callee: A[0], arguments: [], start: A[0].start, end: A[0].end }, env, src, ein);
      if (A[0].type === 'ArrowFunctionExpression') return A[0].expression ? effekt(A[0].body, env, src, ein) : stmts(A[0].body.body, env, src, ein);
    }
    if (EREIGNIS_FN.has(c)) {
      const args = A.map(x => x.type === 'Literal' ? String(x.value) : nimm(x, src)).join(':');
      return L(`do EventBus.ereignis.emit(${q(c + (args ? ':' + args : ''))})`);
    }
  }
  if (n.type === 'AssignmentExpression') {
    const l = nimm(n.left, src); let m;
    if ((m = l.match(/^GAME\.(day|jobDay|missDay|reward|money)$/))) return L(`set ${GAME_FELD[m[1]]} = ${ex(n.right, env, src)}`);
    if (l === 'GAME.quest.obj') return L(`do GameState.quest_ziel_setzen(${ex(n.right, env, src)})`);
    if (l === 'GAME.quest.target') return L(`set GameState.quest_ziel_figur = ${ex(n.right, env, src)}`);
    if (l === 'outsideKey') return L(`do EventBus.ereignis.emit(${q('stimmung:' + n.right.value)})`);
    if (l === 'RIDE.v') return L('do EventBus.ereignis.emit("fahrt:abbiegen")');
    if ((m = l.match(/^ANT\.(\w+)$/))) return L(`do Kapitel.antonia_setze(${q(m[1])}, ${ex(n.right, env, src)})`);
    if (l === 'boombox.g.visible') return L(`do EventBus.ereignis.emit(${q(n.right.value ? 'boombox:sichtbar' : 'boombox:weg')})`);
    if (/^party\[0\]\.hp$/.test(l)) return L('do GameState.schaden("ren", 4)');
  }
  if (n.type === 'LogicalExpression' && n.operator === '&&') {
    // a && (b, c) → if a: b; c
    const rechts = n.right.type === 'SequenceExpression' ? n.right.expressions : [n.right];
    const innen = rechts.flatMap(e => effekt(e, env, src, ein + '\t'));
    if (!innen.length) return [];
    return [ein + 'if ' + ex(n.left, env, src), ...innen];
  }
  if (n.type === 'SequenceExpression') return n.expressions.flatMap(e => effekt(e, env, src, ein));
  throw new Unbekannt(nimm(n, src));
}
function stmts(list, env, src, ein) {
  const out = []; env = { ...env };
  for (let i = 0; i < list.length; i++) {
    const s = list[i];
    try {
      if (s.type === 'ExpressionStatement') out.push(...effekt(s.expression, env, src, ein));
      else if (s.type === 'BlockStatement') out.push(...stmts(s.body, env, src, ein));
      else if (s.type === 'VariableDeclaration') { for (const d of s.declarations) { env[d.id.name] = d.init; SRC.set(d.init, src); } }
      else if (s.type === 'IfStatement') {
        // if(x) return; → Rest nur, wenn nicht x
        if (s.consequent.type === 'ReturnStatement' && !s.consequent.argument) {
          const rest = stmts(list.slice(i + 1), env, src, ein + '\t');
          if (rest.length) out.push(ein + `if not (${ex(s.test, env, src)})`, ...rest);
          return out;
        }
        const k = stmts(s.consequent.type === 'BlockStatement' ? s.consequent.body : [s.consequent], env, src, ein + '\t');
        const a = s.alternate ? stmts(s.alternate.type === 'BlockStatement' ? s.alternate.body : [s.alternate], env, src, ein + '\t') : [];
        if (k.length || a.length) { out.push(ein + 'if ' + ex(s.test, env, src), ...(k.length ? k : [ein + '\tpass'])); if (a.length) out.push(ein + 'else', ...a); }
      }
      else if (s.type === 'ForOfStatement' && nimm(s.right, src) === 'party') {
        const b = nimm(s.body, src);
        let m;
        if (/u\.hp\s*=\s*u\.max\s*;?$/.test(b)) out.push(ein + 'do GameState.heilen(999)');
        else if ((m = b.match(/u\.hp\+(\d+)/))) out.push(ein + `do GameState.heilen(${m[1]})`);
        else throw new Unbekannt(b);
      }
      else if (s.type === 'EmptyStatement') { }
      else throw new Unbekannt(nimm(s, src));
    } catch (e) {
      if (!(e instanceof Unbekannt)) throw e;
      TODO++; todos.push(nimm(s, src).slice(0, 150));
      out.push(ein + '# TODO Effekt aus dem Prototyp: ' + nimm(s, src).replace(/\s+/g, ' ').slice(0, 150));
    }
  }
  return out;
}

// ---------- Bausteine aus den Rohdaten ----------
function quellen(f) { if (!f) return []; if (f.teile) return f.teile.flatMap(quellen); return [f]; }
function effekte(f, ein = '') {
  const out = [];
  for (const t of quellen(f)) {
    if (t.str) continue;
    const s = t.src;
    let fn; try { fn = parseFn(s); } catch (e) {
      // kein Ausdruck, sondern Anweisungen (z. B. „if(…)…“)
      try { const prog = acorn.parse(s, { ecmaVersion: 2022 }); out.push(...stmts(prog.body, {}, s, ein)); continue; }
      catch (e2) { out.push(ein + '# TODO nicht lesbar: ' + s.slice(0, 120)); TODO++; continue; }
    }
    if (fn.expression) {
      try { out.push(...effekt(fn.body, {}, s, ein)); }
      catch (e) { if (!(e instanceof Unbekannt)) throw e; TODO++; todos.push(s.slice(0, 150)); out.push(ein + '# TODO Effekt aus dem Prototyp: ' + s.replace(/\s+/g, ' ').slice(0, 150)); }
    } else out.push(...stmts(fn.body.body, {}, s, ein));
  }
  return out;
}
function bedingung(f) {
  if (!f) return null;
  const s = f.src || f.str;
  try {
    const fn = parseFn(s);
    if (!fn.expression) {
      const z = textZweige(fn, s);
      // Block mit return true/false → als Zweige; selten
      return z.filter(x => x.wert.art === 'text' || x.wert.art !== 'null').map(x => x.bed.join(' and ') || 'true').join(' or ') || 'false';
    }
    return ex(fn.body, {}, s);
  } catch (e) { if (!(e instanceof Unbekannt)) throw e; TODO++; todos.push('Bedingung: ' + s.slice(0, 140)); return { todo: s }; }
}
// t0 (ursprünglicher Text) durch den bekannten Originaltext ersetzen
function t0Aufloesen(zw) {
  const o = T0[AKT_KNOTEN]; if (!o) return zw;
  const ersatz = o.startsWith('()=>') ? textZweige(parseFn(o), o) : [{ bed: [], muts: [], wert: { art: 'text', s: o } }];
  return zw.flatMap(z => z.wert.art === 't0' ? ersatz.map(u => ({ bed: [...z.bed, ...u.bed], muts: [...z.muts, ...u.muts], wert: u.wert })) : [z]);
}
// Text eines Knotens (inkl. überlagerter Varianten) → Zweige
function textVon(f) { return t0Aufloesen(textVon0(f)); }
function textVon0(f) {
  if (!f) return [{ bed: [], muts: [], wert: { art: 'text', s: '…' } }];
  if (f.str !== undefined) return [{ bed: [], muts: [], wert: { art: 'text', s: f.str } }];
  if (f.nt) {
    const oben = textVon0(f.nt[0]), unten = textVon0(f.nt[1]);
    const aus = [];
    for (const z of oben) {
      if (z.wert.art === 'null') continue;
      if (z.wert.art === 't0') { for (const u of unten) aus.push({ bed: [...z.bed, ...u.bed], muts: [...z.muts, ...u.muts], wert: u.wert }); continue; }
      aus.push(z);
    }
    return [...aus, ...unten];
  }
  const fn = parseFn(f.src);
  return textZweige(fn, f.src);
}
function sprecherZweige(sp) {
  if (!sp) return [{ bed: [], wert: { art: 'text', s: 'nar' } }];
  if (sp.str !== undefined) return [{ bed: [], wert: { art: 'text', s: sp.str } }];
  return textZweige(parseFn(sp.src), sp.src);
}
const name = k => (!k || k === 'nar') ? null : (SPK[k] || k);
const sauber = s => String(s).replace(/\n/g, ' ').replace(/\[/g, '(').replace(/\]/g, ')');
function zeile(sp, s) {
  const n = name(sp);
  return n ? `${n}: ${sauber(s)}` : sauber(s).replace(/:/g, '\\:');
}
// Zweige → DM-Zeilen (if/elif/else)
function zweigeAusgeben(zw, spz, ein, t0Text, fx = []) {
  const out = []; const echte = [];
  for (const s of spz) for (const z of zw) {
    if (z.wert.art === 'null') continue;
    echte.push({ bed: [...s.bed, ...z.bed], muts: z.muts, wert: z.wert, sp: s.wert.s });
  }
  if (!echte.length) return [...fx.map(m => ein + m), ein + '…'];
  const zeilen = (e, ein2) => {
    const L = [...fx.map(m => ein2 + m.replace(/^\t*/, (t) => t)), ...e.muts.map(m => ein2 + m)];
    if (e.wert.art === 'text') L.push(ein2 + zeile(e.sp, e.wert.s));
    else if (e.wert.art === 't0') { if (T0[AKT_KNOTEN]) L.push(ein2 + zeile(e.sp, T0[AKT_KNOTEN])); else { TODO++; todos.push('t0 ' + AKT_KNOTEN); L.push(ein2 + '# TODO ursprünglicher Text (t0)', ein2 + zeile(e.sp, '…')); } }
    else if (e.wert.art === 'zufall') {
      if (e.wert.snax) {
        // Zufallszeile; wer den Namen Snax/Malcolm hört, merkt ihn sich
        L.push(ein2 + `do GameState.wuerfeln(${e.wert.liste.length})`);
        e.wert.liste.forEach((s, i) => {
          L.push(ein2 + (i === 0 ? 'if' : i === e.wert.liste.length - 1 ? 'else' : 'elif') + (i === e.wert.liste.length - 1 ? '' : ` GameState.wurf == ${i}`));
          if (/Snax|Malcolm/.test(s)) L.push(ein2 + '\tdo GameState.set_flag("snaxHeard")');
          L.push(ein2 + '\t' + zeile(e.sp, s));
        });
      } else e.wert.liste.forEach(s => L.push(ein2 + '% ' + zeile(e.sp, s)));
    }
    return L;
  };
  // Bedingungen verkürzen: „not (X)“ ist durch elif schon erfüllt, wenn ein früherer Zweig mit gleichem Anfang X prüfte
  for (let j = 0; j < echte.length; j++) {
    const b = echte[j].bed; const neu = [];
    for (let i = 0; i < b.length; i++) {
      const m = b[i].match(/^not \((.*)\)$/s);
      const vorher = m && echte.slice(0, j).some(e => e.bed.length === i + 1 && e.bed[i] === m[1] && e.bed.slice(0, i).every((x, k) => x === b[k]));
      if (!vorher) neu.push(b[i]);
    }
    echte[j].bed = neu;
  }
  if (echte.length === 1 && !echte[0].bed.length) return zeilen(echte[0], ein);
  for (let i = 0; i < echte.length; i++) {
    const e = echte[i];
    const b = e.bed.length ? e.bed.join(' and ') : null;
    if (i === 0) out.push(ein + 'if ' + (b || 'true'));
    else if (b) out.push(ein + 'elif ' + b);
    else out.push(ein + 'else');
    out.push(...zeilen(e, ein + '\t'));
    if (!b) break;
  }
  return out;
}
// Sprungziel aus String oder Funktion
function sprung(f, ein) {
  if (!f) return [ein + '=> END'];
  if (f.str !== undefined) return [ein + `=> ${f.str === 'END' ? 'END' : id(f.str)}`];
  let zw; try { zw = textZweige(parseFn(f.src), f.src); }
  catch (e) { if (!(e instanceof Unbekannt)) throw e; TODO++; todos.push('Sprung: ' + f.src.slice(0, 140)); return [ein + '# TODO Sprung: ' + f.src.replace(/\s+/g, ' ').slice(0, 140), ein + '=> END']; }
  if (zw.length === 1 && !zw[0].bed.length) return [...zw[0].muts.map(m => ein + m), ein + (zw[0].wert.art === 'text' ? `=> ${id(zw[0].wert.s)}` : '=> END')];
  const out = [];
  zw.forEach((z, i) => {
    const b = z.bed.join(' and ');
    out.push(ein + (i === 0 ? 'if ' + (b || 'true') : (b && i < zw.length - 1) ? 'elif ' + b : 'else'));
    out.push(...z.muts.map(m => ein + '\t' + m));
    out.push(ein + '\t' + (z.wert.art === 'text' ? `=> ${id(z.wert.s)}` : '=> END'));
  });
  return out;
}
function optionen(liste, ein) {
  const out = [];
  for (const o of liste) {
    // Text
    // Antworttext; wechselt er je nach Spielstand, wird die Antwort pro Variante einzeln ausgegeben
    let varianten;
    if (o.t.str !== undefined) varianten = [{ bed: [], s: sauber(o.t.str) }];
    else {
      const src = o.t.src.replace(/^\(\)=>\(\)=>/, '()=>');
      try { varianten = textZweige(parseFn(src), src).filter(z => z.wert.art === 'text').map(z => ({ bed: z.bed, s: sauber(z.wert.s) })); }
      catch (e) { varianten = [{ bed: [], s: '…' }]; TODO++; todos.push('Antworttext ' + AKT_KNOTEN + ': ' + e.message); }
    }
    for (const v of varianten) {
    const t = v.s;
    const conds = [...v.bed]; let todoB = null;
    const b = bedingung(o.if);
    if (b && b.todo) { todoB = b.todo; } else if (b) conds.push(b);
    if (o.once) conds.push(`not GameState.schon("${o.once}")`);
    if (todoB) out.push(ein + '# TODO Bedingung der nächsten Antwort im Prototyp: ' + todoB.replace(/\s+/g, ' ').slice(0, 150));
    const vor = o.sk ? `(${o.sk} ${o.dc}) ` : '';
    out.push(ein + `- ${vor}${t}${conds.length ? ` [if ${conds.join(' and ')} /]` : ''}`);
    if (o.once) out.push(ein + `\tdo GameState.einmal("${o.once}")`);
    out.push(...effekte(o.fx, ein + '\t'));
    if (o.sk) out.push(ein + `\tif GameState.probe("${o.who || 'ren'}", "${o.sk}", ${o.dc})`, ein + `\t\t=> ${id(o.ok)}`, ein + '\telse', ein + `\t\t=> ${id(o.no)}`);
    else if (o.end) out.push(ein + '\t=> END');
    else out.push(...sprung(o.go, ein + '\t'));
    }
  }
  return out;
}
function liveBedingung(liste) {
  // Mindestens eine Antwort (außer „Ende“) ist verfügbar
  const teile = [];
  for (const o of liste) {
    if (o.end) continue;
    const c = []; const b = bedingung(o.if);
    if (b && b.todo) return null;
    if (b) c.push(b);
    if (o.once) c.push(`not GameState.schon("${o.once}")`);
    if (!c.length) return 'true';
    teile.push('(' + c.join(' and ') + ')');
  }
  return teile.length ? teile.join(' or ') : 'false';
}

// ---------- Knoten ausgeben ----------
function knoten(k, n) {
  AKT_KNOTEN = k; SEITE = k.startsWith('or.') ? 'nomapes' : k.startsWith('ad.') ? 'cats' : null;
  const L = [`~ ${id(k)}`];
  // Weiterleitung beim Betreten
  if (n.redirect) {
    try {
      const zw = n.redirect.str !== undefined ? [{ bed: [], muts: [], wert: { art: 'text', s: n.redirect.str } }] : textZweige(parseFn(n.redirect.src), n.redirect.src);
      for (const z of zw) if (z.wert.art === 'text') L.push('if ' + (z.bed.join(' and ') || 'true'), ...z.muts.map(m => '\t' + m), `\t=> ${id(z.wert.s)}`);
    } catch (e) { if (!(e instanceof Unbekannt)) throw e; TODO++; todos.push('Weiterleitung ' + k); L.push('# TODO Weiterleitung: ' + (n.redirect.src || '').replace(/\s+/g, ' ').slice(0, 140)); }
  }
  // Erneuter Besuch im selben Gespräch: nur die Antworten (wie im Prototyp)
  if (n.o && n.o.length) L.push(`if GameState.erneut("${id(k)}")`, `\t=> ${id(k)}__wieder`);
  if (n.gate) {
    let zw; try { zw = textVon(n.gate); } catch (e) { zw = null; TODO++; todos.push('Sperre ' + k + ': ' + e.message); }
    if (zw) {
      const spz = sprecherZweige(n.sp);
      for (const z of zw) if (z.wert.art !== 'null') { L.push('if ' + (z.bed.join(' and ') || 'true'), ...z.muts.map(m => '\t' + m), '\t' + zeile(spz[0].wert.s, z.wert.s), '\t=> END'); }
    }
  }
  if (n.bark && n.o) {
    const lb = liveBedingung(n.o);
    if (lb && lb !== 'true') {
      let zw; try { zw = textVon(n.bark); } catch (e) { zw = null; }
      if (zw) { L.push(`if not (${lb})`); L.push(...zweigeAusgeben(zw, sprecherZweige(n.sp), '\t')); L.push('\t=> END'); }
    }
  }
  const fxZeilen = effekte(n.fx);
  if (n.fight) {
    L.push(...fxZeilen);
    L.push(`do Kapitel.kampf(${JSON.stringify(n.fight.keys)}, ${q(n.fight.name)})`);
    const w = effekte(n.fight.win, '\t'), l = effekte(n.fight.lose, '\t');
    if (w.length || l.length) { L.push('if GameState.flag("letzter_kampf_gewonnen")', ...(w.length ? w : ['\tpass'])); if (l.length) L.push('else', ...l); }
    L.push(...sprung(n.fight.after, ''));
    return L;
  }
  let zw; try { zw = textVon(n.t); } catch (e) {
    if (!(e instanceof Unbekannt)) throw e; TODO++; todos.push('Text ' + k + ': ' + e.message);
    zw = [{ bed: [], muts: [], wert: { art: 'text', s: '…' } }]; L.push('# TODO Text aus dem Prototyp nicht übersetzbar: ' + e.message.slice(0, 120));
  }
  let spz; try { spz = sprecherZweige(n.sp); } catch (e) { spz = [{ bed: [], wert: { art: 'text', s: 'nar' } }]; TODO++; todos.push('Sprecher ' + k + ': ' + e.message); }
  L.push(...zweigeAusgeben(zw, spz, '', null, fxZeilen));
  if (n.o && n.o.length) L.push(...optionen(n.o, ''));
  else if (n.end) L.push('=> END');
  else L.push(...sprung(n.next, ''));
  // Variante für den erneuten Besuch
  if (n.o && n.o.length) {
    L.push('', `~ ${id(k)}__wieder`);
    let az = null;
    if (n.again) { try { az = textVon(n.again).filter(z => z.wert.art === 'text' && z.wert.s); } catch (e) { az = null; } }
    if (az && az.length) L.push(...zweigeAusgeben(az, spz, ''));
    else L.push(zeile(spz[0].wert.s, '…'));
    L.push(...optionen(n.againOpts || n.o, ''));
  }
  return L;
}

const dateien = NUR ? NUR.split(',') : Object.keys(roh).filter(k => !k.startsWith('_'));
for (const d of dateien) {
  TODO = 0; todos.length = 0;
  const L = ['# Automatisch aus dem Prototyp übersetzt (tools/dialog_konverter). Stellen mit TODO von Hand prüfen.', ''];
  for (const [k, n] of Object.entries(roh[d])) { if (k === 'npc.platzhalter') continue; L.push(...knoten(k, n), ''); }
  fs.writeFileSync(`${ZIEL}/${d}.dialogue`, L.join('\n'));
  console.log(d, Object.keys(roh[d]).length, 'Knoten,', TODO, 'TODO');
  for (const t of todos) console.log('   ', t.replace(/\s+/g, ' ').slice(0, 160));
}
