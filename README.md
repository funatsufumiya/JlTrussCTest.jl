# JlTrussCTest.jl

TrussC C++ call test from Julia using using [tcxJuliaCxxWrap](https://github.com/funatsufumiya/tcxJuliaCxxWrap)

## Usage

### 1. Build cpp code (using CMake)

Please use `trusscli` of TrussC project, and add tcxJuliaCxxWrap and build it.

See https://github.com/funatsufumiya/tcxJuliaCxxWrap

Then copy `.dll`/`.so`/`.dylib` into lib folder (file name should be `libJlTrussC.xxx` even on Windows DLL)

### 2. Run julia code

```bash
$ julia --project=@. -e 'using Pkg; Pkg.instantiate()'
$ julia --project=@. -e 'using JlTrussCTest; JlTrussCTest.main();'
# Hello from JlTrussC C++!!
```
