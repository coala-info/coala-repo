cwlVersion: v1.2
class: CommandLineTool
baseCommand: FastqFormat
label: ngs-bits_FastqFormat
doc: "Determines the FastQ quality encoding format.\n\nTool homepage: https://github.com/imgag/ngs-bits"
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
    doc: "Output text file. If unset, writes to STDOUT. Default value: ''"
    default: fastq_format.txt
    inputBinding:
      position: 2
      prefix: -out
  - id: reads
    type:
      - 'null'
      - int
    doc: "The number of reads to parse. Default value: 10000"
    inputBinding:
      position: 3
      prefix: -reads
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
    doc: "Text file with the detected quality encoding."
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
