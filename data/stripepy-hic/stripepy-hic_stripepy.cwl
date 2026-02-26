cwlVersion: v1.2
class: CommandLineTool
baseCommand: stripepy
label: stripepy-hic_stripepy
doc: "stripepy is designed to recognize linear patterns in contact maps (.hic, .mcool,
  .cool) through the geometric reasoning, including topological persistence and quasi-interpolation.\n\
  \nTool homepage: https://github.com/paulsengroup/StripePy"
inputs:
  - id: cite
    type:
      - 'null'
      - boolean
    doc: Print StripePy's reference and return.
    inputBinding:
      position: 101
      prefix: --cite
  - id: license
    type:
      - 'null'
      - boolean
    doc: Print StripePy's license and return.
    inputBinding:
      position: 101
      prefix: --license
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stripepy-hic:1.3.0--pyh2a3209d_1
stdout: stripepy-hic_stripepy.out
