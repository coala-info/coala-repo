cwlVersion: v1.2
class: CommandLineTool
baseCommand: FastqToFasta
label: ngs-bits_FastqToFasta
doc: "Converts a FASTQ file to FASTA format.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: input_file
    type:
      - File
    doc: "Input gzipped FASTQ file."
    inputBinding:
      position: 1
      prefix: -in
  - id: output_file_path
    type:
      - 'null'
      - string
    doc: "Output FASTA file. If unset, writes to STDOUT. Default value: ''"
    default: output.fasta
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
    doc: "Output FASTA file."
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
