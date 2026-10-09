# julia CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| julia | Failed | image problem: julia cannot start, libz.so.1 is missing in the image |

## julia

### Tool Description
The Julia language runtime: runs a program file or evaluates an expression.

### Metadata
- **Docker Image**: quay.io/biocontainers/julia:1.10
- **Homepage**: https://github.com/JuliaLang/julia
- **Package**: https://anaconda.org/channels/bioconda/packages/julia/overview
- **Validation**: PASS

### Original Help Text
```text
julia [switches] -- [programfile] [args...]
 -v, --version             Display version information
 -h, --help                Print this message
 -e, --eval <expr>         Evaluate <expr>
 -E, --print <expr>        Evaluate <expr> and display the result
 -L, --load <file>         Load <file> immediately on all processors
 -t, --threads {N|auto}    Enable N threads; "auto" tries to infer a useful default number
 -p, --procs {N|auto}      Integer value N launches N additional local worker processes
 --machine-file <file>     Run processes on hosts listed in <file>
 -i                        Interactive mode; REPL runs and isinteractive() is true
 -q, --quiet               Quiet startup: no banner, suppress REPL warnings
 --project[={<dir>|@.}]    Set <dir> as the home project/environment
 -J, --sysimage <file>     Start up with the given system image file
 -H, --home <dir>          Set location of julia executable
 --startup-file={yes|no}   Load JULIA_DEPOT_PATH/config/startup.jl
 -O, --optimize={0,1,2,3}  Set the optimization level
 -g <level>                Enable / Set the level of debug info generation
 (abridged; the image's julia binary cannot start, see Real Data Test)
```

