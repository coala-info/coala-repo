cwlVersion: v1.2
class: CommandLineTool
baseCommand: odgi prune
label: odgi_prune
doc: "Remove parts of the graph.\n\nTool homepage: https://github.com/vgteam/odgi"
inputs:
  - id: best_edges
    type:
      - 'null'
      - int
    doc: Only keep the *N* most covered inbound and output edges of each node.
    inputBinding:
      position: 101
      prefix: --best-edges
  - id: cut_tips
    type:
      - 'null'
      - boolean
    doc: Remove nodes which are graph tips.
    inputBinding:
      position: 101
      prefix: --cut-tips
  - id: cut_tips_min_depth
    type:
      - 'null'
      - int
    doc: Remove nodes which are graph tips and have less than *N* path depth.
    inputBinding:
      position: 101
      prefix: --cut-tips-min-depth
  - id: drop_all_paths
    type:
      - 'null'
      - boolean
    doc: Remove all paths from the graph.
    inputBinding:
      position: 101
      prefix: --drop-all-paths
  - id: drop_empty_paths
    type:
      - 'null'
      - boolean
    doc: Remove empty paths from the graph.
    inputBinding:
      position: 101
      prefix: --drop-empty-paths
  - id: drop_paths
    type:
      - 'null'
      - File
    doc: List of paths to remove. The FILE must contain one path name per line 
      and a subset of all paths can be specified.
    inputBinding:
      position: 101
      prefix: --drop-paths
  - id: edge_depth
    type:
      - 'null'
      - boolean
    doc: Remove edges outside of the minimum and maximum coverage rather than 
      nodes. Only set this argument in combination with **-c, 
      –min-coverage**=*N* and **-C, --max-coverage**=*N*.
    inputBinding:
      position: 101
      prefix: --edge-depth
  - id: expand_length
    type:
      - 'null'
      - int
    doc: Also include nodes within this graph nucleotide distance of a component
      passing the prune thresholds.
    inputBinding:
      position: 101
      prefix: --expand-length
  - id: expand_path_length
    type:
      - 'null'
      - int
    doc: Also include nodes within this path length of a component passing the 
      prune thresholds.
    inputBinding:
      position: 101
      prefix: --expand-path-length
  - id: expand_steps
    type:
      - 'null'
      - int
    doc: Also include nodes within this many steps of a component passing the 
      prune thresholds.
    inputBinding:
      position: 101
      prefix: --expand-steps
  - id: idx
    type: File
    doc: Load the succinct variation graph in ODGI format from this *FILE*. The 
      file name usually ends with *.og*. It also accepts GFAv1, but the 
      on-the-fly conversion to the ODGI format requires additional time!
    inputBinding:
      position: 101
      prefix: --idx
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: The length of the kmers to consider.
    inputBinding:
      position: 101
      prefix: --kmer-length
  - id: max_degree
    type:
      - 'null'
      - int
    doc: Remove nodes that have a higher node degree than *N*.
    inputBinding:
      position: 101
      prefix: --max-degree
  - id: max_depth
    type:
      - 'null'
      - int
    doc: Remove nodes covered by more than *N* number of path steps.
    inputBinding:
      position: 101
      prefix: --max-depth
  - id: max_furcations
    type:
      - 'null'
      - int
    doc: Break at edges that would induce *N* many furcations in a kmer.
    inputBinding:
      position: 101
      prefix: --max-furcations
  - id: min_depth
    type:
      - 'null'
      - int
    doc: Remove nodes covered by fewer than *N* number of path steps.
    inputBinding:
      position: 101
      prefix: --min-depth
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Write the current progress to stderr.
    inputBinding:
      position: 101
      prefix: --progress
  - id: remove_isolated
    type:
      - 'null'
      - boolean
    doc: Remove isolated nodes covered by a single path.
    inputBinding:
      position: 101
      prefix: --remove-isolated
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for parallel operations.
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: out
    type: File
    doc: Write the pruned graph in ODGI format to *FILE*. A file ending with 
      *.og* is recommended.
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
