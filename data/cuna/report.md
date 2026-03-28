# cuna CWL Generation Report

## cuna_detect

### Tool Description
Detect modifications using a trained model.

### Metadata
- **Docker Image**: quay.io/biocontainers/cuna:0.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/iris1901/CUNA
- **Package**: https://anaconda.org/channels/bioconda/packages/cuna/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cuna/overview
- **Total Downloads**: 589
- **Last updated**: 2025-08-13
- **GitHub**: https://github.com/iris1901/CUNA
- **Stars**: N/A
### Original Help Text
```text
usage: cuna detect [-h] [--prefix PREFIX] [--output OUTPUT]
                   [--qscore_cutoff QSCORE_CUTOFF]
                   [--length_cutoff LENGTH_CUTOFF] [--mod_t MOD_T]
                   [--unmod_t UNMOD_T] --motif MOTIF [MOTIF ...]
                   [--mod_symbol MOD_SYMBOL] [--threads THREADS] --model MODEL
                   --bam BAM --input INPUT [--skip_per_site] [--device DEVICE]
                   [--disable_pruning] [--batch_size BATCH_SIZE]
                   [--bam_threads BAM_THREADS] [--skip_unmapped]

options:
  -h, --help            show this help message and exit
  --prefix PREFIX       Prefix for the output files (default: output)
  --output OUTPUT       Path to folder where intermediate and final files will
                        be stored, default is current working directory
                        (default: None)
  --qscore_cutoff QSCORE_CUTOFF
                        Minimum cutoff for mean quality score of a read
                        (default: 0)
  --length_cutoff LENGTH_CUTOFF
                        Minimum cutoff for read length (default: 0)
  --mod_t MOD_T         Probability threshold for a per-read prediction to be
                        considered modified. (default: 0.5)
  --unmod_t UNMOD_T     Probability threshold for a per-read prediction to be
                        considered unmodified. (default: 0.5)
  --motif MOTIF [MOTIF ...]
                        Motif to detect. Format: "<MOTIF> <INDEX>". Example:
                        "T 0" to detect modifications on T. (default: None)
  --mod_symbol MOD_SYMBOL
                        Symbol to use for modified base in BAM tag MM (e.g.
                        "u" for uracil). (default: None)
  --threads THREADS     Number of threads to use for processing signal and
                        running model inference. Recommended: at least 4.
                        (default: 4)
  --skip_per_site       Skip per-site output generation. (default: False)
  --device DEVICE       Device to use for model inference: "cpu", "cuda",
                        "cuda:0", "mps", etc. (default: None)
  --disable_pruning     Disable model pruning (may slow down CPU inference).
                        (default: False)
  --batch_size BATCH_SIZE
                        Batch size to use for GPU inference. (default: 1024)
  --bam_threads BAM_THREADS
                        Number of threads for BAM output compression.
                        (default: 4)
  --skip_unmapped       Skip unmapped reads from modification calling.
                        (default: False)

Required Arguments:
  --model MODEL         Name of the model to use. For custom models, provide
                        "config.cfg,model.pt". (default: None)
  --bam BAM             Path to aligned BAM file from Dorado basecalling.
                        (default: None)
  --input INPUT         Path to POD5 file or folder containing POD5 files.
                        (default: None)
```


## cuna_merge

### Tool Description
Merge per-read modification calls.

### Metadata
- **Docker Image**: quay.io/biocontainers/cuna:0.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/iris1901/CUNA
- **Package**: https://anaconda.org/channels/bioconda/packages/cuna/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cuna merge [-h] [--prefix PREFIX] [--output OUTPUT]
                  [--qscore_cutoff QSCORE_CUTOFF]
                  [--length_cutoff LENGTH_CUTOFF] [--mod_t MOD_T]
                  [--unmod_t UNMOD_T] [--input [INPUT ...]] [--list LIST]

options:
  -h, --help            show this help message and exit
  --prefix PREFIX       Prefix for the output files (default: output)
  --output OUTPUT       Path to folder where intermediate and final files will
                        be stored, default is current working directory
                        (default: None)
  --qscore_cutoff QSCORE_CUTOFF
                        Minimum cutoff for mean quality score of a read
                        (default: 0)
  --length_cutoff LENGTH_CUTOFF
                        Minimum cutoff for read length (default: 0)
  --mod_t MOD_T         Probability threshold for a per-read prediction to be
                        considered modified. (default: 0.5)
  --unmod_t UNMOD_T     Probability threshold for a per-read prediction to be
                        considered unmodified. (default: 0.5)
  --input [INPUT ...]   List of paths of per-read modification calls to merge.
                        File paths should be separated by space/whitespace.
                        Use either --input or --list argument, but not both.
                        (default: None)
  --list LIST           A file containing paths to per-read modification calls
                        to merge (one per line). Use either --input or --list
                        argument, but not both. (default: None)
```


## cuna_features

### Tool Description
Extracts features from sequencing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/cuna:0.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/iris1901/CUNA
- **Package**: https://anaconda.org/channels/bioconda/packages/cuna/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cuna features [-h] --bam BAM [--window WINDOW] [--prefix PREFIX]
                     --input INPUT --output OUTPUT [--threads THREADS]
                     [--div_threshold DIV_THRESHOLD]
                     [--reads_per_chunk READS_PER_CHUNK] --ref REF --pos_list
                     POS_LIST --file_type {pod5} --seq_type {dna}
                     [--norm_type {mad,standard}] [--chrom [CHROM ...]]
                     [--length_cutoff LENGTH_CUTOFF]

options:
  -h, --help            show this help message and exit
  --bam BAM             Path to BAM file with move table (default: None)
  --window WINDOW       Number of bases before or after the base of interest
                        to include in the model. Total will be 2xwindow+1.
                        (default: 10)
  --prefix PREFIX       Prefix for the output files (default: output)
  --input INPUT         Path to folder containing POD5 files (default: None)
  --output OUTPUT       Path to folder where features will be stored (default:
                        None)
  --threads THREADS     Number of processors to use (default: 1)
  --div_threshold DIV_THRESHOLD
                        Divergence Threshold. (default: 0.25)
  --reads_per_chunk READS_PER_CHUNK
                        Reads per chunk (default: 100000)
  --ref REF             Path to reference FASTA file (default: None)
  --pos_list POS_LIST   File with positions and labels (chrom pos strand
                        label) (default: None)
  --file_type {pod5}    Signal file format (default: None)
  --seq_type {dna}      Specify DNA sequencing only (default: None)
  --norm_type {mad,standard}
                        Normalization method (default: mad)
  --chrom [CHROM ...]   List of contigs to include (optional) (default: None)
  --length_cutoff LENGTH_CUTOFF
                        Minimum read length (default: 0)
```


## cuna_train

### Tool Description
Train a CUNA model.

### Metadata
- **Docker Image**: quay.io/biocontainers/cuna:0.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/iris1901/CUNA
- **Package**: https://anaconda.org/channels/bioconda/packages/cuna/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cuna train [-h] --mixed_training_dataset [MIXED_TRAINING_DATASET ...]
                  [--validation_type {split,dataset}]
                  [--validation_fraction VALIDATION_FRACTION]
                  [--validation_dataset [VALIDATION_DATASET ...]]
                  [--prefix PREFIX] [--weights WEIGHTS] --model_save_path
                  MODEL_SAVE_PATH [--epochs EPOCHS] [--batch_size BATCH_SIZE]
                  [--retrain RETRAIN] [--fc_type {middle,all}] --model_type
                  {bilstm,transformer} [--num_layers NUM_LAYERS]
                  [--dim_feedforward DIM_FEEDFORWARD] [--num_fc NUM_FC]
                  [--embedding_dim EMBEDDING_DIM]
                  [--embedding_type {learnable,one_hot}] [--pe_dim PE_DIM]
                  [--pe_type {fixed,embedding,parameter}] [--nhead NHEAD]
                  [--lr LR] [--l2_coef L2_COEF]
                  [--early_stopping EARLY_STOPPING] [--seed SEED]

options:
  -h, --help            show this help message and exit
  --mixed_training_dataset [MIXED_TRAINING_DATASET ...]
                        Training dataset with mixed labels. A whitespace
                        separated list of folders containing .npz files or
                        paths to individual .npz files. (default: None)
  --validation_type {split,dataset}
                        Validation strategy: "split" uses a fraction of
                        training data, "dataset" uses separate validation
                        data. (default: split)
  --validation_fraction VALIDATION_FRACTION
                        Fraction of training dataset to use for validation
                        when validation_type is "split". (default: 0.2)
  --validation_dataset [VALIDATION_DATASET ...]
                        Validation dataset for "dataset" mode. A list of
                        folders with .npz files or paths to .npz files.
                        (default: None)
  --prefix PREFIX       Prefix name for the model checkpoints. (default:
                        model)
  --weights WEIGHTS     Weight for positive (modified) label in loss. Options:
                        "equal", "auto", or a numeric value. (default: equal)
  --model_save_path MODEL_SAVE_PATH
                        Path to save trained model checkpoints. (default:
                        None)
  --epochs EPOCHS       Number of training epochs. (default: 100)
  --batch_size BATCH_SIZE
                        Batch size for training. (default: 256)
  --retrain RETRAIN     Path to a saved model checkpoint for retraining.
                        (default: None)
  --fc_type {middle,all}
                        Type of fully connected layers used in classifier.
                        (default: all)
  --model_type {bilstm,transformer}
                        Model architecture type. (default: None)
  --num_layers NUM_LAYERS
                        Number of BiLSTM or Transformer encoder layers.
                        (default: 3)
  --dim_feedforward DIM_FEEDFORWARD
                        Dimension of BiLSTM hidden units or Transformer
                        feedforward layers. (default: 100)
  --num_fc NUM_FC       Size of fully connected layer between encoder and
                        classifier. (default: 16)
  --embedding_dim EMBEDDING_DIM
                        Size of base embedding dimension. (default: 4)
  --embedding_type {learnable,one_hot}
                        Embedding type for bases. (default: one_hot)
  --pe_dim PE_DIM       Dimension for positional encoding in Transformer.
                        (default: 16)
  --pe_type {fixed,embedding,parameter}
                        Type of positional encoding. (default: fixed)
  --nhead NHEAD         Number of attention heads in Transformer. (default: 4)
  --lr LR               Learning rate. (default: 0.0001)
  --l2_coef L2_COEF     L2 regularization coefficient. (default: 1e-05)
  --early_stopping EARLY_STOPPING
                        Number of epochs to wait without improvement in
                        validation F1 before stopping. 0 to disable. (default:
                        0)
  --seed SEED           Random seed for reproducibility. (default: None)
```


## Metadata
- **Skill**: generated
