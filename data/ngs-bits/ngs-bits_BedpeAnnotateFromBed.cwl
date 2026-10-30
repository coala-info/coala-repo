cwlVersion: v1.2
class: CommandLineTool
baseCommand: BedpeAnnotateFromBed
label: ngs-bits_BedpeAnnotateFromBed
doc: "Annotates a BEDPE file with information from a BED file.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: bed
    type: File
    doc: "BED file that is used as annotation source."
    inputBinding:
      position: 101
      prefix: -bed
  - id: input_file
    type:
      - 'null'
      - File
    doc: "Input BEDPE file. If unset, reads from STDIN."
    inputBinding:
      position: 101
      prefix: -in
  - id: output_file_path
    type: string
    doc: "Output BEDPE file. If unset, writes to STDOUT. (This wrapper always writes to a file.)"
    inputBinding:
      position: 102
      prefix: -out
  - id: col
    type:
      - 'null'
      - int
    doc: "Annotation source column (default: 4). Default value: '4'"
    inputBinding:
      position: 101
      prefix: -col
  - id: col_name
    type:
      - 'null'
      - string
    doc: "Name of the annotated column Default value: 'ANNOTATION'"
    inputBinding:
      position: 101
      prefix: -col_name
  - id: no_duplicates
    type:
      - 'null'
      - boolean
    doc: "Remove duplicate annotations if several intervals from 'bed' overlap. Default value: 'false'"
    inputBinding:
      position: 101
      prefix: -no_duplicates
  - id: url_decode
    type:
      - 'null'
      - boolean
    doc: "Decode URL encoded characters. Default value: 'false'"
    inputBinding:
      position: 101
      prefix: -url_decode
  - id: replace_underscore
    type:
      - 'null'
      - boolean
    doc: "Replaces underscores with spaces in the annotation column. Default value: 'false'"
    inputBinding:
      position: 101
      prefix: -replace_underscore
  - id: max_value
    type:
      - 'null'
      - boolean
    doc: "Select maximum value if several intervals from 'bed' overlap. (only for numeric columns) Default value: 'false'"
    inputBinding:
      position: 101
      prefix: -max_value
  - id: only_breakpoints
    type:
      - 'null'
      - boolean
    doc: "Only annotate overlaps with the confidence intervall of the break points. Default value: 'false'"
    inputBinding:
      position: 101
      prefix: -only_breakpoints
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
    doc: "Output BEDPE file. If unset, writes to STDOUT. (This wrapper always writes to a file.)"
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
