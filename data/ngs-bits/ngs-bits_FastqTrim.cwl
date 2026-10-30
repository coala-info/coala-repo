cwlVersion: v1.2
class: CommandLineTool
baseCommand: FastqTrim
label: ngs-bits_FastqTrim
doc: "Trims start/end bases from all reads in a FASTQ file.\n\nTool homepage: https://github.com/imgag/ngs-bits"
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
      - string
    doc: "Output gzipped FASTQ file."
    inputBinding:
      position: 2
      prefix: -out
  - id: start
    type:
      - 'null'
      - int
    doc: "Trim this number of bases from the start of the read. Default value: 0"
    inputBinding:
      position: 3
      prefix: -start
  - id: end
    type:
      - 'null'
      - int
    doc: "Trim this number of bases from the end of the read. Default value: 0"
    inputBinding:
      position: 4
      prefix: -end
  - id: len
    type:
      - 'null'
      - int
    doc: "Restrict read length to this value (after trimming from start/end). Default value: 0"
    inputBinding:
      position: 5
      prefix: -len
  - id: max_len
    type:
      - 'null'
      - int
    doc: "Only trim reads smaller than the given length. Used e.g. to remove UMIs at the read end from read-throughs. Default value: 0"
    inputBinding:
      position: 6
      prefix: -max_len
  - id: compression_level
    type:
      - 'null'
      - int
    doc: "Output FASTQ compression level from 1 (fastest) to 9 (best compression). Default value: 1"
    inputBinding:
      position: 10
      prefix: -compression_level
  - id: long_read
    type:
      - 'null'
      - boolean
    doc: "Support long reads (> 1kb)."
    inputBinding:
      position: 11
      prefix: -long_read
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
    doc: "Trimmed gzipped FASTQ file."
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
