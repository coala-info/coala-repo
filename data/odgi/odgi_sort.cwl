cwlVersion: v1.2
class: CommandLineTool
baseCommand: odgi sort
label: odgi_sort
doc: "Apply different kind of sorting algorithms to a graph. The most prominent one
  is the PG-SGD sorting algorithm.\n\nTool homepage: https://github.com/vgteam/odgi"
inputs:
  - id: breadth_first
    type:
      - 'null'
      - boolean
    doc: Use a (chunked) breadth first topological sort.
    inputBinding:
      position: 101
      prefix: --breadth-first
  - id: breadth_first_chunk
    type:
      - 'null'
      - int
    doc: Chunk size for breadth first topological sort. Specify how many 
      nucleotides to grap at once in each BFS phase.
    inputBinding:
      position: 101
      prefix: --breadth-first-chunk
  - id: cycle_breaking
    type:
      - 'null'
      - boolean
    doc: Use a cycle breaking sort.
    inputBinding:
      position: 101
      prefix: --cycle-breaking
  - id: dagify_sort
    type:
      - 'null'
      - boolean
    doc: Sort on the basis of a DAGified graph.
    inputBinding:
      position: 101
      prefix: --dagify-sort
  - id: depth_first
    type:
      - 'null'
      - boolean
    doc: Use a (chunked) depth first topological sort.
    inputBinding:
      position: 101
      prefix: --depth-first
  - id: depth_first_chunk
    type:
      - 'null'
      - int
    doc: Chunk size for the depth first topological sort. Specify how many 
      nucleotides to grap at once in each DFS phase.
    inputBinding:
      position: 101
      prefix: --depth-first-chunk
  - id: input_graph
    type: File
    doc: Load the succinct variation graph in ODGI format from this *FILE*. The 
      file name usually ends with *.og*. It also accepts GFAv1, but the 
      on-the-fly conversion to the ODGI format requires additional time!
    inputBinding:
      position: 101
      prefix: --idx
  - id: iteration_max_learning_rate
    type:
      - 'null'
      - int
    doc: 'The iteration where the learning rate is max for path guided linear 1D SGD
      model (default: *0*).'
    inputBinding:
      position: 101
      prefix: --iteration-max-learning-rate
  - id: no_seeds
    type:
      - 'null'
      - boolean
    doc: Don't use heads or tails to seed the topological sort.
    inputBinding:
      position: 101
      prefix: --no-seeds
  - id: optimize
    type:
      - 'null'
      - boolean
    doc: Use the MutableHandleGraph::optimize method to compact the node 
      identifier space.
    inputBinding:
      position: 101
      prefix: --optimize
  - id: path_delim
    type:
      - 'null'
      - string
    doc: Sort paths in bins by their prefix up to this delimiter.
    inputBinding:
      position: 101
      prefix: --path-delim
  - id: path_index
    type:
      - 'null'
      - File
    doc: Load the succinct variation graph index from this *FILE*. The file name
      usually ends with *.xp*.
    inputBinding:
      position: 101
      prefix: --path-index
  - id: path_sgd
    type:
      - 'null'
      - boolean
    doc: Apply the path-guided linear 1D SGD algorithm to organize graph.
    inputBinding:
      position: 101
      prefix: --path-sgd
  - id: path_sgd_cooling
    type:
      - 'null'
      - float
    doc: 'Use this fraction of the iterations for layout annealing (default: 0.5).'
    inputBinding:
      position: 101
      prefix: --path-sgd-cooling
  - id: path_sgd_delta
    type:
      - 'null'
      - float
    doc: 'The threshold of maximum displacement approximately in bp at which to stop
      path guided linear 1D SGD (default: *0.0*).'
    inputBinding:
      position: 101
      prefix: --path-sgd-delta
  - id: path_sgd_eps
    type:
      - 'null'
      - float
    doc: 'The final learning rate for path guided linear 1D SGD model (default: *0.01*).'
    inputBinding:
      position: 101
      prefix: --path-sgd-eps
  - id: path_sgd_eta_max
    type:
      - 'null'
      - float
    doc: 'The first and maximum learning rate for path guided linear 1D SGD model
      (default: *squared steps of longest path in graph*).'
    inputBinding:
      position: 101
      prefix: --path-sgd-eta-max
  - id: path_sgd_iter_max
    type:
      - 'null'
      - int
    doc: 'The maximum number of iterations for path guided linear 1D SGD model (default:
      100).'
    inputBinding:
      position: 101
      prefix: --path-sgd-iter-max
  - id: path_sgd_layout
    type:
      - 'null'
      - string
    doc: write the layout of a sorted, path guided 1D SGD graph to this file, no
      default
    inputBinding:
      position: 101
      prefix: --path-sgd-layout
  - id: path_sgd_min_term_updates_nodes
    type:
      - 'null'
      - int
    doc: 'The minimum number of terms to be updated before a new path guided linear
      1D SGD iteration with adjusted learning rate eta starts, expressed as a multiple
      of the number of nodes (default: NONE. *-G,path-sgd-min-term-updates-paths=N*
      is used).'
    inputBinding:
      position: 101
      prefix: --path-sgd-min-term-updates-nodes
  - id: path_sgd_min_term_updates_paths
    type:
      - 'null'
      - float
    doc: 'The minimum number of terms to be updated before a new path guided linear
      1D SGD iteration with adjusted learning rate eta starts, expressed as a multiple
      of total path steps (default: *1.0*). Can be overwritten by *-U, -path-sgd-min-term-updates-nodes=N*.'
    inputBinding:
      position: 101
      prefix: --path-sgd-min-term-updates-paths
  - id: path_sgd_seed
    type:
      - 'null'
      - string
    doc: 'Set the seed for the deterministic 1-threaded path guided linear 1D SGD
      model (default: *pangenomic!*).'
    inputBinding:
      position: 101
      prefix: --path-sgd-seed
  - id: path_sgd_snapshot
    type:
      - 'null'
      - string
    doc: Set the prefix to which each snapshot graph of a path guided 1D SGD 
      iteration should be written to. This is turned off per default. This 
      argument only works when *-Y, –path-sgd* was specified. Not applicable in 
      a pipeline of sorts.
    inputBinding:
      position: 101
      prefix: --path-sgd-snapshot
  - id: path_sgd_use_paths
    type:
      - 'null'
      - File
    doc: 'Specify a line separated list of paths to sample from for the on the fly
      term generation process in the path guided linear 1D SGD (default: sample from
      all paths).'
    inputBinding:
      position: 101
      prefix: --path-sgd-use-paths
  - id: path_sgd_zipf_max_num_distributions
    type:
      - 'null'
      - int
    doc: 'Approximate maximum number of Zipfian distributions to calculate (default:
      *100*).'
    inputBinding:
      position: 101
      prefix: --path-sgd-zipf-max-num-distributions
  - id: path_sgd_zipf_space
    type:
      - 'null'
      - int
    doc: 'The maximum space size of the Zipfian distribution which is used as the
      sampling method for the second node of one term in the path guided linear 1D
      SGD model (default: *longest path length*).'
    inputBinding:
      position: 101
      prefix: --path-sgd-zipf-space
  - id: path_sgd_zipf_space_max
    type:
      - 'null'
      - int
    doc: 'The maximum space size of the Zipfian distribution beyond which quantization
      occurs (default: *100*).'
    inputBinding:
      position: 101
      prefix: --path-sgd-zipf-space-max
  - id: path_sgd_zipf_space_quantization_step
    type:
      - 'null'
      - int
    doc: 'Quantization step size when the maximum space size of the Zipfian distribution
      is exceeded (default: *100*).'
    inputBinding:
      position: 101
      prefix: --path-sgd-zipf-space-quantization-step
  - id: path_sgd_zipf_theta
    type:
      - 'null'
      - float
    doc: 'The theta value for the Zipfian distribution which is used as the sampling
      method for the second node of one term in the path guided linear 1D SGD model
      (default: *0.99*).'
    inputBinding:
      position: 101
      prefix: --path-sgd-zipf-theta
  - id: paths_avg
    type:
      - 'null'
      - boolean
    doc: Sort paths by their average contained node identifier.
    inputBinding:
      position: 101
      prefix: --paths-avg
  - id: paths_avg_rev
    type:
      - 'null'
      - boolean
    doc: Sort paths in reverse by their average contained node identifier.
    inputBinding:
      position: 101
      prefix: --paths-avg-rev
  - id: paths_max
    type:
      - 'null'
      - boolean
    doc: Sort paths by their highest contained node identifier.
    inputBinding:
      position: 101
      prefix: --paths-max
  - id: paths_min
    type:
      - 'null'
      - boolean
    doc: Sort paths by their lowest contained node identifier.
    inputBinding:
      position: 101
      prefix: --paths-min
  - id: pipeline
    type:
      - 'null'
      - string
    doc: 'Apply a series of sorts, based on single character command line arguments
      given to this command (default: NONE). *s*: Topolocigal sort, heads only. *n*:
      Topological sort, no heads, no tails. *d*: DAGify sort. *c*: Cycle breaking
      sort. *b*: Breadth first topological sort. *z*: Depth first topological sort.
      *w*: Two-way topological sort. *r*: Random sort. *Y*: PG-SGD 1D sort. *f*: Reverse
      order. *g*: Groom the graph. An example could be *Ygs*.'
    inputBinding:
      position: 101
      prefix: --pipeline
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Write the current progress to stderr.
    inputBinding:
      position: 101
      prefix: --progress
  - id: random
    type:
      - 'null'
      - boolean
    doc: Randomly sort the graph.
    inputBinding:
      position: 101
      prefix: --random
  - id: sort_order_file
    type:
      - 'null'
      - File
    doc: '*FILE* containing the sort order. Each line contains one node identifer.'
    inputBinding:
      position: 101
      prefix: --sort-order
  - id: target_paths
    type:
      - 'null'
      - File
    doc: Read the paths that should be considered as target paths (references) 
      from this *FILE*. PG-SGD will keep the nodes of the given paths fixed. A 
      path's rank determines it's weight for decision making and is given by its
      position in the given *FILE*.
    inputBinding:
      position: 101
      prefix: --target-paths
  - id: temp_dir
    type:
      - 'null'
      - Directory
    doc: directory for temporary files
    inputBinding:
      position: 101
      prefix: --temp-dir
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for parallel operations.
    inputBinding:
      position: 101
      prefix: --threads
  - id: two_way
    type:
      - 'null'
      - boolean
    doc: Use a two-way topological algorithm for sorting. It is a maximum of 
      head-first and tail-first topological sort.
    inputBinding:
      position: 101
      prefix: --two-way
outputs:
  - id: output_graph
    type:
      - 'null'
      - File
    doc: Write the sorted dynamic succinct variation graph to this file. A file 
      ending with *.og* is recommended.
    outputBinding:
      glob: $(inputs.output_graph)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
