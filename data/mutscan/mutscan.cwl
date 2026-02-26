cwlVersion: v1.2
class: CommandLineTool
baseCommand: mutscan
label: mutscan
doc: "A tool for scanning mutations in FASTQ data and generating HTML/JSON reports.\n\
  \nTool homepage: https://github.com/OpenGene/genefuse"
inputs:
  - id: mark
    type:
      - 'null'
      - int
    doc: The length of the marking sequence (k-mer) for mutation detection.
    default: 30
    inputBinding:
      position: 101
      prefix: --mark
  - id: mutation
    type:
      - 'null'
      - File
    doc: Mutation file name, can be a CSV file or a VCF file.
    inputBinding:
      position: 101
      prefix: --mutation
  - id: read1
    type: File
    doc: Read1 FASTQ file, required.
    inputBinding:
      position: 101
      prefix: --read1
  - id: read2
    type:
      - 'null'
      - File
    doc: Read2 FASTQ file if the data is paired-end.
    inputBinding:
      position: 101
      prefix: --read2
  - id: support
    type:
      - 'null'
      - int
    doc: Minimum support read number for a mutation to be reported.
    default: 2
    inputBinding:
      position: 101
      prefix: --support
  - id: thread
    type:
      - 'null'
      - int
    doc: Worker thread number.
    default: 4
    inputBinding:
      position: 101
      prefix: --thread
outputs:
  - id: html
    type:
      - 'null'
      - File
    doc: The HTML report file name.
    outputBinding:
      glob: $(inputs.html)
  - id: json
    type:
      - 'null'
      - File
    doc: The JSON report file name.
    outputBinding:
      glob: $(inputs.json)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mutscan:1.14.1--h5ca1c30_0
