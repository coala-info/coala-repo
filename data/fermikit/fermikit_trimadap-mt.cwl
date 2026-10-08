cwlVersion: v1.2
class: CommandLineTool
baseCommand: trimadap-mt
label: fermikit_trimadap-mt
doc: "Trim Illumina adapter sequences from FASTQ reads on the fly (multi-threaded).\n\
  \nTool homepage: https://github.com/lh3/fermikit"
inputs:
  - id: in_fq
    type: File
    doc: Input FASTQ file (plain or gzip-compressed)
    inputBinding:
      position: 1
  - id: adapter_5prime
    type:
      - 'null'
      - string
    doc: 5'-end adapter
    inputBinding:
      position: 101
      prefix: '-5'
  - id: adapter_3prime
    type:
      - 'null'
      - string
    doc: 3'-end adapter
    inputBinding:
      position: 101
      prefix: '-3'
  - id: min_length
    type:
      - 'null'
      - int
    doc: min length
    inputBinding:
      position: 101
      prefix: -l
  - id: min_score
    type:
      - 'null'
      - int
    doc: min score
    inputBinding:
      position: 101
      prefix: -s
  - id: trim_down
    type:
      - 'null'
      - int
    doc: trim down
    inputBinding:
      position: 101
      prefix: -t
  - id: max_difference
    type:
      - 'null'
      - float
    doc: max difference
    inputBinding:
      position: 101
      prefix: -d
  - id: threads
    type:
      - 'null'
      - int
    doc: number of trimmer threads
    inputBinding:
      position: 101
      prefix: -p
outputs:
  - id: trimmed_fastq
    type: stdout
    doc: Trimmed reads in FASTQ format
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fermikit:0.14.dev1--pl5321h86e5fe9_2
stdout: fermikit_trimadap-mt.out
