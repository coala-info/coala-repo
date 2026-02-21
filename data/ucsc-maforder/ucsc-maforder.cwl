cwlVersion: v1.2
class: CommandLineTool
baseCommand: mafOrder
label: ucsc-maforder
doc: "The provided text is a container execution error log and does not contain help
  information for the tool. Based on the tool name hint, this utility is part of the
  UCSC Genome Browser toolset used to reorder sequences in Multiple Alignment Format
  (MAF) files.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-maforder:482--h0b57e2e_0
stdout: ucsc-maforder.out
