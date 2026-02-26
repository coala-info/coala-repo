cwlVersion: v1.2
class: CommandLineTool
baseCommand: mykrobe_panels
label: mykrobe_panels
doc: "Manage mykrobe panels\n\nTool homepage: https://github.com/iqbal-lab/Mykrobe-predictor"
inputs:
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Output debugging information to stderr
    inputBinding:
      position: 101
      prefix: --debug
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Only output warnings/errors to stderr
    inputBinding:
      position: 101
      prefix: --quiet
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mykrobe:0.13.0--py38h59a8061_3
stdout: mykrobe_panels.out
