cwlVersion: v1.2
class: CommandLineTool
baseCommand: clermontyping_clermonTyping.sh
label: clermontyping_clermonTyping.sh
doc: "Missing the contigs file. Option --fasta or --fastafile\n\nTool homepage: https://github.com/happykhan/ClermonTyping"
inputs:
  - id: fasta
    type:
      - 'null'
      - type: array
        items: File
    doc: fasta contigs file(s). If multiple files, they must be separated by an 
      arobase (@) value
    inputBinding:
      position: 101
      prefix: --fasta
  - id: fastafile
    type:
      - 'null'
      - type: array
        items: File
    doc: file with path of fasta contig file. One file by line (optional)
    inputBinding:
      position: 101
      prefix: --fastafile
  - id: minimal
    type:
      - 'null'
      - boolean
    doc: output a minimal set of files (optional)
    inputBinding:
      position: 101
      prefix: --minimal
  - id: name
    type:
      - 'null'
      - string
    doc: name for this analysis (optional)
    inputBinding:
      position: 101
      prefix: --name
  - id: summary
    type:
      - 'null'
      - type: array
        items: File
    doc: file with path of *_phylogroups.txt. One file by line (optional)
    inputBinding:
      position: 101
      prefix: --summary
  - id: threshold
    type:
      - 'null'
      - string
    doc: option for ClermontTyping, do not use contigs under this size 
      (optional)
    inputBinding:
      position: 101
      prefix: --threshold
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clermontyping:24.02--py312hdfd78af_1
stdout: clermontyping_clermonTyping.sh.out
