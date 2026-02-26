cwlVersion: v1.2
class: CommandLineTool
baseCommand: parebrick
label: parebrick
doc: "Based on synteny blocks and phylogenetic tree this tool calls parallel rearrangements
  (not consistent with phylogenetic tree).\n\nTool homepage: https://github.com/ctlab/parallel-rearrangements"
inputs:
  - id: blocks_folder
    type: Directory
    doc: Path to folder with blocks resulted as output of original Sibelia or 
      maf2synteny tool.
    inputBinding:
      position: 101
      prefix: --blocks_folder
  - id: clustering_threshold
    type:
      - 'null'
      - float
    doc: Threshold for algorithm of clustering, default is 0.025.Can be 
      increased for getting larger clusters or decreased for getting smaller and
      more grouped clusters.
    default: 0.025
    inputBinding:
      position: 101
      prefix: --clustering_threshold
  - id: clustering_tree_patterns_coef
    type:
      - 'null'
      - float
    doc: Coefficient (0-1) of weight of tree patterns similarity in clustering 
      in unbalanced (copy number variation) module.Rest of weight will be used 
      in distance between blocks.E.g. if set to 0.8 (default) distance between 
      blocks coefficient will be set to 0.2.
    inputBinding:
      position: 101
      prefix: --clustering_tree_patterns_coef
  - id: filter_for_balanced
    type:
      - 'null'
      - int
    doc: Minimal percentage of block occurrences in genomes for balanced 
      rearrangements. All blocks with lower occurrences rate will be removed.
    default: 80
    inputBinding:
      position: 101
      prefix: --filter_for_balanced
  - id: keep_non_parallel
    type:
      - 'null'
      - boolean
    doc: Keep rearrangements that are not parallel in result (consistent with 
      phylogenetic tree).
    default: true
    inputBinding:
      position: 101
      prefix: --keep_non_parallel
  - id: labels
    type:
      - 'null'
      - File
    doc: 'Path to csv file with tree labels, must contain two columns: `strain` and
      `label`.'
    inputBinding:
      position: 101
      prefix: --labels
  - id: show_branch_support
    type:
      - 'null'
      - boolean
    doc: Show branch support while tree rendering (ete3 parameter).
    default: false
    inputBinding:
      position: 101
      prefix: --show_branch_support
  - id: tree
    type: File
    doc: Tree in newick format, must be parsable by ete3 library.You can read 
      more about formats supported by ete3 at 
      http://etetoolkit.org/docs/latest/tutorial/tutorial_trees.html#reading-and-writing-newick-trees
    inputBinding:
      position: 101
      prefix: --tree
  - id: visualize_neighbours
    type:
      - 'null'
      - boolean
    doc: Use module for visualizing neighbours.
    default: true
    inputBinding:
      position: 101
      prefix: --visualize_neighbours
  - id: which_chr
    type:
      - 'null'
      - boolean
    doc: Use information about in which chromosome block is located.
    default: false
    inputBinding:
      position: 101
      prefix: --which_chr
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Path to output folder.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/parebrick:0.5.7--pyhdfd78af_0
