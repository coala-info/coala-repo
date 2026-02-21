cwlVersion: v1.2
class: CommandLineTool
baseCommand: gopeaks
label: gopeaks
doc: "Peak caller for ChIP-seq and ATAC-seq (Note: The provided help text contains
  only system error messages and no command-line argument information).\n\nTool homepage:
  https://github.com/maxsonBraunLab/gopeaks"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gopeaks:1.0.0--h047eeb3_3
stdout: gopeaks.out
