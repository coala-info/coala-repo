cwlVersion: v1.2
class: CommandLineTool
baseCommand: mafSplitPos
label: ucsc-mafsplit_mafSplitPos
doc: "A tool from the UCSC Genome Browser suite to split MAF files by position. Note:
  The provided help text contains a fatal container execution error and does not list
  specific arguments.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-mafsplit:482--h0b57e2e_0
stdout: ucsc-mafsplit_mafSplitPos.out
