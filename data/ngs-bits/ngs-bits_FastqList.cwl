cwlVersion: v1.2
class: CommandLineTool
baseCommand: FastqList
label: ngs-bits_FastqList
doc: "List read IDs and base count.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: input_file
    type:
      - File
    doc: "Input FASTQ file (gzipped or plain)."
    inputBinding:
      position: 1
      prefix: -in
  - id: output_file_path
    type:
      - 'null'
      - string
    doc: "Output TSV file. If unset, writes to STDOUT. Default value: ''"
    default: fastq_list.tsv
    inputBinding:
      position: 2
      prefix: -out
  - id: settings
    type:
      - 'null'
      - File
    doc: "Settings override file (no other settings files are used)."
    inputBinding:
      position: 100
      prefix: --settings
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: "TSV file with read IDs and base counts."
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
