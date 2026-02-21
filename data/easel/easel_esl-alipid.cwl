cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - esl-alipid
label: easel_esl-alipid
doc: "Calculate pairwise percent identities for a multiple sequence alignment\n\n
  Tool homepage: https://github.com/EddyRivasLab/easel"
inputs:
  - id: msafile
    type: File
    doc: The multiple sequence alignment file
    inputBinding:
      position: 1
  - id: amino
    type:
      - 'null'
      - boolean
    doc: Assert that the alignment is protein
    inputBinding:
      position: 102
      prefix: --amino
  - id: dna
    type:
      - 'null'
      - boolean
    doc: Assert that the alignment is DNA
    inputBinding:
      position: 102
      prefix: --dna
  - id: inform
    type:
      - 'null'
      - string
    doc: Specify that input alignment is in format <s>
    inputBinding:
      position: 102
      prefix: --inform
  - id: rna
    type:
      - 'null'
      - boolean
    doc: Assert that the alignment is RNA
    inputBinding:
      position: 102
      prefix: --rna
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/easel:0.49--hb6cb901_3
stdout: easel_esl-alipid.out
