cwlVersion: v1.2
class: CommandLineTool
baseCommand: BedInfo
label: ngs-bits_BedInfo
doc: "Prints information about a (merged) BED file.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
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
    doc: "Output file. If unset, writes to STDOUT. (This wrapper always writes to a file.)"
    inputBinding:
      position: 102
      prefix: -out
  - id: nomerge
    type:
      - 'null'
      - boolean
    doc: "If set, the input is not merged before printing statistics. Default value: 'false'"
    inputBinding:
      position: 101
      prefix: -nomerge
  - id: filename
    type:
      - 'null'
      - boolean
    doc: "If set, prints the input file name before each line. Default value: 'false'"
    inputBinding:
      position: 101
      prefix: -filename
  - id: fai
    type:
      - 'null'
      - File
    doc: "If set, checks that the maximum position for each chromosome is not exceeded."
    inputBinding:
      position: 101
      prefix: -fai
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
    doc: "Output file. If unset, writes to STDOUT. (This wrapper always writes to a file.)"
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
