cwlVersion: v1.2
class: CommandLineTool
baseCommand: cmph5tools.py
label: pbh5tools_cmph5tools.py
doc: "Toolkit for command-line tools associated with cmp.h5 file processing.\n\nTool
  homepage: https://github.com/zkennedy/pbh5tools"
inputs:
  - id: subcommand
    type: string
    doc: 'The specific tool to execute: select, merge, sort, equal, summarize, stats,
      listMetrics, or validate'
    inputBinding:
      position: 1
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Catch exceptions in debugger (requires ipdb)
    default: false
    inputBinding:
      position: 102
      prefix: --debug
  - id: profile
    type:
      - 'null'
      - boolean
    doc: Print runtime profile at exit
    default: false
    inputBinding:
      position: 102
      prefix: --profile
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Set the verbosity level
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pbh5tools:0.8.0--py27h470a237_1
stdout: pbh5tools_cmph5tools.py.out
