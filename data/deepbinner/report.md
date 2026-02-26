# deepbinner CWL Generation Report

## deepbinner_classify

### Tool Description
Classify fast5 reads

### Metadata
- **Docker Image**: quay.io/biocontainers/deepbinner:0.2.0--py36hc873e9d_0
- **Homepage**: https://github.com/rrwick/Deepbinner
- **Package**: https://anaconda.org/channels/bioconda/packages/deepbinner/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/deepbinner/overview
- **Total Downloads**: 11.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/rrwick/Deepbinner
- **Stars**: N/A
### Original Help Text
```text
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
usage: deepbinner classify [--native] [--rapid] [-s START_MODEL]
                           [-e END_MODEL] [--scan_size SCAN_SIZE]
                           [--score_diff SCORE_DIFF] [--require_either]
                           [--require_start] [--require_both]
                           [--batch_size BATCH_SIZE]
                           [--intra_op_parallelism_threads INTRA_OP_PARALLELISM_THREADS]
                           [--inter_op_parallelism_threads INTER_OP_PARALLELISM_THREADS]
                           [--device_count DEVICE_COUNT]
                           [--omp_num_threads OMP_NUM_THREADS] [--verbose]
                           [-h]
                           input

Classify fast5 reads

Positional:
  input                   One of the following: a single fast5 file, a
                          directory of fast5 files (will be searched
                          recursively) or a tab-delimited file of training
                          data

Model presets:
  --native                Preset for EXP-NBD103 read start and end models
  --rapid                 Preset for SQK-RBK004 read start model

Models (at least one is required if not using a preset):
  -s START_MODEL, --start_model START_MODEL
                          Model trained on the starts of reads
  -e END_MODEL, --end_model END_MODEL
                          Model trained on the ends of reads

Barcoding:
  --scan_size SCAN_SIZE   This much of a read's start/end signal will examined
                          for barcode signals (default: 6144)
  --score_diff SCORE_DIFF
                          For a read to be classified, there must be this much
                          difference between the best and second-best barcode
                          scores (default: 0.5)

Two model (read start and read end) behaviour:
  --require_either        Most lenient approach: a barcode call on either the
                          start or end is sufficient to classify a read, as
                          long as they do not disagree on the barcode
  --require_start         Moderate approach: a start barcode is required to
                          classify a read but an end barcode is optional
                          (default behaviour)
  --require_both          Most stringent approach: both start and end barcodes
                          must be present and agree to classify a read

Performance:
  --batch_size BATCH_SIZE
                          Neural network batch size (default: 256)
  --intra_op_parallelism_threads INTRA_OP_PARALLELISM_THREADS
                          TensorFlow's intra_op_parallelism_threads config
                          option (default: 12)
  --inter_op_parallelism_threads INTER_OP_PARALLELISM_THREADS
                          TensorFlow's inter_op_parallelism_threads config
                          option (default: 1)
  --device_count DEVICE_COUNT
                          TensorFlow's device_count config option (default: 1)
  --omp_num_threads OMP_NUM_THREADS
                          OMP_NUM_THREADS environment variable value (default:
                          12)

Other:
  --verbose               Include the output probabilities for all barcodes in
                          the results (default: just show the final barcode
                          call)
  -h, --help              Show this help message and exit
```


## deepbinner_bin

### Tool Description
Bin fasta/q reads

### Metadata
- **Docker Image**: quay.io/biocontainers/deepbinner:0.2.0--py36hc873e9d_0
- **Homepage**: https://github.com/rrwick/Deepbinner
- **Package**: https://anaconda.org/channels/bioconda/packages/deepbinner/overview
- **Validation**: PASS

### Original Help Text
```text
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
usage: deepbinner bin --classes CLASSES --reads READS --out_dir OUT_DIR [-h]

Bin fasta/q reads

Required:
  --classes CLASSES  Deepbinner classification file (made with the deepbinner
                     classify command)
  --reads READS      FASTA or FASTQ reads
  --out_dir OUT_DIR  Directory to output binned read files

Other:
  -h, --help         Show this help message and exit
```


## deepbinner_realtime

### Tool Description
Sort fast5 files during sequencing

### Metadata
- **Docker Image**: quay.io/biocontainers/deepbinner:0.2.0--py36hc873e9d_0
- **Homepage**: https://github.com/rrwick/Deepbinner
- **Package**: https://anaconda.org/channels/bioconda/packages/deepbinner/overview
- **Validation**: PASS

### Original Help Text
```text
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
usage: deepbinner realtime --in_dir IN_DIR --out_dir OUT_DIR [--native]
                           [--rapid] [-s START_MODEL] [-e END_MODEL]
                           [--scan_size SCAN_SIZE] [--score_diff SCORE_DIFF]
                           [--require_either] [--require_start]
                           [--require_both] [--batch_size BATCH_SIZE]
                           [--intra_op_parallelism_threads INTRA_OP_PARALLELISM_THREADS]
                           [--inter_op_parallelism_threads INTER_OP_PARALLELISM_THREADS]
                           [--device_count DEVICE_COUNT]
                           [--omp_num_threads OMP_NUM_THREADS] [-h]

Sort fast5 files during sequencing

Required:
  --in_dir IN_DIR         Directory where sequencer deposits fast5 files
  --out_dir OUT_DIR       Directory to output binned fast5 files

Model presets:
  --native                Preset for EXP-NBD103 read start and end models
  --rapid                 Preset for SQK-RBK004 read start model

Models (at least one is required if not using a preset):
  -s START_MODEL, --start_model START_MODEL
                          Model trained on the starts of reads
  -e END_MODEL, --end_model END_MODEL
                          Model trained on the ends of reads

Barcoding:
  --scan_size SCAN_SIZE   This much of a read's start/end signal will examined
                          for barcode signals (default: 6144)
  --score_diff SCORE_DIFF
                          For a read to be classified, there must be this much
                          difference between the best and second-best barcode
                          scores (default: 0.5)

Two model (read start and read end) behaviour:
  --require_either        Most lenient approach: a barcode call on either the
                          start or end is sufficient to classify a read, as
                          long as they do not disagree on the barcode
  --require_start         Moderate approach: a start barcode is required to
                          classify a read but an end barcode is optional
                          (default behaviour)
  --require_both          Most stringent approach: both start and end barcodes
                          must be present and agree to classify a read

Performance:
  --batch_size BATCH_SIZE
                          Neural network batch size (default: 256)
  --intra_op_parallelism_threads INTRA_OP_PARALLELISM_THREADS
                          TensorFlow's intra_op_parallelism_threads config
                          option (default: 12)
  --inter_op_parallelism_threads INTER_OP_PARALLELISM_THREADS
                          TensorFlow's inter_op_parallelism_threads config
                          option (default: 1)
  --device_count DEVICE_COUNT
                          TensorFlow's device_count config option (default: 1)
  --omp_num_threads OMP_NUM_THREADS
                          OMP_NUM_THREADS environment variable value (default:
                          12)

Other:
  -h, --help              Show this help message and exit
```


## deepbinner_prep

### Tool Description
Prepare training data

### Metadata
- **Docker Image**: quay.io/biocontainers/deepbinner:0.2.0--py36hc873e9d_0
- **Homepage**: https://github.com/rrwick/Deepbinner
- **Package**: https://anaconda.org/channels/bioconda/packages/deepbinner/overview
- **Validation**: PASS

### Original Help Text
```text
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
usage: deepbinner prep --fastq FASTQ --fast5_dir FAST5_DIR --kit
                       {EXP-NBD103_start,EXP-NBD103_end,SQK-RBK004_start}
                       [--ref REF] [--signal_size SIGNAL_SIZE]
                       [--sequencing_summary SEQUENCING_SUMMARY]
                       [--read_limit READ_LIMIT] [-h]

Prepare training data

Required:
  --fastq FASTQ           a FASTQ file of basecalled reads
  --fast5_dir FAST5_DIR   The directory containing the fast5 files (will be
                          searched recursively, so can contain subdirectories)
  --kit {EXP-NBD103_start,EXP-NBD103_end,SQK-RBK004_start}
                          Which kit was used to sequence the data

Other:
  --ref REF               Reference FASTA file (required for EXP-NBD103 kit)
  --signal_size SIGNAL_SIZE
                          Amount of signal (number of samples) that will be
                          used in the neural network (default: 1024)
  --sequencing_summary SEQUENCING_SUMMARY
                          Basecalling sequencing_summary.txt file (if
                          provided, will be used for barcode classification
                          verification)
  --read_limit READ_LIMIT
                          If provided, will limit the training to this many
                          reads

Other:
  -h, --help              Show this help message and exit
```


## deepbinner_balance

### Tool Description
Select balanced training set

### Metadata
- **Docker Image**: quay.io/biocontainers/deepbinner:0.2.0--py36hc873e9d_0
- **Homepage**: https://github.com/rrwick/Deepbinner
- **Package**: https://anaconda.org/channels/bioconda/packages/deepbinner/overview
- **Validation**: PASS

### Original Help Text
```text
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
usage: deepbinner balance [-h] [--barcodes BARCODES]
                          [--random_signal RANDOM_SIGNAL]
                          training_data [training_data ...]

Select balanced training set

positional arguments:
  training_data           Files of raw training data produced by the prep
                          command

optional arguments:
  -h, --help              show this help message and exit
  --barcodes BARCODES     A comma-delimited list of which barcodes to include
                          (default: include all barcodes)
  --random_signal RANDOM_SIGNAL
                          This many random signals will be added to the output
                          as no-barcode training samples (expressed as a
                          multiple of the balanced per-barcode count, default:
                          1.0)
```


## deepbinner_train

### Tool Description
Train the neural network

### Metadata
- **Docker Image**: quay.io/biocontainers/deepbinner:0.2.0--py36hc873e9d_0
- **Homepage**: https://github.com/rrwick/Deepbinner
- **Package**: https://anaconda.org/channels/bioconda/packages/deepbinner/overview
- **Validation**: PASS

### Original Help Text
```text
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
usage: deepbinner train [-h] --train TRAIN --val VAL --model_out MODEL_OUT
                        [--model_in MODEL_IN] [--epochs EPOCHS] [--aug AUG]
                        [--batch_size BATCH_SIZE]
                        [--batches_per_epoch BATCHES_PER_EPOCH]

Train the neural network

optional arguments:
  -h, --help              show this help message and exit

Required:
  --train TRAIN           Balanced training data produced by the balance
                          command
  --val VAL               Validation data used to assess the training
  --model_out MODEL_OUT   Filename for the trained model

Other:
  --model_in MODEL_IN     An existing model to use as a starting point for
                          training
  --epochs EPOCHS         Number of training epochs (default: 100)
  --aug AUG               Data augmentation factor (1 = no augmentation)
                          (default: 2.0)
  --batch_size BATCH_SIZE
                          Training batch size (default: 20)
  --batches_per_epoch BATCHES_PER_EPOCH
                          The number of samples per epoch will be this times
                          the batch size (default: 5000)
```


## deepbinner_refine

### Tool Description
Refine the training set

### Metadata
- **Docker Image**: quay.io/biocontainers/deepbinner:0.2.0--py36hc873e9d_0
- **Homepage**: https://github.com/rrwick/Deepbinner
- **Package**: https://anaconda.org/channels/bioconda/packages/deepbinner/overview
- **Validation**: PASS

### Original Help Text
```text
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
usage: deepbinner refine [-h] training_data classification_data

Refine the training set

positional arguments:
  training_data        Balanced training data produced by the balance command
  classification_data  Training data barcode calls produced by the classify
                       command

optional arguments:
  -h, --help           show this help message and exit
```

