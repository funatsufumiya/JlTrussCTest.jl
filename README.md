# JlTrussCTest.jl

TrussC C++ call test from Julia using using [tcxJuliaCxxWrap](https://github.com/funatsufumiya/tcxJuliaCxxWrap)

## Usage

### 1. [Optional] Build cpp code (using CMake)

Please use `trusscli` of TrussC project, and add tcxJuliaCxxWrap and build it.

See https://github.com/funatsufumiya/tcxJuliaCxxWrap

### 2. Run julia code

```bash
$ julia --project=@. -e 'using Pkg; Pkg.instantiate()'
$ julia --project=@. -e 'using JlTrussCTest; JlTrussCTest.main();'
# Hello from JlTrussC C++!!
```
