cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fsnviz
  - fusioncatcher
label: fsnviz_fusioncatcher
doc: "Plots output of FusionCatcher.\n\nTool homepage: https://github.com/bow/fsnviz"
inputs:
  - id: input
    type: string
    doc: INPUT
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fsnviz:0.3.0--py35_1
stdout: fsnviz_fusioncatcher.out
