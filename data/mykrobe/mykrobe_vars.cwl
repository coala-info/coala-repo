cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mykrobe
  - variants
label: mykrobe_vars
doc: "Manage variant databases\n\nTool homepage: https://github.com/iqbal-lab/Mykrobe-predictor"
inputs:
  - id: command
    type: string
    doc: Subcommand to execute
    inputBinding:
      position: 1
  - id: command_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the subcommand
    inputBinding:
      position: 2
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Output debugging information to stderr
    inputBinding:
      position: 103
      prefix: --debug
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Only output warnings/errors to stderr
    inputBinding:
      position: 103
      prefix: --quiet
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mykrobe:0.13.0--py38h59a8061_3
stdout: mykrobe_vars.out
