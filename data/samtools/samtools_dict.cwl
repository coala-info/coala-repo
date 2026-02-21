cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - samtools
  - dict
label: samtools_dict
doc: "Create a sequence dictionary file from a fasta file\n\nTool homepage: https://github.com/samtools/samtools"
inputs:
  - id: fasta_file
    type: File
    doc: Input fasta file (can be gzipped)
    inputBinding:
      position: 1
  - id: alias
    type:
      - 'null'
      - boolean
    doc: add AN tag by adding/removing 'chr'
    inputBinding:
      position: 102
      prefix: --alias
  - id: alt_file
    type:
      - 'null'
      - File
    doc: add AH:* tag to alternate locus sequences
    inputBinding:
      position: 102
      prefix: --alt
  - id: assembly
    type:
      - 'null'
      - string
    doc: assembly
    inputBinding:
      position: 102
      prefix: --assembly
  - id: no_header
    type:
      - 'null'
      - boolean
    doc: do not print @HD line
    inputBinding:
      position: 102
      prefix: --no-header
  - id: species
    type:
      - 'null'
      - string
    doc: species
    inputBinding:
      position: 102
      prefix: --species
  - id: uri
    type:
      - 'null'
      - string
    doc: URI
    inputBinding:
      position: 102
      prefix: --uri
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: file to write out dict file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
