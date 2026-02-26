cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fsnviz
  - star-fusion
label: fsnviz_star-fusion
doc: "Plots output of STAR-Fusion.\n\nTool homepage: https://github.com/bow/fsnviz"
inputs:
  - id: input
    type: string
    doc: Input file for STAR-Fusion plots
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fsnviz:0.3.0--py35_1
stdout: fsnviz_star-fusion.out
