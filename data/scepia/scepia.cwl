cwlVersion: v1.2
class: CommandLineTool
baseCommand: scepia
label: scepia
doc: "Single-Cell Epigenome-based Inference of cell-type Activities (Note: The provided
  text contains only system error messages and no help documentation; therefore, no
  arguments could be extracted).\n\nTool homepage: https://github.com/vanheeringen-lab/scepia"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scepia:0.5.1--pyhdfd78af_1
stdout: scepia.out
