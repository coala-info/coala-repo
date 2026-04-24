cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sqt
  - fastagrep
label: sqt_fastagrep
doc: "Search for a IUPAC string in the sequences of a FASTA file.\n\nPrints matching
  entries in the fasta file to standard output.\nIf <FASTA> is not provided, read
  from standard input.\n\nIf output is a terminal, the first occurrence of the pattern\n\
  in each sequence is highlighted.\n\nTool homepage: https://github.com/tdjsnelling/sqtracker"
inputs:
  - id: pattern
    type: string
    doc: The IUPAC string to search for.
    inputBinding:
      position: 1
  - id: fasta
    type:
      - 'null'
      - File
    doc: The FASTA file to search in. If not provided, reads from standard 
      input.
    inputBinding:
      position: 2
  - id: description
    type:
      - 'null'
      - boolean
    doc: Search the description/comment fields of the FASTA file instead of the 
      sequences. If given, the pattern is interpreted as a regular expression, 
      not as a IUPAC pattern.
    inputBinding:
      position: 103
      prefix: --description
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sqt:v0.8.0-3-deb-py3_cv1
stdout: sqt_fastagrep.out
