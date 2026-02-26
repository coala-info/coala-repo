cwlVersion: v1.2
class: CommandLineTool
baseCommand: lavToAxt
label: ucsc-lavtoaxt
doc: "Convert lav format to axt format. targetDir and queryDir can be either a directory
  of .fa files or a single .2bit file.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs:
  - id: input_lav
    type: File
    doc: Input LAV file
    inputBinding:
      position: 1
  - id: target_dir
    type: string
    doc: Directory of .fa files or a single .2bit file for the target sequence
    inputBinding:
      position: 2
  - id: query_dir
    type: string
    doc: Directory of .fa files or a single .2bit file for the query sequence
    inputBinding:
      position: 3
outputs:
  - id: output_axt
    type: File
    doc: Output AXT file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-lavtoaxt:482--h0b57e2e_0
