cwlVersion: v1.2
class: CommandLineTool
baseCommand: trimadap-mt
label: trimadap_trimadap-mt
doc: "Trim adapter sequences from Illumina data (multi-threaded stream filter).\n\nTool homepage: https://github.com/lh3/trimadap"
inputs:
  - id: input_fastq
    type: File
    doc: "Input FASTQ file (in.fq)"
    inputBinding:
      position: 2
  - id: adapter_5p
    type:
      - 'null'
      - string
    doc: "5'-end adapter"
    inputBinding:
      position: 1
      prefix: '-5'
  - id: adapter_3p
    type:
      - 'null'
      - string
    doc: "3'-end adapter"
    inputBinding:
      position: 1
      prefix: '-3'
  - id: min_length
    type:
      - 'null'
      - int
    doc: "min length [8]"
    inputBinding:
      position: 1
      prefix: -l
  - id: min_score
    type:
      - 'null'
      - int
    doc: "min score [15]"
    inputBinding:
      position: 1
      prefix: -s
  - id: trim_down
    type:
      - 'null'
      - int
    doc: "trim down [don't trim]"
    inputBinding:
      position: 1
      prefix: -t
  - id: max_difference
    type:
      - 'null'
      - float
    doc: "max difference [0.150]"
    inputBinding:
      position: 1
      prefix: -d
  - id: threads
    type:
      - 'null'
      - int
    doc: "number of trimmer threads [1]"
    inputBinding:
      position: 1
      prefix: -p
outputs:
  - id: trimmed_fastq
    type: stdout
    doc: "Trimmed reads in FASTQ format"
stdout: trimadap_trimadap-mt.out
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trimadap:r9--0
