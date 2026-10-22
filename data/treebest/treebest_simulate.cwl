cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - treebest
  - simulate
label: treebest_simulate
doc: "Simulate a gene tree.\n\nTool homepage: https://github.com/lh3/treebest"
inputs:
  - id: duplication_probability
    type:
      - 'null'
      - float
    doc: "duplication probability [0.05]"
    inputBinding:
      prefix: -d
  - id: loss_probability
    type:
      - 'null'
      - float
    doc: "loss probability [0.01]"
    inputBinding:
      prefix: -l
  - id: loss_after_duplication_probability
    type:
      - 'null'
      - float
    doc: "loss probability after duplication [0.25]"
    inputBinding:
      prefix: -p
  - id: max_height
    type:
      - 'null'
      - float
    doc: "max height [0.25]"
    inputBinding:
      prefix: -m
  - id: no_internal_names
    type:
      - 'null'
      - boolean
    doc: "not show internal name"
    inputBinding:
      prefix: -n
outputs:
  - id: stdout
    type: stdout
    doc: Simulated gene tree in NH format
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treebest:1.9.2_ep78--hfc679d8_2
stdout: treebest_simulate.out
