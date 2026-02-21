cwlVersion: v1.2
class: CommandLineTool
baseCommand: amplisim
label: amplisim
doc: "a program to simulate amplicon sequences from a reference genome\n\nTool homepage:
  https://github.com/rki-mf1/amplisim"
inputs:
  - id: reference
    type: File
    doc: Reference genome
    inputBinding:
      position: 1
  - id: primers
    type: File
    doc: Primers file
    inputBinding:
      position: 2
  - id: dropout
    type:
      - 'null'
      - int
    doc: Set the likelihood for an amplicon dropout [0,1]
    inputBinding:
      position: 103
      prefix: --dropout
  - id: mean
    type:
      - 'null'
      - int
    doc: Set the mean number of replicates per amplicon
    inputBinding:
      position: 103
      prefix: --mean
  - id: sd
    type:
      - 'null'
      - int
    doc: Set the standard deviation for the mean number of replicates per amplicon
    inputBinding:
      position: 103
      prefix: --sd
  - id: seed
    type:
      - 'null'
      - int
    doc: Set a random seed
    inputBinding:
      position: 103
      prefix: --seed
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output to FILE instead of standard output
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amplisim:0.2.1--h69ac913_3
