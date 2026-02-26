cwlVersion: v1.2
class: CommandLineTool
baseCommand: head
label: seqfu_head
doc: "Select a number of sequences from the beginning of a file, allowing to select
  a fraction of the reads (for example to print 100 reads, selecting one every 10).\n\
  \nTool homepage: http://github.com/quadram-institute-bioscience/seqfu/"
inputs:
  - id: input_files
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
  - id: fatal
    type:
      - 'null'
      - boolean
    doc: Exit with error if less than NUM sequences are found
    inputBinding:
      position: 102
      prefix: --fatal
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
  - id: print_last
    type:
      - 'null'
      - boolean
    doc: Print the name of the last sequence to STDERR (Last:NAME)
    inputBinding:
      position: 102
      prefix: --print-last
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Don't print warnings
    inputBinding:
      position: 102
      prefix: --quiet
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
stdout: seqfu_head.out
