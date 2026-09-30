cwlVersion: v1.2
class: CommandLineTool
baseCommand: COGmakehash
label: cogtriangles_COGmakehash
doc: "Create a hash file from a list of IDs for COG processing\n\nTool homepage: https://ftp.ncbi.nih.gov/pub/wolf/COGs/COGsoft/"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: input file (list of IDs)
    inputBinding:
      position: 101
      prefix: -i=
      separate: false
  - id: name_field_index
    type:
      - 'null'
      - int
    doc: index of the name field in the input file (1-based)
    inputBinding:
      position: 101
      prefix: -n=
      separate: false
  - id: separator_char
    type:
      - 'null'
      - string
    doc: separator character
    inputBinding:
      position: 101
      prefix: -s=
      separate: false
  - id: output_directory_path
    type: string
    doc: "=dout\t\toutput directory (creates hash.csv, default ./conv)"
    inputBinding:
      position: 102
      prefix: -o=
      separate: false
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: output directory (creates hash.csv)
    outputBinding:
      glob: $(inputs.output_directory_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cogtriangles:2012.04--h9948957_4
