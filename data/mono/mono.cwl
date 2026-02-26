cwlVersion: v1.2
class: CommandLineTool
baseCommand: mono
label: mono
doc: "Mono runtime\n\nTool homepage: https://github.com/Seldaek/monolog"
inputs:
  - id: program
    type: string
    doc: The program to execute
    inputBinding:
      position: 1
  - id: program_options
    type:
      - 'null'
      - type: array
        items: string
    doc: Options for the program
    inputBinding:
      position: 2
  - id: aot
    type:
      - 'null'
      - string
    doc: Compiles the assembly to native code
    inputBinding:
      position: 103
      prefix: --aot
  - id: attach
    type:
      - 'null'
      - string
    doc: "Pass OPTIONS to the attach agent in the runtime.\n                     \
      \      Currently the only supported option is 'disable'."
    inputBinding:
      position: 103
      prefix: --attach
  - id: config
    type:
      - 'null'
      - File
    doc: Loads FILE as the Mono config
    inputBinding:
      position: 103
      prefix: --config
  - id: debug
    type:
      - 'null'
      - string
    doc: Enable debugging support, use --help-debug for details
    inputBinding:
      position: 103
      prefix: --debug
  - id: debugger_agent
    type:
      - 'null'
      - string
    doc: Enable the debugger agent
    inputBinding:
      position: 103
      prefix: --debugger-agent
  - id: gc
    type:
      - 'null'
      - string
    doc: Select SGen or Boehm GC (runs mono or mono-sgen)
    inputBinding:
      position: 103
      prefix: --gc
  - id: help_devel
    type:
      - 'null'
      - boolean
    doc: Shows more options available to developers
    inputBinding:
      position: 103
      prefix: --help-devel
  - id: jitmap
    type:
      - 'null'
      - boolean
    doc: Output a jit method map to /tmp/perf-PID.map
    inputBinding:
      position: 103
      prefix: --jitmap
  - id: llvm
    type:
      - 'null'
      - boolean
    doc: Controls whenever the runtime uses LLVM to compile code.
    inputBinding:
      position: 103
      prefix: --llvm
  - id: nollvm
    type:
      - 'null'
      - boolean
    doc: Controls whenever the runtime uses LLVM to compile code.
    inputBinding:
      position: 103
      prefix: --nollvm
  - id: optimize
    type:
      - 'null'
      - string
    doc: "Turns on or off a specific optimization\n                           Use
      --list-opt to get a list of optimizations"
    inputBinding:
      position: 103
      prefix: --optimize
  - id: profile
    type:
      - 'null'
      - string
    doc: Runs in profiling mode with the specified profiler module
    inputBinding:
      position: 103
      prefix: --profile
  - id: runtime
    type:
      - 'null'
      - string
    doc: Use the VERSION runtime, instead of autodetecting
    inputBinding:
      position: 103
      prefix: --runtime
  - id: security
    type:
      - 'null'
      - string
    doc: "Turns on the unsupported security manager (off by default)\n           \
      \                mode is one of cas, core-clr, verifiable or validil"
    inputBinding:
      position: 103
      prefix: --security
  - id: trace
    type:
      - 'null'
      - string
    doc: Enable tracing, use --help-trace for details
    inputBinding:
      position: 103
      prefix: --trace
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increases the verbosity level
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mono:4.6.2.6--0
stdout: mono.out
