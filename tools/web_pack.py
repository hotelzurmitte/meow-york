"""Bereitet einen Godot-Web-Export für die Artefakt-Vorschau vor:
index.wasm (zu groß) wird gzip-komprimiert und beim Laden im Browser entpackt."""
import sys,gzip,shutil,os,re
d=sys.argv[1]
w=os.path.join(d,'index.wasm')
with open(w,'rb') as f, gzip.open(os.path.join(d,'engine.gz.wasm'),'wb',compresslevel=9) as g: shutil.copyfileobj(f,g)
os.remove(w)
os.replace(os.path.join(d,'index.pck'),os.path.join(d,'game.pck.wasm'))
p=os.path.join(d,'index.html');s=open(p,encoding='utf-8').read()
shim="""<script>
(()=>{const of=window.fetch.bind(window);window.fetch=async(u,o)=>{const s=typeof u==='string'?u:(u&&u.url)||String(u);
 if(/index\\.pck(\\?|$)/.test(s))return of(s.replace(/index\\.pck/,'game.pck.wasm'),o);
 if(/index\\.wasm(\\?|$)/.test(s)){const r=await of(s.replace(/index\\.wasm/,'engine.gz.wasm'),o);
  return new Response(r.body.pipeThrough(new DecompressionStream('gzip')),{status:200,headers:{'Content-Type':'application/wasm'}});}
 return of(u,o);};})();
</script>
"""
s=s.replace('<script src="index.js"></script>',shim+'<script src="index.js"></script>',1)
s=s.replace('"ensureCrossOriginIsolationHeaders":true','"ensureCrossOriginIsolationHeaders":false')
open(p,'w',encoding='utf-8').write(s)
print('ok', os.path.getsize(os.path.join(d,'engine.gz.wasm')))
