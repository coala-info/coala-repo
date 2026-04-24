cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyling_tree
label: phyling_tree
doc: "Construct a phylogenetic tree by the selected multiple sequence alignment (MSA)
  results.\n\nTool homepage: https://github.com/stajichlab/Phyling"
inputs:
  - id: concat
    type:
      - 'null'
      - boolean
    doc: Concatenated alignment results
    inputBinding:
      position: 101
      prefix: --concat
  - id: figure
    type:
      - 'null'
      - boolean
    doc: Generate a matplotlib tree figure
    inputBinding:
      position: 101
      prefix: --figure
  - id: input_dir
    type: Directory
    doc: Directory containing multiple sequence alignment fasta of the markers
    inputBinding:
      position: 101
      prefix: --input_dir
  - id: inputs
    type:
      type: array
      items: File
    doc: Multiple sequence alignment fasta of the markers
    inputBinding:
      position: 101
      prefix: --inputs
  - id: method
    type:
      - 'null'
      - string
    doc: Algorithm used for tree building.
    inputBinding:
      position: 101
      prefix: --method
  - id: partition
    type:
      - 'null'
      - boolean
    doc: Partitioned analysis by sequence. Only works when --concat enabled.
    inputBinding:
      position: 101
      prefix: --partition
  - id: seed
    type:
      - 'null'
      - int
    doc: Seed number for stochastic elements during inferences.
    inputBinding:
      position: 101
      prefix: --seed
  - id: seqtype
    type:
      - 'null'
      - string
    doc: Input data sequence type
    inputBinding:
      position: 101
      prefix: --seqtype
  - id: threads
    type:
      - 'null'
      - int
    doc: Threads for tree construction
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode for debug
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Output directory of the newick treefile
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyling:2.3.1--pyhdfd78af_0
