cwlVersion: v1.2
class: CommandLineTool
baseCommand: julia
label: julia
doc: "The Julia language runtime: runs a Julia program file or evaluates an expression.\n\nTool homepage: https://github.com/JuliaLang/julia"
inputs:
  - id: program_file
    type: ['null', File]
    doc: Julia program file to run
    inputBinding:
      position: 100
  - id: program_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments passed to the program (ARGS)
    inputBinding:
      position: 101
  - id: eval
    type: ['null', string]
    doc: Evaluate an expression
    inputBinding:
      position: 1
      prefix: -e
  - id: print
    type: ['null', string]
    doc: Evaluate an expression and display the result
    inputBinding:
      position: 1
      prefix: -E
  - id: load
    type: ['null', File]
    doc: Load a file immediately on all processors
    inputBinding:
      position: 1
      prefix: -L
  - id: threads
    type: ['null', string]
    doc: Number of threads (an integer or auto)
    inputBinding:
      position: 1
      prefix: --threads
  - id: procs
    type: ['null', string]
    doc: Number of local worker processes (an integer or auto)
    inputBinding:
      position: 1
      prefix: --procs
  - id: machine_file
    type: ['null', File]
    doc: Run processes on hosts listed in this file
    inputBinding:
      position: 1
      prefix: --machine-file
  - id: project
    type: ['null', string]
    doc: Set the project environment (directory or @.)
    inputBinding:
      position: 1
      prefix: --project=
      separate: false
  - id: sysimage
    type: ['null', File]
    doc: Start up with the given system image file
    inputBinding:
      position: 1
      prefix: --sysimage
  - id: home
    type: ['null', string]
    doc: Set the location of the julia executable directory
    inputBinding:
      position: 1
      prefix: --home
  - id: startup_file
    type: ['null', string]
    doc: Load startup file (yes or no)
    inputBinding:
      position: 1
      prefix: --startup-file=
      separate: false
  - id: handle_signals
    type: ['null', string]
    doc: Enable or disable Julia's default signal handlers (yes or no)
    inputBinding:
      position: 1
      prefix: --handle-signals=
      separate: false
  - id: compiled_modules
    type: ['null', string]
    doc: Enable or disable incremental precompilation of modules (yes or no)
    inputBinding:
      position: 1
      prefix: --compiled-modules=
      separate: false
  - id: pkgimages
    type: ['null', string]
    doc: Enable or disable usage of native code caching in the form of pkgimages (yes or no)
    inputBinding:
      position: 1
      prefix: --pkgimages=
      separate: false
  - id: interactive
    type: ['null', boolean]
    doc: Interactive mode; REPL runs and isinteractive() is true
    inputBinding:
      position: 1
      prefix: -i
  - id: quiet
    type: ['null', boolean]
    doc: Quiet startup, no banner
    inputBinding:
      position: 1
      prefix: -q
  - id: banner
    type: ['null', string]
    doc: Enable or disable startup banner (yes, no or auto)
    inputBinding:
      position: 1
      prefix: --banner=
      separate: false
  - id: color
    type: ['null', string]
    doc: Enable or disable color text (yes, no or auto)
    inputBinding:
      position: 1
      prefix: --color=
      separate: false
  - id: history_file
    type: ['null', string]
    doc: Load or save history (yes or no)
    inputBinding:
      position: 1
      prefix: --history-file=
      separate: false
  - id: depwarn
    type: ['null', string]
    doc: Enable or disable syntax and method deprecation warnings (yes, no or error)
    inputBinding:
      position: 1
      prefix: --depwarn=
      separate: false
  - id: warn_overwrite
    type: ['null', string]
    doc: Enable or disable method overwrite warnings (yes or no)
    inputBinding:
      position: 1
      prefix: --warn-overwrite=
      separate: false
  - id: cpu_target
    type: ['null', string]
    doc: Limit usage of CPU features up to this target
    inputBinding:
      position: 1
      prefix: --cpu-target
  - id: optimize
    type: ['null', int]
    doc: Set the optimization level (0, 1, 2 or 3)
    inputBinding:
      position: 1
      prefix: --optimize=
      separate: false
  - id: debug_level
    type: ['null', int]
    doc: Set the debug info level (0, 1 or 2)
    inputBinding:
      position: 1
      prefix: -g
  - id: inline
    type: ['null', string]
    doc: Control whether inlining is permitted (yes or no)
    inputBinding:
      position: 1
      prefix: --inline=
      separate: false
  - id: check_bounds
    type: ['null', string]
    doc: Emit bounds checks always, never, or respect declarations (yes, no or auto)
    inputBinding:
      position: 1
      prefix: --check-bounds=
      separate: false
  - id: math_mode
    type: ['null', string]
    doc: Disallow or enable unsafe floating point optimizations (ieee or fast)
    inputBinding:
      position: 1
      prefix: --math-mode=
      separate: false
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/julia:1.10
stdout: julia.out
