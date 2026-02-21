cwlVersion: v1.2
class: CommandLineTool
baseCommand: bedSort
label: ucsc-bedweedoverlapping_bedSort
doc: "Sort a BED file. Note: The provided help text indicates a system failure (no
  space left on device) during container extraction and does not contain usage information.
  Standard bedSort arguments are included based on tool metadata.\n\nTool homepage:
  https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input
    type: File
    doc: Input BED file to be sorted
    inputBinding:
      position: 1
outputs:
  - id: output
    type: File
    doc: Output sorted BED file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bedweedoverlapping:482--h0b57e2e_0
