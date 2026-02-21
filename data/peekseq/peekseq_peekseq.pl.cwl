cwlVersion: v1.2
class: CommandLineTool
baseCommand: peekseq.pl
label: peekseq_peekseq.pl
doc: "PeekSeq: A tool for analyzing FASTA sequences with specific length and translation
  table options.\n\nTool homepage: https://github.com/bcgsc/peekseq"
inputs:
  - id: fasta_file
    type: File
    doc: FASTA (DNA/RNA) file
    inputBinding:
      position: 101
      prefix: -f
  - id: genetic_code
    type:
      - 'null'
      - int
    doc: genetic code translation table id
    default: 1
    inputBinding:
      position: 101
      prefix: -c
  - id: length
    type:
      - 'null'
      - int
    doc: length
    default: 90
    inputBinding:
      position: 101
      prefix: -k
  - id: min_region_size
    type:
      - 'null'
      - int
    doc: min. reference FASTA region [size] (bp) to output
    default: 270
    inputBinding:
      position: 101
      prefix: -s
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/peekseq:0.0.1--hdfd78af_0
stdout: peekseq_peekseq.pl.out
