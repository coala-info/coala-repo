cwlVersion: v1.2
class: CommandLineTool
baseCommand: BedAnnotateFromBed
label: ngs-bits_BedAnnotateFromBed
doc: "Annotates BED file regions with information from a second BED file.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: in2
    type: File
    doc: "BED file that is used as annotation source."
    inputBinding:
      position: 101
      prefix: -in2
  - id: input_file
    type:
      - 'null'
      - File
    doc: "Input BED file. If unset, reads from STDIN."
    inputBinding:
      position: 101
      prefix: -in
  - id: output_file_path
    type: string
    doc: "Output BED file. If unset, writes to STDOUT. (This wrapper always writes to a file.)"
    inputBinding:
      position: 102
      prefix: -out
  - id: col
    type:
      - 'null'
      - int
    doc: "Annotation source column (if column number does not exist, 'yes' is used). Default value: '4'"
    inputBinding:
      position: 101
      prefix: -col
  - id: clear
    type:
      - 'null'
      - boolean
    doc: "Clear all annotations present in the 'in' file. Default value: 'false'"
    inputBinding:
      position: 101
      prefix: -clear
  - id: no_duplicates
    type:
      - 'null'
      - boolean
    doc: "Remove duplicate annotations if several intervals from 'in2' overlap. Default value: 'false'"
    inputBinding:
      position: 101
      prefix: -no_duplicates
  - id: overlap
    type:
      - 'null'
      - boolean
    doc: "Annotate overlap with regions in 'in2'. The regular annotation is appended in brackets. Default value: 'false'"
    inputBinding:
      position: 101
      prefix: -overlap
  - id: url_decode
    type:
      - 'null'
      - boolean
    doc: "Decode URL encoded characters Default value: 'false'"
    inputBinding:
      position: 101
      prefix: -url_decode
  - id: name
    type:
      - 'null'
      - string
    doc: "Use this name as column header of TSV files output files. If unset, the base file name if 'in2' is used."
    inputBinding:
      position: 101
      prefix: -name
  - id: settings
    type:
      - 'null'
      - File
    doc: "Settings override file (no other settings files are used)."
    inputBinding:
      position: 101
      prefix: --settings
outputs:
  - id: output_file
    type: File
    doc: "Output BED file. If unset, writes to STDOUT. (This wrapper always writes to a file.)"
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
