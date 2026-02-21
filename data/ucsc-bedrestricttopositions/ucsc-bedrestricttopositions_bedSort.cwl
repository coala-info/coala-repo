cwlVersion: v1.2
class: CommandLineTool
baseCommand: bedSort
label: ucsc-bedrestricttopositions_bedSort
doc: "Sort a BED file. Note: The provided help text contains system error messages
  regarding a failed container build ('no space left on device') and does not list
  command-line arguments. Standard bedSort usage typically involves an input BED file
  and an output destination.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bedrestricttopositions:482--h0b57e2e_0
stdout: ucsc-bedrestricttopositions_bedSort.out
