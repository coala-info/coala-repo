# mono CWL Generation Report

## mono

### Tool Description
Mono runtime

### Metadata
- **Docker Image**: quay.io/biocontainers/mono:4.6.2.6--0
- **Homepage**: https://github.com/Seldaek/monolog
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/main/packages/mono/overview
- **Total Downloads**: 55
- **Last updated**: 2025-09-11
- **GitHub**: https://github.com/Seldaek/monolog
- **Stars**: N/A
### Original Help Text
```text
Usage is: mono [options] program [program-options]

Development:
    --aot[=<options>]      Compiles the assembly to native code
    --debug[=<options>]    Enable debugging support, use --help-debug for details
    --debugger-agent=options Enable the debugger agent
    --profile[=profiler]   Runs in profiling mode with the specified profiler module
    --trace[=EXPR]         Enable tracing, use --help-trace for details
    --jitmap               Output a jit method map to /tmp/perf-PID.map
    --help-devel           Shows more options available to developers

Runtime:
    --config FILE          Loads FILE as the Mono config
    --verbose, -v          Increases the verbosity level
    --help, -h             Show usage information
    --version, -V          Show version information
    --runtime=VERSION      Use the VERSION runtime, instead of autodetecting
    --optimize=OPT         Turns on or off a specific optimization
                           Use --list-opt to get a list of optimizations
    --security[=mode]      Turns on the unsupported security manager (off by default)
                           mode is one of cas, core-clr, verifiable or validil
    --attach=OPTIONS       Pass OPTIONS to the attach agent in the runtime.
                           Currently the only supported option is 'disable'.
    --llvm, --nollvm       Controls whenever the runtime uses LLVM to compile code.
    --gc=[sgen,boehm]      Select SGen or Boehm GC (runs mono or mono-sgen)
```


## Metadata
- **Skill**: generated
