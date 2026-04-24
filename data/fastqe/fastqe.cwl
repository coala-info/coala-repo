cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastqe
label: fastqe
doc: "Read one or more FASTQ files and output emoji summaries of sequence quality.\n\
  \nTool homepage: https://github.com/lonsbio/fastqe"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input FASTQ file(s)
    inputBinding:
      position: 1
  - id: bin
    type:
      - 'null'
      - boolean
    doc: Bin quality scores
    inputBinding:
      position: 102
      prefix: --bin
  - id: max_len
    type:
      - 'null'
      - int
    doc: Maximum length of sequence to include
    inputBinding:
      position: 102
      prefix: --max-len
  - id: mean
    type:
      - 'null'
      - boolean
    doc: Show mean quality per position
    inputBinding:
      position: 102
      prefix: --mean
  - id: min_len
    type:
      - 'null'
      - int
    doc: Minimum length of sequence to include
    inputBinding:
      position: 102
      prefix: --min-len
  - id: no_bin
    type:
      - 'null'
      - boolean
    doc: Do not bin quality scores
    inputBinding:
      position: 102
      prefix: --no-bin
  - id: scale
    type:
      - 'null'
      - boolean
    doc: Show the emoji scale for quality scores
    inputBinding:
      position: 102
      prefix: --scale
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file (default is stdout)
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastqe:0.5.2--pyhdfd78af_0
