cwlVersion: v1.2
class: CommandLineTool
baseCommand: FastqExtract
label: ngs-bits_FastqExtract
doc: "Extracts reads from a FASTQ file according to an ID list. Trims the reads if lengths are given.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs:
  - id: input_file
    type:
      - File
    doc: "Input FASTQ file (gzipped or plain)."
    inputBinding:
      position: 1
      prefix: -in
  - id: ids
    type:
      - File
    doc: "Input TSV file containing IDs (without the '@') in the first column and optional length in the second column."
    inputBinding:
      position: 2
      prefix: -ids
  - id: output_file_path
    type:
      - string
    doc: "Output FASTQ file."
    inputBinding:
      position: 3
      prefix: -out
  - id: invert
    type:
      - 'null'
      - boolean
    doc: "Invert match: keep non-matching reads."
    inputBinding:
      position: 4
      prefix: -v
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
    doc: "Output FASTQ file."
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_12--py314h40a1aea_0
