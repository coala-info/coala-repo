cwlVersion: v1.2
class: CommandLineTool
baseCommand: FastqConcat
label: ngs-bits_FastqConcat
doc: "Concatinates several FASTQ files into one output FASTQ file.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: input_file
    type:
      type: array
      items: File
    doc: "Input (gzipped) FASTQ files."
    inputBinding:
      position: 101
      prefix: -in
  - id: output_file_path
    type: string
    doc: "Output gzipped FASTQ file."
    inputBinding:
      position: 102
      prefix: -out
  - id: compression_level
    type:
      - 'null'
      - int
    doc: "Output FASTQ compression level from 1 (fastest) to 9 (best compression). Default value: '1'"
    inputBinding:
      position: 101
      prefix: -compression_level
  - id: long_read
    type:
      - 'null'
      - boolean
    doc: "Support long reads (> 1kb). Default value: 'false'"
    inputBinding:
      position: 101
      prefix: -long_read
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
    doc: "Output gzipped FASTQ file."
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
