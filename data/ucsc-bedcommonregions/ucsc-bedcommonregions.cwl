cwlVersion: v1.2
class: CommandLineTool
baseCommand: bedCommonRegions
label: ucsc-bedcommonregions
doc: "Find regions common to all input files.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input BED files to find common regions in
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bedcommonregions:482--h0b57e2e_0
stdout: ucsc-bedcommonregions.out
