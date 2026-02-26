cwlVersion: v1.2
class: CommandLineTool
baseCommand: odgi_stats
label: odgi_stats
doc: "Metrics describing a variation graph and its path relationship.\n\nTool homepage:
  https://github.com/vgteam/odgi"
inputs:
  - id: base_content
    type:
      - 'null'
      - boolean
    doc: 'Describe the base content of the graph. Print to stdout the #A, #C, #G and
      #T in a tab-delimited format.'
    inputBinding:
      position: 101
      prefix: --base-content
  - id: coords_in
    type:
      - 'null'
      - File
    doc: Load the 2D layout coordinates in binary layout format from this 
      *FILE*. The file name usually ends with *.lay*. The sorting goodness 
      evaluation will then be performed for this *FILE*. When the layout 
      coordinates are provided, the mean links length and the sum path nodes 
      distances statistics are evaluated in 2D, else in 1D. Such a file can be 
      generated with *odgi layout*.
    inputBinding:
      position: 101
      prefix: --coords-in
  - id: delim
    type:
      - 'null'
      - string
    doc: The part of each path name before this delimiter is a group identifier,
      which when specified will ensure that odgi stats collects the summary 
      information per group and not per path.
    inputBinding:
      position: 101
      prefix: --delim
  - id: file_size
    type:
      - 'null'
      - boolean
    doc: Show the file size in bytes.
    inputBinding:
      position: 101
      prefix: --file-size
  - id: idx
    type: File
    doc: Load the succinct variation graph in ODGI format from this *FILE*. The 
      file name usually ends with *.og*. It also accepts GFAv1, but the 
      on-the-fly conversion to the ODGI format requires additional time!
    inputBinding:
      position: 101
      prefix: --idx
  - id: links_length_per_nuc
    type:
      - 'null'
      - boolean
    doc: Compute the links length per nucleotide, i.e. sum up the links lengths 
      of all paths and divide this value by the nucleotide lengths of all paths.
      This metric can be used to compare the linearity of different graphs. By 
      default we don't count gap links.
    inputBinding:
      position: 101
      prefix: --links_length_per_nuc
  - id: mean_links_length
    type:
      - 'null'
      - boolean
    doc: Calculate the mean links length. This metric is path-guided and 
      computable in 1D and 2D.
    inputBinding:
      position: 101
      prefix: --mean-links-length
  - id: multiqc
    type:
      - 'null'
      - boolean
    doc: Setting this option prints all! statistics in YAML format instead of 
      pseudo TSV to stdout. This includes *-S,--summarize*, 
      *-W,--weak-connected-components*, *-L,--self-loops*, *-b,--base-content*, 
      *-l,--mean-links-length*, *-g,--no-gap-links*, 
      *-s,--sum-path-nodes-distances*, *-f,--file-size*, and 
      *-d,--penalize-different-orientation*. *-p,path-statistics* is still 
      optional. Not applicable to *-N,--nondeterministic-edges*. Overwrites all 
      other given OPTIONs! The output is perfectly curated for the ODGI MultiQC 
      module.
    inputBinding:
      position: 101
      prefix: --multiqc
  - id: no_gap_links
    type:
      - 'null'
      - boolean
    doc: Don’t penalize gap links in the mean links length. A gap link is a link
      which connects two nodes that are consecutive in the linear pangenomic 
      order. This option is specifiable only to compute the mean links length in
      1D.
    inputBinding:
      position: 101
      prefix: --no-gap-links
  - id: nondeterministic_edges
    type:
      - 'null'
      - boolean
    doc: Show nondeterministic edges (those that extend to the same next base).
    inputBinding:
      position: 101
      prefix: --nondeterministic-edges
  - id: pangenome_sequence_class_counts
    type:
      - 'null'
      - string
    doc: 'Show counted pangenome sequence class counts of all samples. Classes are
      Private (only one sample visiting the node), Core (all samples visiting the
      node), and Shell (not Core or Private). The given String determines how to find
      the sample name in the path names: DELIM,POS. Split the whole path name by DELIM
      and access the actual sample name at POS of the split result. If the full path
      name is the sample name, select a DELIM that is not in the path names and set
      POS to 0. If -m,--multiqc was set, this OPTION has to be set implicitly.'
    inputBinding:
      position: 101
      prefix: --pangenome-sequence-class-counts
  - id: path_statistics
    type:
      - 'null'
      - boolean
    doc: Display the statistics (mean links length or sum path nodes distances) 
      for each path.
    inputBinding:
      position: 101
      prefix: --path-statistics
  - id: penalize_different_orientation
    type:
      - 'null'
      - boolean
    doc: If a link connects two nodes which have different orientations, this is
      penalized (adding 2 times its length in the sum).
    inputBinding:
      position: 101
      prefix: --penalize-different-orientation
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Write the current progress to stderr.
    inputBinding:
      position: 101
      prefix: --progress
  - id: self_loops
    type:
      - 'null'
      - boolean
    doc: Number of nodes with a self-loop.
    inputBinding:
      position: 101
      prefix: --self-loops
  - id: sum_path_nodes_distances
    type:
      - 'null'
      - boolean
    doc: Calculate the sum of path nodes distances. This metric is path-guided 
      and computable in 1D and 2D. For each path, it iterates from node to node,
      summing their distances, and normalizing by the path length. In 1D, if a 
      link goes back in the linearized viewpoint of the graph, this is penalized
      (adding 3 times its length in the sum).
    inputBinding:
      position: 101
      prefix: --sum-path-nodes-distances
  - id: summarize
    type:
      - 'null'
      - boolean
    doc: 'Summarize the graph properties and dimensions. Print to stdout the #nucleotides,
      #nodes, #edges, #paths, #steps in a tab-delimited format.'
    inputBinding:
      position: 101
      prefix: --summarize
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for parallel operations.
    inputBinding:
      position: 101
      prefix: --threads
  - id: weak_connected_components
    type:
      - 'null'
      - boolean
    doc: Shows the properties of the weakly connected components.
    inputBinding:
      position: 101
      prefix: --weak-connected-components
  - id: weighted_feedback_arc
    type:
      - 'null'
      - boolean
    doc: Compute the sum of weights of all feedback arcs, i.e. backward pointing
      edges the statistics (the weight is the number of times the edge is 
      traversed by paths).
    inputBinding:
      position: 101
      prefix: --weighted-feedback-arc
  - id: weighted_reversing_join
    type:
      - 'null'
      - boolean
    doc: Compute the sum of weights of all reversing joins, i.e. edges joining 
      two in- or two out-sides (the weight is the number of times the edge is 
      traversed by paths).
    inputBinding:
      position: 101
      prefix: --weighted-reversing-join
  - id: yaml
    type:
      - 'null'
      - boolean
    doc: Setting this option prints all selected statistics in YAML format 
      instead of pseudo TSV to stdout.
    inputBinding:
      position: 101
      prefix: --yaml
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
stdout: odgi_stats.out
