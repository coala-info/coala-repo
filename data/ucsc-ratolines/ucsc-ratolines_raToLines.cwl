cwlVersion: v1.2
class: CommandLineTool
baseCommand: raToLines
label: ucsc-ratolines_raToLines
doc: "Output .ra file stanzas as single lines, with pipe-separated fields.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_ra_file
    type: File
    doc: Input .ra file
    inputBinding:
      position: 1
  - id: output_name
    type: string
    doc: Name of the output text file
    inputBinding:
      position: 2
outputs:
  - id: output_txt_file
    type: File
    doc: Output text file with one stanza per line
    outputBinding:
      glob: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-ratolines:482--h0b57e2e_0
