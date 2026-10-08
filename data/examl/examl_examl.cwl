cwlVersion: v1.2
class: CommandLineTool
baseCommand: examl
label: examl_examl
doc: "ExaML (Exascale Maximum Likelihood) is a tool for phylogenetic inference on huge datasets using Maximum Likelihood. The examl wrapper runs the MPI program with mpirun (-np sets the number of processes).\n\nTool homepage: https://github.com/stamatak/ExaML"
inputs:
  - id: processes
    type:
      - 'null'
      - int
    doc: "Number of MPI processes (wrapper option -np; default is half of the processors)"
    inputBinding:
      position: 1
      prefix: -np
  - id: binary_alignment_file
    type: File
    doc: "Binary alignment file produced by parse-examl"
    inputBinding:
      position: 2
      prefix: -s
  - id: output_name
    type: string
    doc: "Suffix of the output file names"
    inputBinding:
      position: 3
      prefix: -n
  - id: model
    type: string
    doc: "Model of rate heterogeneity: PSR (per-site rate categories) or GAMMA"
    inputBinding:
      position: 4
      prefix: -m
  - id: starting_tree
    type:
      - 'null'
      - File
    doc: "User starting tree in Newick format"
    inputBinding:
      position: 5
      prefix: -t
  - id: checkpoint_file
    type:
      - 'null'
      - File
    doc: "Binary checkpoint file to restart from"
    inputBinding:
      position: 6
      prefix: -R
  - id: constraint_tree
    type:
      - 'null'
      - File
    doc: "Multi-furcating constraint tree that contains all taxa (needs the random number seed -p)"
    inputBinding:
      position: 7
      prefix: -g
  - id: seed
    type:
      - 'null'
      - int
    doc: "Random number seed"
    inputBinding:
      position: 8
      prefix: -p
  - id: median_gamma
    type:
      - 'null'
      - boolean
    doc: "Use the median for the discrete approximation of the GAMMA model of rate heterogeneity"
    inputBinding:
      position: 9
      prefix: -a
  - id: best_trees
    type:
      - 'null'
      - int
    doc: "Number of best ML trees to save and print to file"
    inputBinding:
      position: 10
      prefix: -B
  - id: rate_categories
    type:
      - 'null'
      - int
    doc: "Number of distinct rate categories for the PSR model (default 25)"
    inputBinding:
      position: 11
      prefix: -c
  - id: search_convergence
    type:
      - 'null'
      - boolean
    doc: "ML search convergence criterion: break off ML searches when the relative Robinson-Foulds distance between trees of two consecutive lazy SPR cycles is at most 1%"
    inputBinding:
      position: 12
      prefix: -D
  - id: likelihood_epsilon
    type:
      - 'null'
      - float
    doc: "Model optimization precision in log likelihood units for the final optimization (default 0.1)"
    inputBinding:
      position: 13
      prefix: -e
  - id: algorithm
    type:
      - 'null'
      - string
    doc: "Algorithm: d (rapid hill-climbing, default), e (likelihood of trees from -t, quick), E (likelihood of trees from -t, thorough), o (old rapid hill-climbing), q (quartet calculator)"
    inputBinding:
      position: 14
      prefix: -f
  - id: initial_rearrangement
    type:
      - 'null'
      - int
    doc: "Initial rearrangement setting for the subsequent topological changes phase"
    inputBinding:
      position: 15
      prefix: -i
  - id: quartet_checkpoint_interval
    type:
      - 'null'
      - int
    doc: "Number of quartet evaluations after which a new checkpoint is printed (default 1000)"
    inputBinding:
      position: 16
      prefix: -I
  - id: per_partition_branch_lengths
    type:
      - 'null'
      - boolean
    doc: "Estimate individual per-partition branch lengths"
    inputBinding:
      position: 17
      prefix: -M
  - id: random_quartet_number
    type:
      - 'null'
      - int
    doc: "Number of random quartets to evaluate"
    inputBinding:
      position: 18
      prefix: -r
  - id: memory_saving
    type:
      - 'null'
      - boolean
    doc: "Switch on the memory saving option for gappy alignments"
    inputBinding:
      position: 19
      prefix: -S
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Verbose output"
    inputBinding:
      position: 20
      prefix: -v
  - id: quartet_grouping_file
    type:
      - 'null'
      - File
    doc: "Quartet grouping file"
    inputBinding:
      position: 21
      prefix: -Y
  - id: work_directory
    type:
      - 'null'
      - string
    doc: "Output directory (created in the working directory); the output files are then written inside it (ExaML needs an absolute path, so the wrapper prepends the working directory)"
    inputBinding:
      position: 23
      prefix: -w
      valueFrom: $(runtime.outdir + "/" + self)
  - id: auto_prot
    type:
      - 'null'
      - string
    doc: "Automatic protein model selection criterion: ml, bic, aic or aicc"
    inputBinding:
      position: 22
      prefix: --auto-prot=
      separate: false
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: result_tree
    type:
      - 'null'
      - File
    doc: "Final tree with branch lengths"
    outputBinding:
      glob: ExaML_result.$(inputs.output_name)
  - id: info_file
    type:
      - 'null'
      - File
    doc: "Run information"
    outputBinding:
      glob: ExaML_info.$(inputs.output_name)
  - id: log_file
    type:
      - 'null'
      - File
    doc: "Log likelihood trace"
    outputBinding:
      glob: ExaML_log.$(inputs.output_name)
  - id: model_file
    type:
      - 'null'
      - File
    doc: "Optimized model parameters"
    outputBinding:
      glob: ExaML_modelFile.$(inputs.output_name)
  - id: work_directory_output
    type:
      - 'null'
      - Directory
    doc: Output directory given with -w
    outputBinding:
      glob: $(inputs.work_directory)
  - id: checkpoints
    type:
      - 'null'
      - type: array
        items: File
    doc: Binary checkpoint files
    outputBinding:
      glob: ExaML_binaryCheckpoint.$(inputs.output_name)_*
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |
      ${
        return inputs.work_directory ? [{entryname: inputs.work_directory, entry: {class: "Directory", basename: inputs.work_directory, listing: []}, writable: true}] : [];
      }
  - class: EnvVarRequirement
    envDef:
      - envName: OMPI_MCA_rmaps_base_oversubscribe
        envValue: '1'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/examl:v3.0.21-2-deb_cv1
stdout: examl_examl.out
