# learnmsa CWL Generation Report

## learnmsa_learnMSA

### Tool Description
multiple alignment of protein sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/learnmsa:2.0.16--pyhdfd78af_0
- **Homepage**: https://github.com/Gaius-Augustus/learnMSA
- **Package**: https://anaconda.org/channels/bioconda/packages/learnmsa/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/learnmsa/overview
- **Total Downloads**: 15.8K
- **Last updated**: 2025-12-11
- **GitHub**: https://github.com/Gaius-Augustus/learnMSA
- **Stars**: N/A
### Original Help Text
```text
usage: learnMSA [-h] -i INPUT_FILE [-o OUTPUT_FILE] [-f FORMAT]
                [--input_format INPUT_FORMAT] [--save_model SAVE_MODEL]
                [--load_model LOAD_MODEL] [-s] [-d CUDA_VISIBLE_DEVICES]
                [--work_dir WORK_DIR] [--convert] [--scores SCORES]
                [-n NUM_MODEL] [-b BATCH_SIZE]
                [--tokens_per_batch TOKENS_PER_BATCH]
                [--learning_rate LEARNING_RATE] [--epochs EPOCHS [EPOCHS ...]]
                [--max_iterations MAX_ITERATIONS]
                [--length_init LENGTH_INIT [LENGTH_INIT ...]]
                [--length_init_quantile LENGTH_INIT_QUANTILE]
                [--surgery_quantile SURGERY_QUANTILE]
                [--min_surgery_seqs MIN_SURGERY_SEQS] [--len_mul LEN_MUL]
                [--surgery_del SURGERY_DEL] [--surgery_ins SURGERY_INS]
                [--model_criterion MODEL_CRITERION] [--indexed_data]
                [--unaligned_insertions] [--crop CROP]
                [--auto_crop_scale AUTO_CROP_SCALE] [--frozen_insertions]
                [--no_sequence_weights] [--skip_training] [--only_matches]
                [--from_msa FROM_MSA] [--match_threshold MATCH_THRESHOLD]
                [--global_factor GLOBAL_FACTOR] [--random_scale RANDOM_SCALE]
                [--pseudocounts] [--use_language_model]
                [--plm_cache_dir PLM_CACHE_DIR]
                [--language_model LANGUAGE_MODEL] [--logo LOGO]
                [--logo_gif LOGO_GIF] [--noA2M] [--cluster_dir WORK_DIR]

learnMSA (version 2.0.16) - multiple alignment of protein sequences

Use 'learnMSA help [argument]' to get detailed help on a specific argument.

options:
  -h, --help            show this help message and exit

Input/output and general control:
  -i INPUT_FILE, --in_file INPUT_FILE
                        Input fasta file.
  -o OUTPUT_FILE, --out_file OUTPUT_FILE
                        Output file. Use -f to change format. Optional when
                        --scores is used.
  -f FORMAT, --format FORMAT
                        Format of the output alignment file.
  --input_format INPUT_FORMAT
                        Format of the input alignment file.
  --save_model SAVE_MODEL
                        Save a trained model for later reuse
  --load_model LOAD_MODEL
                        Load a saved model.
  -s, --silent          Suppresses all standard output messages.
  -d CUDA_VISIBLE_DEVICES, --cuda_visible_devices CUDA_VISIBLE_DEVICES
                        GPU device(s) visible to learnMSA. Use -1 for CPU.
  --work_dir WORK_DIR   Working directory. (default: tmp)
  --convert             Convert input files to format specific by --format.
  --scores SCORES       Additional table file containing per-sequence
                        likelihoods.

Training:
  -n NUM_MODEL, --num_model NUM_MODEL
                        Number of models to train. (default: 4)
  -b BATCH_SIZE, --batch BATCH_SIZE
                        Batch size for training. Prefer --tokens_per_batch
                        unless sequences have roughly the same length.
                        Default: adaptive.
  --tokens_per_batch TOKENS_PER_BATCH
                        Number of tokens per batch for training. Default:
                        adaptive.
  --learning_rate LEARNING_RATE
                        Learning rate for gradient descent. (default: 0.1)
  --epochs EPOCHS [EPOCHS ...]
                        Number of training epochs (see detailed help).
  --max_iterations MAX_ITERATIONS
                        Maximum number of training iterations. If greater than
                        2, modelsurgery will be applied. (default: 2)
  --length_init LENGTH_INIT [LENGTH_INIT ...]
                        Initial lengths for the models. Can be a single
                        integer or a list of integers. If a list is provided,
                        the number of models will be set to match the list
                        length. (default: determined automatically based on
                        sequence data)
  --length_init_quantile LENGTH_INIT_QUANTILE
                        Check learnMSA help length_init_quantile for details.
  --surgery_quantile SURGERY_QUANTILE
                        Check learnMSA help surgery_quantile for details.
  --min_surgery_seqs MIN_SURGERY_SEQS
                        Check learnMSA help min_surgery_seqs for details.
  --len_mul LEN_MUL     Check learnMSA help len_mul for details.
  --surgery_del SURGERY_DEL
                        Discard match states expected less often than this
                        fraction. (default: 0.5)
  --surgery_ins SURGERY_INS
                        Expand insertions expected more often than this
                        fraction. (default: 0.5)
  --model_criterion MODEL_CRITERION
                        Criterion for model selection. (default: AIC)
  --indexed_data        Stream training data at the cost of training time.
  --unaligned_insertions
                        Insertions will be left unaligned.
  --crop CROP           Crop sequences longer than the given value during
                        training.
  --auto_crop_scale AUTO_CROP_SCALE
                        Automatically crop sequences longer than this factor
                        times the average length during training. (default:
                        2.0)
  --frozen_insertions   Insertions will be frozen during training.
  --no_sequence_weights
                        Do not use sequence weights and strip mmseqs2 from
                        requirements. In general not recommended.
  --skip_training       Only decode an alignment from the provided model.
  --only_matches        Omit all insertions and write only those amino acids
                        that are assigned to match states.

Initialize with existing MSA:
  --from_msa FROM_MSA   If set, the initial HMM parameters will inferred from
                        the provided MSA in FASTA format.
  --match_threshold MATCH_THRESHOLD
                        When inferring HMM parameters from an MSA, a column is
                        considered a match state if its occupancy (fraction of
                        non-gap characters) is at least this value. (default:
                        0.5)
  --global_factor GLOBAL_FACTOR
                        A value in [0, 1] that describes the degree to which
                        the MSA provided with --from_msa is considered a
                        global alignment. This value is used as a mixing
                        factor and affects how states are counted when the
                        data contains fragmentary sequences. A global
                        alignment counts flanks as deletions, while a local
                        alignment counts them as jumps into the profile using
                        only a single edge. (default: 0.1)
  --random_scale RANDOM_SCALE
                        When initializing from an MSA, the initial parameters
                        are slightly perturbed by random noise. This parameter
                        controls the scale of the noise. (default: 0.001)
  --pseudocounts        If set, pseudocounts inferred from Dirichlet priors
                        will be added on state transition and emissions
                        counted in the MSA input via --from_msa.

Protein language model integration:
  --use_language_model  Uses a large protein lanague model to generate per-
                        token embeddings that guide the MSA step. (default:
                        False)
  --plm_cache_dir PLM_CACHE_DIR
                        Directory where the protein language model is stored.
                        (default: learnMSA install dir)
  --language_model LANGUAGE_MODEL
                        Name of the language model to use. (default: protT5)

Visualization:
  --logo LOGO           Produces a pdf of the learned sequence logo.
  --logo_gif LOGO_GIF   Produces a gif that animates the learned sequence logo
                        over training time. Slows down training significantly.

Deprecated arguments:
  --noA2M               Deprecated: Use --format fasta instead.
  --cluster_dir WORK_DIR
                        Deprecated: Use --work_dir instead.
```

