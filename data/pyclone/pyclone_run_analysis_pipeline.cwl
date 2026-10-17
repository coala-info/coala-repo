cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - PyClone
  - run_analysis_pipeline
label: pyclone_run_analysis_pipeline
doc: "Run a full PyClone analysis.\n\nTool homepage: https://github.com/Roth-Lab/pyclone"
inputs:
  - id: in_files
    type:
      type: array
      items: File
    doc: "Tsv format files with copy number and allele count information, one per sample."
    inputBinding:
      position: 1
      prefix: --in_files
  - id: working_dir
    type: string
    doc: "Path of directory where analysis files will be placed."
    inputBinding:
      position: 1
      prefix: --working_dir
  - id: tumour_contents
    type:
      - 'null'
      - type: array
        items: float
    doc: "Tumour contents, in the order of in_files. Assumed 1.0 if not given."
    inputBinding:
      position: 1
      prefix: --tumour_contents
  - id: samples
    type:
      - 'null'
      - type: array
        items: string
    doc: "Sample names, in the order of in_files."
    inputBinding:
      position: 1
      prefix: --samples
  - id: config_extras_file
    type:
      - 'null'
      - File
    doc: "Path to configuration file with extra parameters used for analysis."
    inputBinding:
      position: 1
      prefix: --config_extras_file
  - id: density
    type:
      - 'null'
      - string
    doc: "Emission density for the model (pyclone_binomial or pyclone_beta_binomial). Default is pyclone_beta_binomial."
    inputBinding:
      position: 1
      prefix: --density
  - id: init_method
    type:
      - 'null'
      - string
    doc: "How to initialise the DP clustering algorithm (connected or disconnected). Default is disconnected."
    inputBinding:
      position: 1
      prefix: --init_method
  - id: num_iters
    type:
      - 'null'
      - int
    doc: "Number of iterations of the MCMC sampler to perform. Default is 10,000."
    inputBinding:
      position: 1
      prefix: --num_iters
  - id: prior
    type:
      - 'null'
      - string
    doc: "Method used to set the possible genotypes (major_copy_number, parental_copy_number or total_copy_number). Default is major_copy_number."
    inputBinding:
      position: 1
      prefix: --prior
  - id: burnin
    type:
      - 'null'
      - int
    doc: "Number of samples to discard as burning for the MCMC chain. Default is 0."
    inputBinding:
      position: 1
      prefix: --burnin
  - id: thin
    type:
      - 'null'
      - int
    doc: "Number of samples to thin MCMC trace. Default is 1."
    inputBinding:
      position: 1
      prefix: --thin
  - id: seed
    type:
      - 'null'
      - int
    doc: "Set random seed so results can be reproduced."
    inputBinding:
      position: 1
      prefix: --seed
  - id: plot_file_format
    type:
      - 'null'
      - string
    doc: "File format for plots (pdf or svg). Default is pdf."
    inputBinding:
      position: 1
      prefix: --plot_file_format
  - id: max_clusters
    type:
      - 'null'
      - int
    doc: "Maximum number of clusters to consider for post-processing."
    inputBinding:
      position: 1
      prefix: --max_clusters
  - id: mesh_size
    type:
      - 'null'
      - int
    doc: "Number of points to use for approximating the cluster posteriors. Default is 101."
    inputBinding:
      position: 1
      prefix: --mesh_size
  - id: min_cluster_size
    type:
      - 'null'
      - int
    doc: "Clusters with fewer mutations than this value will not be plotted."
    inputBinding:
      position: 1
      prefix: --min_cluster_size
outputs:
  - id: analysis_dir
    type: Directory
    doc: "Analysis directory with config, trace, tables and plots."
    outputBinding:
      glob: $(inputs.working_dir)
requirements:
  - class: InlineJavascriptRequirement
  - class: EnvVarRequirement
    envDef:
      - envName: MPLBACKEND
        envValue: Agg
      - envName: NUMBA_CACHE_DIR
        envValue: /tmp
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyclone:0.13.1--py_0
