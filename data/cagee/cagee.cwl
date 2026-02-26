cwlVersion: v1.2
class: CommandLineTool
baseCommand: cagee
label: cagee
doc: "CAGEE is a software that provides a statistical foundation for evolutionary
  inferences about changes in gene expression. The program employs a Brownian motion
  process to model gene expression across a user-specified phylogenetic tree, thus
  accounting for the species phylogenetic history. The distribution of gene expression
  generated under this model can provide a basis for assessing the significance of
  the observed expression differences among taxa.\n\nTool homepage: https://github.com/hahnlab/CAGEE"
inputs:
  - id: config
    type:
      - 'null'
      - string
    doc: Configuration file containing additional options
    inputBinding:
      position: 101
      prefix: --config
  - id: cores
    type:
      - 'null'
      - int
    doc: Number of processing cores to use, requires an integer argument. 
      Default=All available cores.
    inputBinding:
      position: 101
      prefix: --cores
  - id: count_all_changes
    type:
      - 'null'
      - boolean
    doc: Reconstruction will count all changes rather than only credible changes
    default: 1
    inputBinding:
      position: 101
      prefix: --count_all_changes
  - id: discretization_size
    type:
      - 'null'
      - int
    doc: Size (length) of the discretization vector, Default=200. Can increase 
      resolution at the cost of computation time.
    default: 200
    inputBinding:
      position: 101
      prefix: --discretization_size
  - id: error
    type:
      - 'null'
      - string
    doc: Run with no file name to estimate the global error model file. This 
      file can be providedin subsequent runs by providing the path to the Error 
      model file with no spaces(e.g. - eBase_error_model.txt).
    default: 'false'
    inputBinding:
      position: 101
      prefix: --error
  - id: fixed_alpha
    type:
      - 'null'
      - string
    doc: Value for a single user provided alpha value, otherwise alpha is 
      estimated.
    inputBinding:
      position: 101
      prefix: --fixed_alpha
  - id: fixed_multiple_sigmas
    type:
      - 'null'
      - string
    doc: Multiple sigma values, comma separated.
    inputBinding:
      position: 101
      prefix: --fixed_multiple_sigmas
  - id: fixed_sigma
    type:
      - 'null'
      - string
    doc: Value for a single user provided sigma value, otherwise sigma is 
      estimated.
    inputBinding:
      position: 101
      prefix: --fixed_sigma
  - id: infile
    type: File
    doc: Path to tab delimited gene families file to be analyzed - Required for 
      estimation
    inputBinding:
      position: 101
      prefix: --infile
  - id: n_gamma_cats
    type:
      - 'null'
      - int
    doc: Number of gamma categories to use, requires an integer argument. 
      Default=1 (No gamma modelling)
    default: 1
    inputBinding:
      position: 101
      prefix: --n_gamma_cats
  - id: optimizer_expansion
    type:
      - 'null'
      - string
    doc: Expansion parameter for Nelder-Mead optimizer, Default=2.
    default: '2'
    inputBinding:
      position: 101
      prefix: --optimizer_expansion
  - id: optimizer_iterations
    type:
      - 'null'
      - int
    doc: Maximum number of iterations that will be performed in sigma 
      search.Default = 300 (increase this number if likelihood is still 
      improving when limit is hit).
    default: 300
    inputBinding:
      position: 101
      prefix: --optimizer_iterations
  - id: optimizer_reflection
    type:
      - 'null'
      - string
    doc: Reflection parameter for Nelder-Mead optimizer, Default=1.
    default: '1'
    inputBinding:
      position: 101
      prefix: --optimizer_reflection
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Output directory - Name of directory automatically created for output. 
      Default=results.
    default: results
    inputBinding:
      position: 101
      prefix: --output_prefix
  - id: prior
    type:
      - 'null'
      - string
    doc: Expected distribution of the root in Inference Mode (mutually exclusive
      with --rootdist in Simulation Mode). Must be gamma:[k]:[theta]. 
      Default=gamma:0.375:1600.0
    default: gamma:0.375:1600.0
    inputBinding:
      position: 101
      prefix: --prior
  - id: ratio
    type:
      - 'null'
      - boolean
    doc: The input file contains ratios of gene expression values rather than 
      absolute values
    default: 1
    inputBinding:
      position: 101
      prefix: --ratio
  - id: replicate_map
    type:
      - 'null'
      - File
    doc: Filename of a file containing a list of specie replicates to be 
      combined into a single species
    inputBinding:
      position: 101
      prefix: --replicate_map
  - id: rootdist
    type:
      - 'null'
      - string
    doc: 'Distribution of the root in Simulation Mode (mutually exclusive with --prior
      in Inference Mode). Can be gamma:[k]:[theta], fixed:[count], or a path/to/tab_sep_file.txt
      with two columns: trascripts names and their counts. Default=gamma:0.375:1600.0'
    inputBinding:
      position: 101
      prefix: --rootdist
  - id: sample_group
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Specifies sample groups (if any) for which to infer sigma^2. Each sample
      and sigma^2 estimate requires a --sample_group [your_sample_A] arg, or combine
      them with comma: --sample_group [your_sample_A,your_sample_B,...]. Optional,
      no default.'
    inputBinding:
      position: 101
      prefix: --sample_group
  - id: sigma_tree
    type:
      - 'null'
      - File
    doc: Path to sigma tree, for use with multiple sigmas
    inputBinding:
      position: 101
      prefix: --sigma_tree
  - id: simulate
    type:
      - 'null'
      - string
    doc: Simulate families. Optionally provide the number of simulations to 
      generate
    default: 'false'
    inputBinding:
      position: 101
      prefix: --simulate
  - id: tree
    type: File
    doc: Path to file containing newick formatted tree - Required for 
      estimation.
    inputBinding:
      position: 101
      prefix: --tree
  - id: verbose
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --verbose
  - id: zero_root
    type:
      - 'null'
      - boolean
    doc: Exclude gene families that don't exist at the root, not recommended.
    default: 1
    inputBinding:
      position: 101
      prefix: --zero_root
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cagee:1.2--he96a11b_1
stdout: cagee.out
