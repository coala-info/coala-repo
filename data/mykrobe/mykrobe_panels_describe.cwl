cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mykrobe
  - panels
  - describe
label: mykrobe_panels_describe
doc: "Describe all known panels\n\nTool homepage: https://github.com/Mykrobe-tools/mykrobe"
inputs:
  - id: panels_dir
    type:
      - 'null'
      - Directory
    doc: Name of directory that contains panel data
    inputBinding:
      position: 1
      prefix: --panels_dir
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Only output warnings/errors to stderr
    inputBinding:
      position: 1
      prefix: --quiet
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Output debugging information to stderr
    inputBinding:
      position: 1
      prefix: --debug
outputs:
  - id: stdout
    type: stdout
    doc: Table of species and panels
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mykrobe:0.13.0--py38h59a8061_3
stdout: mykrobe_panels_describe.out
