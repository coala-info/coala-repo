cwlVersion: v1.2
class: CommandLineTool
baseCommand: learnMSA
label: learnmsa_learnMSA
doc: "multiple alignment of protein sequences\n\nTool homepage: https://github.com/Gaius-Augustus/learnMSA"
inputs:
  - id: auto_crop_scale
    type:
      - 'null'
      - float
    doc: Automatically crop sequences longer than this factor times the average 
      length during training.
    inputBinding:
      position: 101
      prefix: --auto_crop_scale
  - id: batch_size
    type:
      - 'null'
      - int
    doc: 'Batch size for training. Prefer --tokens_per_batch unless sequences have
      roughly the same length. Default: adaptive.'
    inputBinding:
      position: 101
      prefix: --batch
  - id: cluster_dir
    type:
      - 'null'
      - Directory
    doc: 'Deprecated: Use --work_dir instead.'
    inputBinding:
      position: 101
      prefix: --cluster_dir
  - id: convert
    type:
      - 'null'
      - boolean
    doc: Convert input files to format specific by --format.
    inputBinding:
      position: 101
      prefix: --convert
  - id: crop
    type:
      - 'null'
      - int
    doc: Crop sequences longer than the given value during training.
    inputBinding:
      position: 101
      prefix: --crop
  - id: cuda_visible_devices
    type:
      - 'null'
      - string
    doc: GPU device(s) visible to learnMSA. Use -1 for CPU.
    inputBinding:
      position: 101
      prefix: --cuda_visible_devices
  - id: epochs
    type:
      - 'null'
      - type: array
        items: int
    doc: Number of training epochs (see detailed help).
    inputBinding:
      position: 101
      prefix: --epochs
  - id: format
    type:
      - 'null'
      - string
    doc: Format of the output alignment file.
    inputBinding:
      position: 101
      prefix: --format
  - id: from_msa
    type:
      - 'null'
      - File
    doc: If set, the initial HMM parameters will inferred from the provided MSA 
      in FASTA format.
    inputBinding:
      position: 101
      prefix: --from_msa
  - id: frozen_insertions
    type:
      - 'null'
      - boolean
    doc: Insertions will be frozen during training.
    inputBinding:
      position: 101
      prefix: --frozen_insertions
  - id: global_factor
    type:
      - 'null'
      - float
    doc: A value in [0, 1] that describes the degree to which the MSA provided 
      with --from_msa is considered a global alignment. This value is used as a 
      mixing factor and affects how states are counted when the data contains 
      fragmentary sequences. A global alignment counts flanks as deletions, 
      while a local alignment counts them as jumps into the profile using only a
      single edge.
    inputBinding:
      position: 101
      prefix: --global_factor
  - id: indexed_data
    type:
      - 'null'
      - boolean
    doc: Stream training data at the cost of training time.
    inputBinding:
      position: 101
      prefix: --indexed_data
  - id: input_file
    type: File
    doc: Input fasta file.
    inputBinding:
      position: 101
      prefix: --in_file
  - id: input_format
    type:
      - 'null'
      - string
    doc: Format of the input alignment file.
    inputBinding:
      position: 101
      prefix: --input_format
  - id: language_model
    type:
      - 'null'
      - string
    doc: 'Name of the language model to use. (default: protT5)'
    inputBinding:
      position: 101
      prefix: --language_model
  - id: learning_rate
    type:
      - 'null'
      - float
    doc: Learning rate for gradient descent.
    inputBinding:
      position: 101
      prefix: --learning_rate
  - id: len_mul
    type:
      - 'null'
      - float
    doc: Check learnMSA help len_mul for details.
    inputBinding:
      position: 101
      prefix: --len_mul
  - id: length_init
    type:
      - 'null'
      - type: array
        items: int
    doc: 'Initial lengths for the models. Can be a single integer or a list of integers.
      If a list is provided, the number of models will be set to match the list length.
      (default: determined automatically based on sequence data)'
    inputBinding:
      position: 101
      prefix: --length_init
  - id: length_init_quantile
    type:
      - 'null'
      - float
    doc: Check learnMSA help length_init_quantile for details.
    inputBinding:
      position: 101
      prefix: --length_init_quantile
  - id: load_model
    type:
      - 'null'
      - string
    doc: Load a saved model.
    inputBinding:
      position: 101
      prefix: --load_model
  - id: logo
    type:
      - 'null'
      - File
    doc: Produces a pdf of the learned sequence logo.
    inputBinding:
      position: 101
      prefix: --logo
  - id: logo_gif
    type:
      - 'null'
      - File
    doc: Produces a gif that animates the learned sequence logo over training 
      time. Slows down training significantly.
    inputBinding:
      position: 101
      prefix: --logo_gif
  - id: match_threshold
    type:
      - 'null'
      - float
    doc: When inferring HMM parameters from an MSA, a column is considered a 
      match state if its occupancy (fraction of non-gap characters) is at least 
      this value.
    inputBinding:
      position: 101
      prefix: --match_threshold
  - id: max_iterations
    type:
      - 'null'
      - int
    doc: Maximum number of training iterations. If greater than 2, modelsurgery 
      will be applied.
    inputBinding:
      position: 101
      prefix: --max_iterations
  - id: min_surgery_seqs
    type:
      - 'null'
      - int
    doc: Check learnMSA help min_surgery_seqs for details.
    inputBinding:
      position: 101
      prefix: --min_surgery_seqs
  - id: model_criterion
    type:
      - 'null'
      - string
    doc: Criterion for model selection.
    inputBinding:
      position: 101
      prefix: --model_criterion
  - id: noA2M
    type:
      - 'null'
      - boolean
    doc: 'Deprecated: Use --format fasta instead.'
    inputBinding:
      position: 101
      prefix: --noA2M
  - id: no_sequence_weights
    type:
      - 'null'
      - boolean
    doc: Do not use sequence weights and strip mmseqs2 from requirements. In 
      general not recommended.
    inputBinding:
      position: 101
      prefix: --no_sequence_weights
  - id: num_model
    type:
      - 'null'
      - int
    doc: Number of models to train.
    inputBinding:
      position: 101
      prefix: --num_model
  - id: only_matches
    type:
      - 'null'
      - boolean
    doc: Omit all insertions and write only those amino acids that are assigned 
      to match states.
    inputBinding:
      position: 101
      prefix: --only_matches
  - id: plm_cache_dir
    type:
      - 'null'
      - Directory
    doc: 'Directory where the protein language model is stored. (default: learnMSA
      install dir)'
    inputBinding:
      position: 101
      prefix: --plm_cache_dir
  - id: pseudocounts
    type:
      - 'null'
      - boolean
    doc: If set, pseudocounts inferred from Dirichlet priors will be added on 
      state transition and emissions counted in the MSA input via --from_msa.
    inputBinding:
      position: 101
      prefix: --pseudocounts
  - id: random_scale
    type:
      - 'null'
      - float
    doc: When initializing from an MSA, the initial parameters are slightly 
      perturbed by random noise. This parameter controls the scale of the noise.
    inputBinding:
      position: 101
      prefix: --random_scale
  - id: save_model
    type:
      - 'null'
      - string
    doc: Save a trained model for later reuse
    inputBinding:
      position: 101
      prefix: --save_model
  - id: scores
    type:
      - 'null'
      - File
    doc: Additional table file containing per-sequence likelihoods.
    inputBinding:
      position: 101
      prefix: --scores
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Suppresses all standard output messages.
    inputBinding:
      position: 101
      prefix: --silent
  - id: skip_training
    type:
      - 'null'
      - boolean
    doc: Only decode an alignment from the provided model.
    inputBinding:
      position: 101
      prefix: --skip_training
  - id: surgery_del
    type:
      - 'null'
      - float
    doc: Discard match states expected less often than this fraction.
    inputBinding:
      position: 101
      prefix: --surgery_del
  - id: surgery_ins
    type:
      - 'null'
      - float
    doc: Expand insertions expected more often than this fraction.
    inputBinding:
      position: 101
      prefix: --surgery_ins
  - id: surgery_quantile
    type:
      - 'null'
      - float
    doc: Check learnMSA help surgery_quantile for details.
    inputBinding:
      position: 101
      prefix: --surgery_quantile
  - id: tokens_per_batch
    type:
      - 'null'
      - int
    doc: 'Number of tokens per batch for training. Default: adaptive.'
    inputBinding:
      position: 101
      prefix: --tokens_per_batch
  - id: unaligned_insertions
    type:
      - 'null'
      - boolean
    doc: Insertions will be left unaligned.
    inputBinding:
      position: 101
      prefix: --unaligned_insertions
  - id: use_language_model
    type:
      - 'null'
      - boolean
    doc: 'Uses a large protein lanague model to generate per-token embeddings that
      guide the MSA step. (default: False)'
    inputBinding:
      position: 101
      prefix: --use_language_model
  - id: work_dir
    type:
      - 'null'
      - Directory
    doc: Working directory.
    inputBinding:
      position: 101
      prefix: --work_dir
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file. Use -f to change format. Optional when --scores is used.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/learnmsa:2.0.16--pyhdfd78af_0
