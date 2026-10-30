cwlVersion: v1.2
class: CommandLineTool
baseCommand: FastqCheckUMI
label: ngs-bits_FastqCheckUMI
doc: "Returns the UMI info of a FastQ file on STDOUT.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: input_file
    type: File
    doc: "Input FASTQ file."
    inputBinding:
      position: 101
      prefix: -in
  - id: output_file_path
    type: string
    doc: "Output file containing the result string. If unset, writes to STDOUT. (This wrapper always writes to a file.)"
    inputBinding:
      position: 102
      prefix: -out
  - id: lines
    type:
      - 'null'
      - int
    doc: "Number of lines which should be checked. (default: 10) Default value: '10'"
    inputBinding:
      position: 101
      prefix: -lines
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
    doc: "Output file containing the result string. If unset, writes to STDOUT. (This wrapper always writes to a file.)"
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
