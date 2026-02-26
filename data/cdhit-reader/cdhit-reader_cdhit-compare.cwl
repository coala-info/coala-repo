cwlVersion: v1.2
class: CommandLineTool
baseCommand: cdhit-compare
label: cdhit-reader_cdhit-compare
doc: "Compare FASTA files\n\nTool homepage: https://github.com/telatin/cdhit-parser"
inputs:
  - id: fasta1
    type: File
    doc: First FASTA file
    inputBinding:
      position: 1
  - id: fasta2
    type: File
    doc: Second FASTA file
    inputBinding:
      position: 2
  - id: id
    type:
      - 'null'
      - float
    doc: Identity threshold
    default: 0.9
    inputBinding:
      position: 103
      prefix: --id
  - id: tag1
    type:
      - 'null'
      - string
    doc: Name of the first dataset
    inputBinding:
      position: 103
      prefix: --tag1
  - id: tag2
    type:
      - 'null'
      - string
    doc: Name of the second dataset
    inputBinding:
      position: 103
      prefix: --tag2
  - id: tempdir
    type:
      - 'null'
      - Directory
    doc: Temporary directory for intermediate files
    inputBinding:
      position: 103
      prefix: --tempdir
  - id: type
    type:
      - 'null'
      - string
    doc: Type of the sequences (nucl or prot)
    inputBinding:
      position: 103
      prefix: --type
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Show verbose information
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cdhit-reader:0.2.0--pyhdfd78af_0
stdout: cdhit-reader_cdhit-compare.out
