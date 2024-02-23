## GraalWasm

```
emcc -o floyd.wasm floyd.c
wasm --Builtins=wasi_snapshot_preview1 floyd.wasm
```
