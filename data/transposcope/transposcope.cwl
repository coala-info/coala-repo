cwlVersion: v1.2
class: CommandLineTool
baseCommand: transposcope
label: transposcope
doc: "A tool for visualizing transposon insertions. Note: The provided help text contains
  a Docker error and does not list arguments. The following is based on standard transposcope
  usage.\n\nTool homepage: https://github.com/FenyoLab/transposcope"
inputs:
  - id: subcommand
    type: string
    doc: Subcommand to run (e.g., 'run')
    inputBinding:
      position: 1
  - id: config
    type:
      - 'null'
      - File
    doc: Path to the configuration file
    inputBinding:
      position: 102
      prefix: --config
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transposcope:2.0.1--py_0
stdout: transposcope.out
