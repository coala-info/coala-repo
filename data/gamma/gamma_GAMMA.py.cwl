cwlVersion: v1.2
class: CommandLineTool
baseCommand: GAMMA.py
label: gamma_GAMMA.py
doc: "This scripts makes annotated gene calls from matches in an assembly using a
  gene database\n\nTool homepage: https://github.com/rastanton/GAMMA"
inputs:
  - id: input_fasta
    type: File
    doc: input fasta
    inputBinding:
      position: 1
  - id: database
    type: File
    doc: input database
    inputBinding:
      position: 2
  - id: output
    type: string
    doc: output name
    inputBinding:
      position: 3
  - id: all
    type:
      - 'null'
      - boolean
    doc: include all gene matches, even overlaps
    inputBinding:
      position: 104
      prefix: --all
  - id: extended
    type:
      - 'null'
      - boolean
    doc: writes out all protein mutations
    inputBinding:
      position: 104
      prefix: --extended
  - id: fasta
    type:
      - 'null'
      - boolean
    doc: write fasta of gene matches
    inputBinding:
      position: 104
      prefix: --fasta
  - id: gff
    type:
      - 'null'
      - boolean
    doc: write gene matches as gff file
    inputBinding:
      position: 104
      prefix: --gff
  - id: headless
    type:
      - 'null'
      - boolean
    doc: removes the header from the output gamma file
    inputBinding:
      position: 104
      prefix: --headless
  - id: name
    type:
      - 'null'
      - boolean
    doc: writes name in front of each gene match line
    inputBinding:
      position: 104
      prefix: --name
  - id: percent_identity
    type:
      - 'null'
      - float
    doc: minimum nucleotide identity for blat search
    default: 90
    inputBinding:
      position: 104
      prefix: --percent_identity
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gamma:2.2--hdfd78af_1
stdout: gamma_GAMMA.py.out
