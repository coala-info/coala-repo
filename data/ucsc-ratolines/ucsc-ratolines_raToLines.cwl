cwlVersion: v1.2
class: CommandLineTool
baseCommand: raToLines
label: ucsc-ratolines_raToLines
doc: "Output .ra file stanzas as single lines, with pipe-separated fields.\n\nTool
  homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_ra_file
    type: File
    doc: Input .ra file
    inputBinding:
      position: 1
outputs:
  - id: output_txt_file
    type: File
    doc: Output text file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-ratolines:482--h0b57e2e_0
