cwlVersion: v1.2
class: CommandLineTool
baseCommand: COGmakehash
label: cogtriangles_COGmakehash
doc: "Create a hash file from a list of IDs for COG processing\n\nTool homepage: https://ftp.ncbi.nih.gov/pub/wolf/COGs/COGsoft/"
inputs:
  - id: input_file
    type: File
    doc: input file (list of IDs, e.g. "<prot-id>,<genome-id>" lines)
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
    doc: output directory (creates hash.csv, default ./conv)
    default: conv
    inputBinding:
      position: 102
      prefix: -o=
      separate: false
outputs:
  - id: output_directory
    type: Directory
    doc: output directory (contains hash.csv)
    outputBinding:
      glob: $(inputs.output_directory_path)
  - id: hash_file
    type: File
    doc: 'Correspondence table "<num-prot-id>,<user-prot-id>"'
    outputBinding:
      glob: $(inputs.output_directory_path)/hash.csv
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: '$({class: "Directory", basename: inputs.output_directory_path, listing:
          [], writable: true})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cogtriangles:2012.04--h9948957_4
