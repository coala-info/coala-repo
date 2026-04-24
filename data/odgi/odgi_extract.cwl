cwlVersion: v1.2
class: CommandLineTool
baseCommand: odgi extract
label: odgi_extract
doc: "Extract subgraphs or parts of a graph defined by query criteria.\n\nTool homepage:
  https://github.com/vgteam/odgi"
inputs:
  - id: bed_file
    type:
      - 'null'
      - File
    doc: Find the node(s) in the path range(s) specified in the given BED FILE.
    inputBinding:
      position: 101
      prefix: --bed-file
  - id: context_bases
    type:
      - 'null'
      - int
    doc: The number of bases away from our initial subgraph that we should 
      collect
    inputBinding:
      position: 101
      prefix: --context-bases
  - id: context_steps
    type:
      - 'null'
      - int
    doc: The number of steps (nodes) away from our initial subgraph that we 
      should collect
    inputBinding:
      position: 101
      prefix: --context-steps
  - id: full_range
    type:
      - 'null'
      - boolean
    doc: Collects all nodes in the sorted order of the graph in the min and max 
      positions touched by the given path ranges. This ensures that all the 
      paths of the subgraph are not split by node, but that the nodes are laced 
      together again. Comparable to **-R, --lace-paths=FILE**, but specifically 
      for all paths in the resulting subgraph. Be careful to use it with very 
      complex graphs.
    inputBinding:
      position: 101
      prefix: --full-range
  - id: input_graph_file
    type: File
    doc: Load the succinct variation graph in ODGI format from this *FILE*. The 
      file name usually ends with *.og*. It also accepts GFAv1, but the 
      on-the-fly conversion to the ODGI format requires additional time!
    inputBinding:
      position: 101
      prefix: --idx
  - id: inverse
    type:
      - 'null'
      - boolean
    doc: Extract the parts of the graph that do not meet the query criteria.
    inputBinding:
      position: 101
      prefix: --inverse
  - id: lace_paths_file
    type:
      - 'null'
      - File
    doc: List of paths to fully retain in the extracted graph. Must contain one 
      path name per line and a subset of all paths can be specified.
    inputBinding:
      position: 101
      prefix: --lace-paths
  - id: max_distance_subpaths
    type:
      - 'null'
      - int
    doc: Maximum distance between subpaths allowed for merging them. It reduces 
      the fragmentation of unspecified paths in the input path ranges. Set 0 to 
      disable it
    inputBinding:
      position: 101
      prefix: --max-distance-subpaths
  - id: max_merging_iterations
    type:
      - 'null'
      - int
    doc: Maximum number of iterations in attempting to merge close subpaths. It 
      stops early if during an iteration no subpaths were merged
    inputBinding:
      position: 101
      prefix: --max-merging-iterations
  - id: node_id
    type:
      - 'null'
      - string
    doc: A single node ID from which to begin our traversal.
    inputBinding:
      position: 101
      prefix: --node
  - id: node_list_file
    type:
      - 'null'
      - File
    doc: A file with one node id per line. The node specified will be extracted 
      from the input graph.
    inputBinding:
      position: 101
      prefix: --node-list
  - id: optimize
    type:
      - 'null'
      - boolean
    doc: Compact the node ID space in the extracted graph(s).
    inputBinding:
      position: 101
      prefix: --optimize
  - id: pangenomic_range
    type:
      - 'null'
      - string
    doc: Find the node(s) in the specified pangenomic range pos1-pos2 (0-based 
      coordinates). The nucleotide positions refer to the pangenome’s sequence 
      (i.e., the sequence obtained arranging all the graph’s node from left to 
      right).
    inputBinding:
      position: 101
      prefix: --pangenomic-range
  - id: path_range
    type:
      - 'null'
      - string
    doc: Find the node(s) in the specified path range TARGET=path[:pos1[-pos2]] 
      (0-based coordinates).
    inputBinding:
      position: 101
      prefix: --path-range
  - id: paths_to_extract_file
    type:
      - 'null'
      - File
    doc: List of paths to keep in the extracted graph. The FILE must contain one
      path name per line and a subset of all paths can be specified. Paths 
      specified in the input path ranges (with -r/--path-range and/or 
      -b/--bed-file) will be kept in any case.
    inputBinding:
      position: 101
      prefix: --paths-to-extract
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Print information about the operations and the progress to stderr.
    inputBinding:
      position: 101
      prefix: --progress
  - id: split_subgraphs
    type:
      - 'null'
      - boolean
    doc: Instead of writing the target subgraphs into a single graph, write one 
      subgraph per given target to a separate file named path:start-end.og 
      (0-based coordinates).
    inputBinding:
      position: 101
      prefix: --split-subgraphs
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for parallel operations.
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Store all subgraphs in this FILE. The file name usually ends with 
      *.og*.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
