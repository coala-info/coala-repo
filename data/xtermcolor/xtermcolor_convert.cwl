cwlVersion: v1.2
class: CommandLineTool
baseCommand: xtermcolor
label: xtermcolor_convert
doc: "256 terminal color library\n\nTool homepage: https://github.com/broadinstitute/xtermcolor"
inputs:
  - id: action
    type: string
    doc: Actions
    inputBinding:
      position: 1
  - id: color
    type:
      - 'null'
      - string
    doc: Color to convert
    inputBinding:
      position: 102
      prefix: --color
  - id: compat
    type:
      - 'null'
      - string
    doc: Compatibility mode. Defaults to xterm.
    inputBinding:
      position: 102
      prefix: --compat
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xtermcolor:1.3--pyh864c0ab_2
stdout: xtermcolor_convert.out
