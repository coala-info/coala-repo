cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - xtermcolor
  - convert
label: xtermcolor_convert
doc: "256 terminal color library: convert a color to the closest ANSI terminal color\n\nTool homepage: https://github.com/broadinstitute/xtermcolor"
inputs:
  - id: color
    type: string
    doc: Color to convert, as a hexadecimal RGB value (for example 0xff0000 or #ff0000)
    inputBinding:
      position: 2
      prefix: --color
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
stdout: xtermcolor_convert.out
