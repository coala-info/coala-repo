cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqfold
label: seqfold
doc: "Predict the minimum free energy (kcal/mol) of a nucleic acid sequence\n\nTool
  homepage: https://github.com/Lattice-Automation/seqfold"
inputs:
  - id: seq
    type: string
    doc: nucleic acid sequence to fold
    inputBinding:
      position: 1
  - id: celcius
    type:
      - 'null'
      - float
    doc: temperature in Celsius
    inputBinding:
      position: 102
      prefix: --celcius
  - id: dot_bracket
    type:
      - 'null'
      - boolean
    doc: write a dot-bracket of the MFE folding to stdout
    inputBinding:
      position: 102
      prefix: --dot-bracket
  - id: sub_structures
    type:
      - 'null'
      - boolean
    doc: write each substructure of the MFE folding to stdout
    inputBinding:
      position: 102
      prefix: --sub-structures
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqfold:0.9.0--pyhdfd78af_0
stdout: seqfold.out
