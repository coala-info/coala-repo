cwlVersion: v1.2
class: CommandLineTool
baseCommand: famus-train
label: famus_famus-train
doc: "Train a FAMUS model\n\nTool homepage: https://github.com/burstein-lab/famus"
inputs:
  - id: input_fasta_dir_path
    type: Directory
    doc: Path to directory containing input fasta files representing protein families.
      Must only include fasta files.
    inputBinding:
      position: 1
  - id: batches_per_epoch
    type: ['null', int]
    doc: 'Number of batches per epoch to train the model. If not specified, will use cfg.yaml parameter. [10000]'
    inputBinding:
      position: 102
      prefix: --batches-per-epoch
  - id: chunksize
    type: ['null', int]
    doc: 'Number of sequences to process at once for classification or threshold calculation. [20000]'
    inputBinding:
      position: 102
      prefix: --chunksize
  - id: config
    type: ['null', File]
    doc: 'Path to config file'
    inputBinding:
      position: 102
      prefix: --config
  - id: continue_from_checkpoint
    type: ['null', boolean]
    doc: 'Whether to continue training from the latest checkpoint if it exists. [False]'
    inputBinding:
      position: 102
      prefix: --continue-from-checkpoint
  - id: create_subclusters
    type: ['null', boolean]
    doc: 'Create subclusters within each protein family (comprehensive model). [default: True]'
    inputBinding:
      position: 102
      prefix: --create-subclusters
  - id: no_create_subclusters
    type: ['null', boolean]
    doc: 'Do not create subclusters within each protein family (light model).'
    inputBinding:
      position: 102
      prefix: --no-create-subclusters
  - id: device
    type: ['null', string]
    doc: 'Device to use (cpu or cuda). [cuda]'
    inputBinding:
      position: 102
      prefix: --device
  - id: fraction_of_sampled_unknown_sequences
    type: ['null', float]
    doc: 'Fraction of unknown sequences to sample for training during preprocessing. [1.0]'
    inputBinding:
      position: 102
      prefix: --fraction-of-sampled-unknown-sequences
  - id: log_dir
    type: ['null', string]
    doc: 'Directory to save logs. [/root/.famus/logs]'
    inputBinding:
      position: 102
      prefix: --log-dir
  - id: log_to_wandb
    type: ['null', boolean]
    doc: 'Whether to log training to Weights & Biases. [False]'
    inputBinding:
      position: 102
      prefix: --log-to-wandb
  - id: no_log_to_wandb
    type: ['null', boolean]
    doc: 'Do not log training to Weights & Biases.'
    inputBinding:
      position: 102
      prefix: --no-log-to-wandb
  - id: mmseqs_cluster_coverage
    type: ['null', float]
    doc: 'MMseqs2 cluster coverage parameter during preprocessing. [0.8]'
    inputBinding:
      position: 102
      prefix: --mmseqs-cluster-coverage
  - id: mmseqs_cluster_identity
    type: ['null', float]
    doc: 'MMseqs2 cluster identity parameter during preprocessing. [0.9]'
    inputBinding:
      position: 102
      prefix: --mmseqs-cluster-identity
  - id: mmseqs_coverage_subclusters
    type: ['null', float]
    doc: 'MMseqs2 coverage for subclusters parameter during preprocessing. [0.5]'
    inputBinding:
      position: 102
      prefix: --mmseqs-coverage-subclusters
  - id: mmseqs_n_processes
    type: ['null', int]
    doc: 'Number of processes to use for MMseqs2 during preprocessing. [4]'
    inputBinding:
      position: 102
      prefix: --mmseqs-n-processes
  - id: model_name
    type: ['null', string]
    doc: 'Optional name for the model which will be used to request it during classification. The default value is the name of the input directory.'
    inputBinding:
      position: 102
      prefix: --model-name
  - id: models_dir
    type: ['null', string]
    doc: 'Directory to save or load models. [/root/.famus/models]'
    inputBinding:
      position: 102
      prefix: --models-dir
  - id: n_processes
    type: ['null', int]
    doc: 'Number of processes to use. [4]'
    inputBinding:
      position: 102
      prefix: --n-processes
  - id: no_log
    type: ['null', boolean]
    doc: 'Disable logging. [False]'
    inputBinding:
      position: 102
      prefix: --no-log
  - id: num_epochs
    type: ['null', int]
    doc: 'Number of epochs to train the model. If not specified, will use cfg.yaml parameter. [50]'
    inputBinding:
      position: 102
      prefix: --num-epochs
  - id: overwrite_checkpoint
    type: ['null', boolean]
    doc: 'Whether to overwrite existing checkpoints during training if they exist. [False]'
    inputBinding:
      position: 102
      prefix: --overwrite-checkpoint
  - id: sampled_sequences_per_subcluster
    type: ['null', int]
    doc: 'Number of sequences to sample per subcluster for training during preprocessing. [60]'
    inputBinding:
      position: 102
      prefix: --sampled-sequences-per-subcluster
  - id: samples_profiles_product_limit
    type: ['null', int]
    doc: 'Limit on the product of number of sampled sequences and number of profiles during preprocessing. [150000000000000]'
    inputBinding:
      position: 102
      prefix: --samples-profiles-product-limit
  - id: sequences_max_len_product_limit
    type: ['null', int]
    doc: 'Limit on the product of number of sequences and their maximum length during preprocessing. [500000000]'
    inputBinding:
      position: 102
      prefix: --sequences-max-len-product-limit
  - id: stop_before_training
    type: ['null', boolean]
    doc: 'Stop right before training the model. Useful for running preprocess and train separately. [False]'
    inputBinding:
      position: 102
      prefix: --stop-before-training
  - id: unknown_sequences_fasta_path
    type: ['null', File]
    doc: 'Path to fasta file containing sequences not belonging to any given protein family.'
    inputBinding:
      position: 102
      prefix: --unknown-sequences-fasta-path
  - id: wandb_api_key_path
    type: ['null', File]
    doc: 'Path to file containing Weights & Biases API key to use if logging to wandb. [wandb_api_key.txt]'
    inputBinding:
      position: 102
      prefix: --wandb-api-key-path
  - id: wandb_project
    type: ['null', string]
    doc: 'Weights & Biases project name to use if logging to wandb. [famus]'
    inputBinding:
      position: 102
      prefix: --wandb-project
outputs:
  - id: models_dir_out
    type: ['null', Directory]
    doc: Directory with the trained or preprocessed model.
    outputBinding:
      glob: $(inputs.models_dir)
  - id: log_dir_out
    type: ['null', Directory]
    doc: Directory to save logs.
    outputBinding:
      glob: $(inputs.log_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/famus:0.2.2--py312hdfd78af_0
