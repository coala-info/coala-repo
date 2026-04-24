cwlVersion: v1.2
class: CommandLineTool
baseCommand: odgi layout
label: odgi_layout
doc: "Establish 2D layouts of the graph using path-guided stochastic gradient descent.
  The graph must be sorted and id-compacted.\n\nTool homepage: https://github.com/vgteam/odgi"
inputs:
  - id: input_graph
    type: File
    doc: Load the succinct variation graph in ODGI format from this *FILE*. The 
      file name usually ends with *.og*. It also accepts GFAv1, but the 
      on-the-fly conversion to the ODGI format requires additional time!
    inputBinding:
      position: 101
      prefix: --idx
  - id: layout_initialization
    type:
      - 'null'
      - string
    doc: 'Specify the layout initialization mode: d) Node rank in X and gaussian noise
      in Y (default). r) Uniform noise in X and Y in the order of the graph length.
      u) Node rank in X and uniform noise in Y. g) Gaussian noise in X and Y. h) Hilbert
      curve in X and Y.'
    inputBinding:
      position: 101
      prefix: --layout-initialization
  - id: path_index
    type:
      - 'null'
      - File
    doc: Load the path index from this FILE so that it does not have to be 
      created for the layout calculation.
    inputBinding:
      position: 101
      prefix: --path-index
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
    doc: 'The threshold of the maximum displacement approximately in bp at which to
      stop path guided 2D SGD (default: 0).'
    inputBinding:
      position: 101
      prefix: --path-sgd-delta
  - id: path_sgd_eta
    type:
      - 'null'
      - float
    doc: 'The final learning rate for path guided 2D SGD model (default: 0.01).'
    inputBinding:
      position: 101
      prefix: --path-sgd-eta
  - id: path_sgd_eta_max
    type:
      - 'null'
      - float
    doc: 'The first and maximum learning rate N for path guided 2D SGD model (default:
      squared longest path length).'
    inputBinding:
      position: 101
      prefix: --path-sgd-eta-max
  - id: path_sgd_iter_max
    type:
      - 'null'
      - int
    doc: 'The maximum number of iterations N for the path guided 2D SGD model (default:
      30).'
    inputBinding:
      position: 101
      prefix: --path-sgd-iter-max
  - id: path_sgd_iteration_max_learning_rate
    type:
      - 'null'
      - int
    doc: 'Specify the iteration N where the learning rate is max for path guided 2D
      SGD model (default: 0).'
    inputBinding:
      position: 101
      prefix: --path-sgd-iteration-max-learning-rate
  - id: path_sgd_min_term_updates_nodes
    type:
      - 'null'
      - int
    doc: 'Minimum number of terms N to be updated before a new path guided linear
      1D SGD iteration with adjusted learning rate eta starts, expressed as a multiple
      of the number of nodes (default: argument is not set, the default of -G=[N],
      path-sgd-min-term-updates-paths=[N] is used).'
    inputBinding:
      position: 101
      prefix: --path-sgd-min-term-updates-nodes
  - id: path_sgd_min_term_updates_paths
    type:
      - 'null'
      - int
    doc: 'Minimum number of terms N to be updated before a new path guided 2D SGD
      iteration with adjusted learning rate eta starts, expressed as a multiple of
      total path length (default: 10).'
    inputBinding:
      position: 101
      prefix: --path-sgd-min-term-updates-paths
  - id: path_sgd_snapshot
    type:
      - 'null'
      - string
    doc: 'Set the prefix to which each snapshot layout of a path guided 2D SGD iteration
      should be written to (default: NONE).'
    inputBinding:
      position: 101
      prefix: --path-sgd-snapshot
  - id: path_sgd_use_paths
    type:
      - 'null'
      - File
    doc: 'Specify a line separated list of paths to sample from for the on the fly
      term generation process in the path guided 2D SGD (default: sample from all
      paths).'
    inputBinding:
      position: 101
      prefix: --path-sgd-use-paths
  - id: path_sgd_zipf_space
    type:
      - 'null'
      - int
    doc: 'The maximum space size N of the Zipfian distribution which is used as the
      sampling method for the second node of one term in the path guided 2D SGD model
      (default: max path lengths).'
    inputBinding:
      position: 101
      prefix: --path-sgd-zipf-space
  - id: path_sgd_zipf_space_max
    type:
      - 'null'
      - int
    doc: 'The maximum space size N of the Zipfian distribution beyond which quantization
      occurs (default: 1000).'
    inputBinding:
      position: 101
      prefix: --path-sgd-zipf-space-max
  - id: path_sgd_zipf_space_quantization_step
    type:
      - 'null'
      - int
    doc: 'The size of the quantization step N when the maximum space size of the Zipfian
      distribution is exceeded (default: 100).'
    inputBinding:
      position: 101
      prefix: --path-sgd-zipf-space-quantization-step
  - id: path_sgd_zipf_theta
    type:
      - 'null'
      - float
    doc: 'The theta value N for the Zipfian distribution which is used as the sampling
      method for the second node of one term in the path guided 2D SGD model (default:
      0.99).'
    inputBinding:
      position: 101
      prefix: --path-sgd-zipf-theta
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Write the current progress to stderr.
    inputBinding:
      position: 101
      prefix: --progress
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
outputs:
  - id: output_layout
    type:
      - 'null'
      - File
    doc: Write the layout coordinates to this FILE in .lay binary format.
    outputBinding:
      glob: $(inputs.output_layout)
  - id: output_tsv
    type:
      - 'null'
      - File
    doc: Write the layout in TSV format to this FILE.
    outputBinding:
      glob: $(inputs.output_tsv)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
