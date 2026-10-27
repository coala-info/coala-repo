cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - xtermcolor
  - list
label: xtermcolor_list
doc: "256 terminal color library: list the ANSI terminal colors with their RGB values\n\nTool homepage: https://github.com/broadinstitute/xtermcolor"
inputs:
  - id: compat
    type:
      - 'null'
      - string
    doc: Compatibility mode, xterm or vt100. Defaults to xterm.
    inputBinding:
      position: 2
      prefix: --compat
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xtermcolor:1.3--pyh864c0ab_2
stdout: xtermcolor_list.out
