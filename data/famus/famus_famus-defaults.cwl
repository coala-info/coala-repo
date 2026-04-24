cwlVersion: v1.2
class: CommandLineTool
baseCommand: famus
label: famus_famus-defaults
doc: "Default FAMUS configuration parameters. These parameters can be customized by
  creating a YAML config file.\n\nTool homepage: https://github.com/burstein-lab/famus"
inputs:
  - id: batches_per_epoch
    type:
      - 'null'
      - int
    doc: Number of batches per epoch
    inputBinding:
      position: 101
  - id: chunksize
    type:
      - 'null'
      - int
    doc: Size of data chunks
    inputBinding:
      position: 101
  - id: continue_from_checkpoint
    type:
      - 'null'
      - boolean
    doc: Continue training from a checkpoint
    inputBinding:
      position: 101
  - id: create_subclusters
    type:
      - 'null'
      - boolean
    doc: Whether to create subclusters
    inputBinding:
      position: 101
  - id: device
    type:
      - 'null'
      - string
    doc: Device to use for computation (e.g., cuda, cpu)
    inputBinding:
      position: 101
  - id: fraction_of_sampled_unknown_sequences
    type:
      - 'null'
      - float
    doc: Fraction of sampled unknown sequences
    inputBinding:
      position: 101
  - id: load_sdf_from_pickle
    type:
      - 'null'
      - boolean
    doc: Load SDF from a pickle file
    inputBinding:
      position: 101
  - id: log_dir
    type:
      - 'null'
      - Directory
    doc: Directory for log files
    inputBinding:
      position: 101
  - id: log_to_wandb
    type:
      - 'null'
      - boolean
    doc: Whether to log to Weights & Biases
    inputBinding:
      position: 101
  - id: mmseqs_cluster_coverage
    type:
      - 'null'
      - float
    doc: MMseqs cluster coverage threshold
    inputBinding:
      position: 101
  - id: mmseqs_cluster_identity
    type:
      - 'null'
      - float
    doc: MMseqs cluster identity threshold
    inputBinding:
      position: 101
  - id: mmseqs_coverage_subclusters
    type:
      - 'null'
      - float
    doc: MMseqs coverage for subclusters
    inputBinding:
      position: 101
  - id: mmseqs_n_processes
    type:
      - 'null'
      - int
    doc: Number of processes for MMseqs
    inputBinding:
      position: 101
  - id: model_type
    type:
      - 'null'
      - string
    doc: Type of model to use
    inputBinding:
      position: 101
  - id: models_dir
    type:
      - 'null'
      - Directory
    doc: Directory for models
    inputBinding:
      position: 101
  - id: n_processes
    type:
      - 'null'
      - int
    doc: Number of processes to use
    inputBinding:
      position: 101
  - id: no_log
    type:
      - 'null'
      - boolean
    doc: Disable logging
    inputBinding:
      position: 101
  - id: num_epochs
    type:
      - 'null'
      - int
    doc: Number of training epochs
    inputBinding:
      position: 101
  - id: overwrite_checkpoint
    type:
      - 'null'
      - boolean
    doc: Overwrite existing checkpoints
    inputBinding:
      position: 101
  - id: sampled_sequences_per_subcluster
    type:
      - 'null'
      - int
    doc: Number of sampled sequences per subcluster
    inputBinding:
      position: 101
  - id: samples_profiles_product_limit
    type:
      - 'null'
      - int
    doc: Product limit for samples and profiles
    inputBinding:
      position: 101
  - id: sequences_max_len_product_limit
    type:
      - 'null'
      - int
    doc: Product limit for maximum sequence length
    inputBinding:
      position: 101
  - id: stop_before_training
    type:
      - 'null'
      - boolean
    doc: Stop the process before training starts
    inputBinding:
      position: 101
  - id: wandb_api_key_path
    type:
      - 'null'
      - File
    doc: Path to Weights & Biases API key file
    inputBinding:
      position: 101
  - id: wandb_project
    type:
      - 'null'
      - string
    doc: Weights & Biases project name
    inputBinding:
      position: 101
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/famus:0.2.2--py312hdfd78af_0
stdout: famus_famus-defaults.out
