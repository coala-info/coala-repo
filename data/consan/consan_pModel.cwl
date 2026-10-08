cwlVersion: v1.2
class: CommandLineTool
baseCommand: pModel
label: consan_pModel
doc: "Print the parameters of a Consan model file (transition, pairwise emission, alignment
  emission and background parameters) as probabilities and/or scores. Defaults to printing
  all parameters as probs.\n\nTool homepage: http://eddylab.org/software/consan/"
inputs:
  - id: modfile
    type: File
    doc: Consan model file (for example from strain_ml -s)
    inputBinding:
      position: 201
  - id: transitions
    type:
      - 'null'
      - boolean
    doc: Print transition parameters
    inputBinding:
      position: 103
      prefix: -t
  - id: pair_emissions
    type:
      - 'null'
      - boolean
    doc: Print 16x16 pairwise emission parameters
    inputBinding:
      position: 103
      prefix: -x
  - id: alignment_emissions
    type:
      - 'null'
      - boolean
    doc: Print 4x4 alignment emission parameters
    inputBinding:
      position: 103
      prefix: -f
  - id: background
    type:
      - 'null'
      - boolean
    doc: Print 4 background (to gap) parameters
    inputBinding:
      position: 103
      prefix: -d
  - id: scores
    type:
      - 'null'
      - boolean
    doc: Print parameters as scores (defaults to as probs)
    inputBinding:
      position: 103
      prefix: -q
  - id: probs_and_scores
    type:
      - 'null'
      - boolean
    doc: Print parameters as both probs and scores
    inputBinding:
      position: 103
      prefix: -S
  - id: linearize
    type:
      - 'null'
      - boolean
    doc: Linearize output for gnuplot (not valid with -q or -S)
    inputBinding:
      position: 103
      prefix: -l
  - id: labels
    type:
      - 'null'
      - boolean
    doc: Include labels in linear output
    inputBinding:
      position: 103
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: model parameters
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/consan:1.2--h7b50bb2_7
stdout: consan_pModel.out
