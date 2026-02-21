cwlVersion: v1.2
class: CommandLineTool
baseCommand: bedCommonRegions
label: ucsc-bedcommonregions
doc: "Find regions common to all input BED files. Note: The provided help text contains
  a system error and does not list specific arguments.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bedcommonregions:482--h0b57e2e_0
stdout: ucsc-bedcommonregions.out
