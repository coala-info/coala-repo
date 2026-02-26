cwlVersion: v1.2
class: CommandLineTool
baseCommand: zorro
label: zorro
doc: "ZORRO Options\n\nTool homepage: https://sourceforge.net/projects/probmask/"
inputs:
  - id: filename
    type: File
    doc: Input filename
    inputBinding:
      position: 1
  - id: guide_treefile
    type:
      - 'null'
      - File
    doc: User provided guide tree
    inputBinding:
      position: 102
      prefix: -guide
  - id: ignoregaps
    type:
      - 'null'
      - boolean
    doc: Ignore pair-gaps in columns when calculating column confidences
    default: false
    inputBinding:
      position: 102
      prefix: -ignoregaps
  - id: nosample
    type:
      - 'null'
      - boolean
    doc: No Sampling i.e. using every pair to calculate alignment reliabilty
    default: true
    inputBinding:
      position: 102
      prefix: -nosample
  - id: noweighting
    type:
      - 'null'
      - boolean
    doc: Using sum of pairs instead of weighted sum of pairs to calculate column
      confidence
    default: false
    inputBinding:
      position: 102
      prefix: -noweighting
  - id: nsample
    type:
      - 'null'
      - int
    doc: 'Tells ZORRO to sample #NUMBER pairs when sampling, automatically turns on
      -sample option'
    default: 10*Nseq
    inputBinding:
      position: 102
      prefix: -Nsample
  - id: sample
    type:
      - 'null'
      - boolean
    doc: Sampling pairs to calculate alignment reliabilty
    default: false
    inputBinding:
      position: 102
      prefix: -sample
  - id: treeprog
    type:
      - 'null'
      - string
    doc: Tells ZORRO to use PROGRAM instead of the default FastTree to create 
      guide tree
    default: FastTree
    inputBinding:
      position: 102
      prefix: -treeprog
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/zorro:2011.12.01--h7b50bb2_5
stdout: zorro.out
