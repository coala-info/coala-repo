cwlVersion: v1.2
class: CommandLineTool
baseCommand: toLower
label: ucsc-tolower
doc: "Convert upper case to lower case in file. Leave other chars alone.\n\nTool homepage:
  https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_file
    type: File
    doc: Input file.
    inputBinding:
      position: 1
  - id: out_file
    type: string
    doc: Output file name.
    inputBinding:
      position: 2
outputs:
  - id: output_file
    type: File
    doc: Converted output file.
    outputBinding:
      glob: $(inputs.out_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-tolower:482--h0b57e2e_0
