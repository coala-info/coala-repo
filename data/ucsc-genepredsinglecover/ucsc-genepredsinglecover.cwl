cwlVersion: v1.2
class: CommandLineTool
baseCommand: genePredSingleCover
label: ucsc-genepredsinglecover
doc: "The provided text is a container build error log and does not contain help information.
  Based on the tool name hint, this utility creates a genePred file where overlapping
  exons are merged into a single coverage.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-genepredsinglecover:482--h0b57e2e_0
stdout: ucsc-genepredsinglecover.out
