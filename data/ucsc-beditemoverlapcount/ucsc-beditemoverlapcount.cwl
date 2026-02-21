cwlVersion: v1.2
class: CommandLineTool
baseCommand: bedItemOverlapCount
label: ucsc-beditemoverlapcount
doc: "The provided help text does not contain usage information due to a system error
  (no space left on device). This tool is part of the UCSC Genome Browser utilities
  and is typically used to count overlaps between BED items.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-beditemoverlapcount:482--h0b57e2e_0
stdout: ucsc-beditemoverlapcount.out
