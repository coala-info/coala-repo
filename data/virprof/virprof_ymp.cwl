cwlVersion: v1.2
class: CommandLineTool
baseCommand: ymp
label: virprof_ymp
doc: "Welcome to YMP!\n\nTool homepage: https://github.com/seiboldlab/virprof"
inputs:
  - id: install_completion
    type:
      - 'null'
      - boolean
    doc: Install command completion for the current shell. Make sure to have 
      psutil installed.
    inputBinding:
      position: 101
      prefix: --install-completion
  - id: log_file
    type:
      - 'null'
      - string
    doc: Specify a log file
    inputBinding:
      position: 101
      prefix: --log-file
  - id: pdb
    type:
      - 'null'
      - boolean
    doc: Drop into debugger on uncaught exception
    inputBinding:
      position: 101
      prefix: --pdb
  - id: profile
    type:
      - 'null'
      - string
    doc: Profile execution time using Yappi
    inputBinding:
      position: 101
      prefix: --profile
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Decrease log verbosity
    inputBinding:
      position: 101
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase log verbosity
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/virprof:0.9.2--pyhdfd78af_0
stdout: virprof_ymp.out
