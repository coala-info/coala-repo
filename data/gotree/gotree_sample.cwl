cwlVersion: v1.2
class: CommandLineTool
baseCommand: gotree sample
label: gotree_sample
doc: "Takes a subsample of the set of trees from the input file.\n\nTool homepage:
  https://github.com/fredericlemoine/gotree"
inputs:
  - id: format
    type:
      - 'null'
      - string
    doc: Input tree format (newick, nexus, phyloxml, or nextstrain)
    inputBinding:
      position: 101
      prefix: --format
  - id: input
    type:
      - 'null'
      - File
    doc: Input reference trees
    inputBinding:
      position: 101
      prefix: --input
  - id: nbtrees
    type:
      - 'null'
      - int
    doc: Number of trees to sample from input file
    inputBinding:
      position: 101
      prefix: --nbtrees
  - id: replace
    type:
      - 'null'
      - boolean
    doc: If given, samples with replacement
    inputBinding:
      position: 101
      prefix: --replace
  - id: seed
    type:
      - 'null'
      - int
    doc: 'Random Seed: -1 = nano seconds since 1970/01/01 00:00:00'
    inputBinding:
      position: 101
      prefix: --seed
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads (Max=20)
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output trees
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gotree:0.5.1--he881be0_0
