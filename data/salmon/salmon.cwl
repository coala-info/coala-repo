cwlVersion: v1.2
class: CommandLineTool
baseCommand: salmon
label: salmon
doc: "Salmon is a tool for quantifying the expression of transcripts from RNA-seq
  data.\n\nTool homepage: https://github.com/COMBINE-lab/salmon"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/salmon:1.10.3--h45fbf2d_5
stdout: salmon.out
