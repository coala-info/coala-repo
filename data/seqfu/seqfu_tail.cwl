cwlVersion: v1.2
class: CommandLineTool
baseCommand: tail
label: seqfu_tail
doc: "Print the last sequences of files\n\nTool homepage: http://github.com/quadram-institute-bioscience/seqfu/"
inputs:
  - id: inputfile
    type:
      - 'null'
      - type: array
        items: File
    doc: Input files
    inputBinding:
      position: 1
  - id: basename
    type:
      - 'null'
      - boolean
    doc: prepend basename to sequence name
    inputBinding:
      position: 102
      prefix: --basename
  - id: fasta
    type:
      - 'null'
      - boolean
    doc: Force FASTA output
    inputBinding:
      position: 102
      prefix: --fasta
  - id: fastq
    type:
      - 'null'
      - boolean
    doc: Force FASTQ output
    inputBinding:
      position: 102
      prefix: --fastq
  - id: fastq_qual
    type:
      - 'null'
      - int
    doc: FASTQ default quality
    default: 33
    inputBinding:
      position: 102
      prefix: --fastq-qual
  - id: num
    type:
      - 'null'
      - int
    doc: Print the first NUM sequences
    default: 10
    inputBinding:
      position: 102
      prefix: --num
  - id: prefix
    type:
      - 'null'
      - string
    doc: Rename sequences with prefix + incremental number
    inputBinding:
      position: 102
      prefix: --prefix
  - id: sep
    type:
      - 'null'
      - string
    doc: Sequence name fields separator
    default: _
    inputBinding:
      position: 102
      prefix: --sep
  - id: skip
    type:
      - 'null'
      - int
    doc: Print one sequence every SKIP
    default: 0
    inputBinding:
      position: 102
      prefix: --skip
  - id: strip_comments
    type:
      - 'null'
      - boolean
    doc: Remove comments
    inputBinding:
      position: 102
      prefix: --strip-comments
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqfu:1.23.0--hfd12232_0
stdout: seqfu_tail.out
