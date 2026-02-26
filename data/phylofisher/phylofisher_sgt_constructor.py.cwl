cwlVersion: v1.2
class: CommandLineTool
baseCommand: sgt_constructor.py
label: phylofisher_sgt_constructor.py
doc: "Aligns, trims, and builds single gene trees from unaligned gene files.\n\nTool
  homepage: https://github.com/TheBrownLab/PhyloFisher"
inputs:
  - id: in_format
    type:
      - 'null'
      - string
    doc: 'Format of the input files. Options: fasta, phylip (names truncated at 10
      characters), phylip-relaxed (names are not truncated), or nexus.'
    default: fasta
    inputBinding:
      position: 101
      prefix: --in_format
  - id: input_dir
    type: Directory
    doc: Path to input directory
    inputBinding:
      position: 101
      prefix: --input
  - id: no_trees
    type:
      - 'null'
      - boolean
    doc: Do NOT build single gene trees. Length filtration and trimmming only.
    inputBinding:
      position: 101
      prefix: --no_trees
  - id: threads
    type:
      - 'null'
      - int
    doc: Desired number of threads to be utilized.
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: trees_only
    type:
      - 'null'
      - boolean
    doc: Only build single gene trees. No length filtration and trimming.
    inputBinding:
      position: 101
      prefix: --trees_only
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Path to user-defined output directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylofisher:1.2.14--pyhdfd78af_0
