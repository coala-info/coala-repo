cwlVersion: v1.2
class: CommandLineTool
baseCommand: cluster-picker
label: cluster-picker
doc: "Cluster Picker identifies clusters in a phylogenetic tree whose subtrees have
  node support above a threshold and maximum pairwise genetic distance below a threshold.
  Arguments are positional: sequences.fas tree.nwk initial_support main_support
  genetic_distance large_cluster_size [difference_type]. Output files are named after
  the tree and alignment file names (<tree>_clusterPicks.nwk, <tree>_clusterPicks_log.txt,
  <fasta>_<tree>_clusterPicks.fas and per-cluster sequence lists).\n\nTool homepage:
  http://hiv.bio.ed.ac.uk/software.html"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.sequences)
      - $(inputs.input_tree)
inputs:
  - id: sequences
    type: File
    doc: Aligned sequences in FASTA format (should have .fas extension); names must
      match the tree tip names
    inputBinding:
      position: 1
  - id: input_tree
    type: File
    doc: Newick format tree, with branch lengths and node support (should have 
      .nwk extension)
    inputBinding:
      position: 2
  - id: initial_support_threshold
    type: float
    doc: Initial support threshold used to break the tree into initial subtrees 
      (support values out of 1 for FastTree, out of 100 for RAxML)
    default: 0.9
    inputBinding:
      position: 3
  - id: main_support_threshold
    type: float
    doc: Main support threshold for clusters
    default: 0.9
    inputBinding:
      position: 4
  - id: genetic_distance_threshold
    type: float
    doc: Maximum pairwise genetic distance threshold for clusters (fraction, e.g. 
      0.045)
    default: 0.045
    inputBinding:
      position: 5
  - id: large_cluster_threshold
    type: int
    doc: Write cluster membership lists for clusters with at least this many 
      members (0 writes none)
    default: 10
    inputBinding:
      position: 6
  - id: difference_type
    type:
      - 'null'
      - string
    doc: 'Scoring type for genetic distance: abs (count absolute character differences),
      gap (disregard sites with -, ~, or n; default), valid (only count sites with a,
      c, t, g in both sequences) or ambiguity (as gap and do not count ambiguities as
      differences)'
    inputBinding:
      position: 7
outputs:
  - id: cluster_tree
    type: File
    doc: Tree with tips renamed by cluster assignment
    outputBinding:
      glob: $(inputs.input_tree.nameroot)_clusterPicks.nwk
  - id: cluster_figtree
    type:
      - 'null'
      - File
    doc: FigTree file with cluster annotation
    outputBinding:
      glob: $(inputs.input_tree.nameroot)_clusterPicks.nwk.figTree
  - id: cluster_log
    type: File
    doc: Log with parameters and the list of clusters found
    outputBinding:
      glob: $(inputs.input_tree.nameroot)_clusterPicks_log.txt
  - id: cluster_sequences
    type: File
    doc: Sequences renamed by cluster assignment
    outputBinding:
      glob: $(inputs.sequences.nameroot)_$(inputs.input_tree.nameroot)_clusterPicks.fas
  - id: cluster_sequence_lists
    type:
      type: array
      items: File
    doc: Membership lists for large clusters
    outputBinding:
      glob: '*_clusterPicks_cluster*_sequenceList.txt'
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cluster-picker:1.2.3--0
stdout: cluster-picker.out
