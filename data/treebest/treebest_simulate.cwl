cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - treebest
  - simulate
label: treebest_simulate
doc: "Simulate gene trees given a species tree using a duplication-loss model.\n\n
  Tool homepage: https://github.com/lh3/treebest"
inputs:
  - id: species_tree
    type: File
    doc: Input species tree in Newick format
    inputBinding:
      position: 1
  - id: duplication_rate
    type:
      - 'null'
      - float
    doc: Gene duplication rate
    inputBinding:
      position: 102
      prefix: -d
  - id: loss_rate
    type:
      - 'null'
      - float
    doc: Gene loss rate
    inputBinding:
      position: 102
      prefix: -l
  - id: num_trees
    type:
      - 'null'
      - int
    doc: Number of gene trees to simulate
    inputBinding:
      position: 102
      prefix: -n
  - id: rate_scale
    type:
      - 'null'
      - float
    doc: Substitution rate scale (branch length scaling factor)
    inputBinding:
      position: 102
      prefix: -s
  - id: seed
    type:
      - 'null'
      - int
    doc: Random seed for simulation
    inputBinding:
      position: 102
      prefix: -S
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file to write simulated trees
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treebest:1.9.2_ep78--hfc679d8_2
