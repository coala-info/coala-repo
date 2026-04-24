cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tracy
  - consensus
label: tracy_consensus
doc: "Generate a consensus sequence from two trace files\n\nTool homepage: https://github.com/gear-genomics/tracy"
inputs:
  - id: trace1
    type: File
    doc: First trace file (e.g., trace1.ab1)
    inputBinding:
      position: 1
  - id: trace2
    type: File
    doc: Second trace file (e.g., trace2.ab1)
    inputBinding:
      position: 2
  - id: gapext
    type:
      - 'null'
      - int
    doc: gap extension
    inputBinding:
      position: 103
      prefix: --gapext
  - id: gapopen
    type:
      - 'null'
      - int
    doc: gap open
    inputBinding:
      position: 103
      prefix: --gapopen
  - id: intersect
    type:
      - 'null'
      - boolean
    doc: use only trace intersection for consensus
    inputBinding:
      position: 103
      prefix: --intersect
  - id: iupac
    type:
      - 'null'
      - boolean
    doc: use IUPAC nucleotide code in consensus (max. 2 nucleotides)
    inputBinding:
      position: 103
      prefix: --iupac
  - id: label
    type:
      - 'null'
      - string
    doc: sample label
    inputBinding:
      position: 103
      prefix: --label
  - id: linelimit
    type:
      - 'null'
      - int
    doc: alignment line length
    inputBinding:
      position: 103
      prefix: --linelimit
  - id: match
    type:
      - 'null'
      - int
    doc: match
    inputBinding:
      position: 103
      prefix: --match
  - id: mismatch
    type:
      - 'null'
      - int
    doc: mismatch
    inputBinding:
      position: 103
      prefix: --mismatch
  - id: pratio
    type:
      - 'null'
      - float
    doc: peak ratio to call base
    inputBinding:
      position: 103
      prefix: --pratio
  - id: trim
    type:
      - 'null'
      - int
    doc: 'trimming stringency [1:9], 0: use trimLeft and trimRight'
    inputBinding:
      position: 103
      prefix: --trim
  - id: trim_left1
    type:
      - 'null'
      - int
    doc: trim size left (1st trace)
    inputBinding:
      position: 103
      prefix: --trimLeft1
  - id: trim_left2
    type:
      - 'null'
      - int
    doc: trim size left (2nd trace)
    inputBinding:
      position: 103
      prefix: --trimLeft2
  - id: trim_right1
    type:
      - 'null'
      - int
    doc: trim size right (1st trace)
    inputBinding:
      position: 103
      prefix: --trimRight1
  - id: trim_right2
    type:
      - 'null'
      - int
    doc: trim size right (2nd trace)
    inputBinding:
      position: 103
      prefix: --trimRight2
outputs:
  - id: outprefix
    type:
      - 'null'
      - File
    doc: output prefix
    outputBinding:
      glob: $(inputs.outprefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tracy:0.8.1--h4d20210_0
