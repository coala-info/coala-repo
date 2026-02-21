cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncbi-fcs-gx
label: ncbi-fcs-gx
doc: "NCBI Foreign Contamination Screen (FCS) - Genome Cross-species (GX)\n\nTool
  homepage: https://github.com/ncbi/fcs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ncbi-fcs-gx:0.5.5--h9948957_0
stdout: ncbi-fcs-gx.out
