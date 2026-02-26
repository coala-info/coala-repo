cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-split-fastq
label: dsh-bio_split-fastq
doc: "Splits a FASTQ file into multiple smaller files.\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: bytes
    type:
      - 'null'
      - string
    doc: split input path at next record after each n bytes
    inputBinding:
      position: 101
      prefix: --bytes
  - id: input_path
    type:
      - 'null'
      - File
    doc: input FASTQ path, default stdin
    default: stdin
    inputBinding:
      position: 101
      prefix: --input-path
  - id: left_pad
    type:
      - 'null'
      - int
    doc: left pad split index in output file name
    inputBinding:
      position: 101
      prefix: --left-pad
  - id: prefix
    type:
      - 'null'
      - string
    doc: output file prefix
    inputBinding:
      position: 101
      prefix: --prefix
  - id: records
    type:
      - 'null'
      - int
    doc: split input path after each n records
    inputBinding:
      position: 101
      prefix: --records
  - id: suffix
    type:
      - 'null'
      - string
    doc: output file suffix, e.g. .fq.gz
    inputBinding:
      position: 101
      prefix: --suffix
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
stdout: dsh-bio_split-fastq.out
