cwlVersion: v1.2
class: CommandLineTool
baseCommand: bedSort
label: ucsc-hgloadbed_bedSort
doc: "The provided text does not contain help information as it reflects a container
  execution error (FATAL: Unable to handle docker uri). bedSort is typically used
  to sort BED files.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-hgloadbed:482--h0b57e2e_1
stdout: ucsc-hgloadbed_bedSort.out
