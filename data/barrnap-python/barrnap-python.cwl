cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - barrnap.py
label: barrnap-python
doc: "barrnap 0.0.5 ported to python3 - rapid ribosomal RNA prediction. Predicts rRNA\
  \ genes in FASTA sequences and writes GFF3.\n\nTool homepage: https://github.com/nickp60/barrnap-python"
inputs:
  - id: fasta
    type: File
    doc: Input chromosome FASTA file
    inputBinding:
      position: 2
  - id: kingdom
    type:
      - 'null'
      - string
    doc: 'whether to look for eukaryotic, archaeal, or bacterial rDNA (bac, euk, arc,
      mito); default: bac'
    inputBinding:
      position: 1
      prefix: --kingdom
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads/cores/CPUs to use; default: 8'
    inputBinding:
      position: 1
      prefix: --threads
  - id: evalue
    type:
      - 'null'
      - float
    doc: 'Similarity e-value cut-off; default: 1e-06'
    inputBinding:
      position: 1
      prefix: --evalue
  - id: lencutoff
    type:
      - 'null'
      - float
    doc: 'Proportional length threshold to label as partial; default: 0.8'
    inputBinding:
      position: 1
      prefix: --lencutoff
  - id: reject
    type:
      - 'null'
      - float
    doc: 'Proportional length threshold to reject prediction; default: 0.5'
    inputBinding:
      position: 1
      prefix: --reject
  - id: incseq
    type:
      - 'null'
      - boolean
    doc: Include FASTA input sequences in GFF3 output
    inputBinding:
      position: 1
      prefix: --incseq
outputs:
  - id: gff
    type: stdout
    doc: Predicted rRNA features in GFF3 format
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/barrnap-python:0.0.5--py36_1
stdout: $(inputs.fasta.nameroot).rrna.gff3
