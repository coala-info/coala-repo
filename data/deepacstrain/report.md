# deepacstrain CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| deepacstrain_convert | Failed | image problem: TensorFlow 2.2 on Python 3.8.6 crashes; eager mode fails with SystemError and --debug-no-eager runs end with a double-free segfault (exit 139). |
| deepacstrain_eval | Failed | image problem: TensorFlow 2.2 on Python 3.8.6 crashes; eager mode fails with SystemError and --debug-no-eager runs end with a double-free segfault (exit 139). |
| deepacstrain_explain_fa2transfac | PASS |  |
| deepacstrain_explain_fcontribs | Failed | image problem: TensorFlow 2.2 on Python 3.8.6 crashes; the run stops with a segmentation fault (exit 139) before it writes its outputs. |
| deepacstrain_explain_franking | PASS |  |
| deepacstrain_explain_maxact | Failed | image problem: TensorFlow 2.2 on Python 3.8.6 crashes; the run finishes its work and then ends with a segmentation fault (exit 139). |
| deepacstrain_explain_mcompare | PASS |  |
| deepacstrain_explain_transfac2IC | PASS |  |
| deepacstrain_explain_weblogos | PASS |  |
| deepacstrain_explain_xlogos | PASS |  |
| deepacstrain_filter | PASS |  |
| deepacstrain_getmodels | Failed | tool bug: getmodels calls os.rmdir on deepac_builtin_models/weights before it exists and stops with FileNotFoundError. |
| deepacstrain_gwpa_factiv | Failed | image problem: TensorFlow 2.2 on Python 3.8.6 crashes; the run finishes its work and then ends with a segmentation fault (exit 139). |
| deepacstrain_gwpa_fenrichment | Failed | image problem: the Python 3.8.6 and TensorFlow 2.2 environment of the image crashes with a segmentation fault (exit 139) while the tool processes the input. |
| deepacstrain_gwpa_fragment | PASS |  |
| deepacstrain_gwpa_genomemap | PASS |  |
| deepacstrain_gwpa_gff2genome | PASS |  |
| deepacstrain_gwpa_granking | Failed | image problem: the Python 3.8.6 and TensorFlow 2.2 environment of the image crashes with a segmentation fault (exit 139) while the tool processes the input. |
| deepacstrain_gwpa_ntcontribs | Failed | image problem: TensorFlow 2.2 on Python 3.8.6 crashes; the run finishes its work and then ends with a segmentation fault (exit 139). |
| deepacstrain_predict | Failed | image problem: TensorFlow 2.2 on Python 3.8.6 crashes; eager mode fails with SystemError and --debug-no-eager runs end with a double-free segfault (exit 139). |
| deepacstrain_preproc | Failed | image problem: TensorFlow 2.2 on Python 3.8.6 crashes; eager mode fails with SystemError and --debug-no-eager runs end with a double-free segfault (exit 139). |
| deepacstrain_templates | PASS |  |
| deepacstrain_train | Failed | image problem: TensorFlow 2.2 on Python 3.8.6 crashes; eager mode fails with SystemError and --debug-no-eager runs end with a double-free segfault (exit 139). |

## deepacstrain_predict

### Tool Description
Predict pathogenic potentials of DNA reads using a trained model.

### Metadata
- **Docker Image**: quay.io/biocontainers/deepacstrain:0.2.1--py_0
- **Homepage**: https://gitlab.com/rki_bioinformatics/DeePaC
- **Package**: https://anaconda.org/channels/bioconda/packages/deepacstrain/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/deepacstrain/overview
- **Total Downloads**: 8.8K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
global options (before the subcommand):
  -h, --help            show this help message and exit
  -v, --version         Print version.
  --debug-no-eager      Disable eager mode.
  --debug-tf DEBUG_TF   Set tensorflow debug info verbosity level. 0 = max, 3
                        = min. Default: 2 (errors); 3 for tests (muted)
  --debug-device        Enable verbose device placement information.
  --force-cpu           Use a CPU even if GPUs are available.
  --tpu TPU             TPU name: 'colab' for Google Colab, or name of your
                        TPU on GCE.

usage: deepac predict [-h] [-a] (-s | -r | -c CUSTOM) [-o OUTPUT] [-n N_CPUS]
                      [-g GPUS [GPUS ...]] [-R] [--plot-kind PLOT_KIND]
                      [--alpha ALPHA] [--replicates REPLICATES]
                      input

positional arguments:
  input                 Input file path [.fasta].

optional arguments:
  -h, --help            show this help message and exit
  -a, --array           Use .npy input instead.
  -s, --sensitive       Use the sensitive model.
  -r, --rapid           Use the rapid CNN model.
  -c CUSTOM, --custom CUSTOM
                        Use the user-supplied, already compiled CUSTOM model.
  -o OUTPUT, --output OUTPUT
                        Output file path [.npy].
  -n N_CPUS, --n-cpus N_CPUS
                        Number of CPU cores. Default: all.
  -g GPUS [GPUS ...], --gpus GPUS [GPUS ...]
                        GPU devices to use (comma-separated). Default: all
  -R, --rc-check        Check RC-constraint compliance (requires .npy input).
  --plot-kind PLOT_KIND
                        Plot kind for the RC-constraint compliance check.
  --alpha ALPHA         Alpha value for the RC-constraint compliance check
                        plot.
  --replicates REPLICATES
                        Number of replicates for MC uncertainty estimation.
```


## deepacstrain_filter

### Tool Description
Filter prediction results (reads in a fasta file by pathogenic potential).

### Metadata
- **Docker Image**: quay.io/biocontainers/deepacstrain:0.2.1--py_0
- **Homepage**: https://gitlab.com/rki_bioinformatics/DeePaC
- **Package**: https://anaconda.org/channels/bioconda/packages/deepacstrain/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/deepacstrain/overview
- **Total Downloads**: 8.8K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
global options (before the subcommand):
  -h, --help            show this help message and exit
  -v, --version         Print version.
  --debug-no-eager      Disable eager mode.
  --debug-tf DEBUG_TF   Set tensorflow debug info verbosity level. 0 = max, 3
                        = min. Default: 2 (errors); 3 for tests (muted)
  --debug-device        Enable verbose device placement information.
  --force-cpu           Use a CPU even if GPUs are available.
  --tpu TPU             TPU name: 'colab' for Google Colab, or name of your
                        TPU on GCE.

usage: deepac filter [-h] [-t THRESHOLD] [-p] [-o OUTPUT] [-s STD]
                     [--precision PRECISION]
                     input predictions

positional arguments:
  input                 Input file path [.fasta].
  predictions           Predictions in matching order [.npy].

optional arguments:
  -h, --help            show this help message and exit
  -t THRESHOLD, --threshold THRESHOLD
                        Threshold [default=0.5].
  -p, --potentials      Print pathogenic potential values in .fasta headers.
  -o OUTPUT, --output OUTPUT
                        Output file path [.fasta].
  -s STD, --std STD     Standard deviations of predictions if MC dropout used.
  --precision PRECISION
                        Format pathogenic potentials to given precision
                        [default=3].
```


## deepacstrain_preproc

### Tool Description
Convert fasta files to numpy arrays for training.

### Metadata
- **Docker Image**: quay.io/biocontainers/deepacstrain:0.2.1--py_0
- **Homepage**: https://gitlab.com/rki_bioinformatics/DeePaC
- **Package**: https://anaconda.org/channels/bioconda/packages/deepacstrain/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/deepacstrain/overview
- **Total Downloads**: 8.8K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
global options (before the subcommand):
  -h, --help            show this help message and exit
  -v, --version         Print version.
  --debug-no-eager      Disable eager mode.
  --debug-tf DEBUG_TF   Set tensorflow debug info verbosity level. 0 = max, 3
                        = min. Default: 2 (errors); 3 for tests (muted)
  --debug-device        Enable verbose device placement information.
  --force-cpu           Use a CPU even if GPUs are available.
  --tpu TPU             TPU name: 'colab' for Google Colab, or name of your
                        TPU on GCE.

usage: deepac preproc [-h] config

positional arguments:
  config      Preprocessing config file.

optional arguments:
  -h, --help  show this help message and exit
```


## deepacstrain_train

### Tool Description
Train a new model.

### Metadata
- **Docker Image**: quay.io/biocontainers/deepacstrain:0.2.1--py_0
- **Homepage**: https://gitlab.com/rki_bioinformatics/DeePaC
- **Package**: https://anaconda.org/channels/bioconda/packages/deepacstrain/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/deepacstrain/overview
- **Total Downloads**: 8.8K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
global options (before the subcommand):
  -h, --help            show this help message and exit
  -v, --version         Print version.
  --debug-no-eager      Disable eager mode.
  --debug-tf DEBUG_TF   Set tensorflow debug info verbosity level. 0 = max, 3
                        = min. Default: 2 (errors); 3 for tests (muted)
  --debug-device        Enable verbose device placement information.
  --force-cpu           Use a CPU even if GPUs are available.
  --tpu TPU             TPU name: 'colab' for Google Colab, or name of your
                        TPU on GCE.

usage: deepac train [-h] (-s | -r | -c CUSTOM) [-n N_CPUS]
                    [-g GPUS [GPUS ...]] [-T TRAIN_DATA] [-t TRAIN_LABELS]
                    [-V VAL_DATA] [-v VAL_LABELS] [-R RUN_NAME]

optional arguments:
  -h, --help            show this help message and exit
  -s, --sensitive       Use the sensitive model.
  -r, --rapid           Use the rapid CNN model.
  -c CUSTOM, --custom CUSTOM
                        Use the user-supplied configuration file.
  -n N_CPUS, --n-cpus N_CPUS
                        Number of CPU cores. Default: all.
  -g GPUS [GPUS ...], --gpus GPUS [GPUS ...]
                        GPU devices to use (comma-separated). Default: all
  -T TRAIN_DATA, --train-data TRAIN_DATA
                        Path to training data.
  -t TRAIN_LABELS, --train-labels TRAIN_LABELS
                        Path to training labels.
  -V VAL_DATA, --val-data VAL_DATA
                        Path to validation data.
  -v VAL_LABELS, --val-labels VAL_LABELS
                        Path to validation labels.
  -R RUN_NAME, --run-name RUN_NAME
                        Run name (default: based on chosen config).
```


## deepacstrain_eval

### Tool Description
Evaluate a trained model (species-wise, read-wise or ensemble).

### Metadata
- **Docker Image**: quay.io/biocontainers/deepacstrain:0.2.1--py_0
- **Homepage**: https://gitlab.com/rki_bioinformatics/DeePaC
- **Package**: https://anaconda.org/channels/bioconda/packages/deepacstrain/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/deepacstrain/overview
- **Total Downloads**: 8.8K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
global options (before the subcommand):
  -h, --help            show this help message and exit
  -v, --version         Print version.
  --debug-no-eager      Disable eager mode.
  --debug-tf DEBUG_TF   Set tensorflow debug info verbosity level. 0 = max, 3
                        = min. Default: 2 (errors); 3 for tests (muted)
  --debug-device        Enable verbose device placement information.
  --force-cpu           Use a CPU even if GPUs are available.
  --tpu TPU             TPU name: 'colab' for Google Colab, or name of your
                        TPU on GCE.

usage: deepac eval [-h] (-s SPECIES_CONFIG | -r READS_CONFIG | -e ENS_CONFIG)

optional arguments:
  -h, --help            show this help message and exit
  -s SPECIES_CONFIG, --species SPECIES_CONFIG
                        Species-wise evaluation.
  -r READS_CONFIG, --reads READS_CONFIG
                        Read-wise evaluation.
  -e ENS_CONFIG, --ensemble ENS_CONFIG
                        Simple ensemble evaluation.
```


## deepacstrain_convert

### Tool Description
Convert and compile a model to an equivalent.

### Metadata
- **Docker Image**: quay.io/biocontainers/deepacstrain:0.2.1--py_0
- **Homepage**: https://gitlab.com/rki_bioinformatics/DeePaC
- **Package**: https://anaconda.org/channels/bioconda/packages/deepacstrain/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/deepacstrain/overview
- **Total Downloads**: 8.8K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
global options (before the subcommand):
  -h, --help            show this help message and exit
  -v, --version         Print version.
  --debug-no-eager      Disable eager mode.
  --debug-tf DEBUG_TF   Set tensorflow debug info verbosity level. 0 = max, 3
                        = min. Default: 2 (errors); 3 for tests (muted)
  --debug-device        Enable verbose device placement information.
  --force-cpu           Use a CPU even if GPUs are available.
  --tpu TPU             TPU name: 'colab' for Google Colab, or name of your
                        TPU on GCE.

usage: deepac convert [-h] [-w] [-i] config model

positional arguments:
  config         Training config file.
  model          Saved model.

optional arguments:
  -h, --help     show this help message and exit
  -w, --weights  Use prepared weights instead of the model file.
  -i, --init     Initialize a random model from config.
```


## deepacstrain_getmodels

### Tool Description
Get built-in weights and rebuild built-in models.

### Metadata
- **Docker Image**: quay.io/biocontainers/deepacstrain:0.2.1--py_0
- **Homepage**: https://gitlab.com/rki_bioinformatics/DeePaC
- **Package**: https://anaconda.org/channels/bioconda/packages/deepacstrain/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/deepacstrain/overview
- **Total Downloads**: 8.8K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
global options (before the subcommand):
  -h, --help            show this help message and exit
  -v, --version         Print version.
  --debug-no-eager      Disable eager mode.
  --debug-tf DEBUG_TF   Set tensorflow debug info verbosity level. 0 = max, 3
                        = min. Default: 2 (errors); 3 for tests (muted)
  --debug-device        Enable verbose device placement information.
  --force-cpu           Use a CPU even if GPUs are available.
  --tpu TPU             TPU name: 'colab' for Google Colab, or name of your
                        TPU on GCE.

usage: deepac getmodels [-h] [-s] [-r]

optional arguments:
  -h, --help       show this help message and exit

  -s, --sensitive  Rebuild the sensitive model.
  -r, --rapid      Rebuild the rapid CNN model.
```


## deepacstrain_templates

### Tool Description
Get config templates (in this directory).

### Metadata
- **Docker Image**: quay.io/biocontainers/deepacstrain:0.2.1--py_0
- **Homepage**: https://gitlab.com/rki_bioinformatics/DeePaC
- **Package**: https://anaconda.org/channels/bioconda/packages/deepacstrain/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/deepacstrain/overview
- **Total Downloads**: 8.8K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
global options (before the subcommand):
  -h, --help            show this help message and exit
  -v, --version         Print version.
  --debug-no-eager      Disable eager mode.
  --debug-tf DEBUG_TF   Set tensorflow debug info verbosity level. 0 = max, 3
                        = min. Default: 2 (errors); 3 for tests (muted)
  --debug-device        Enable verbose device placement information.
  --force-cpu           Use a CPU even if GPUs are available.
  --tpu TPU             TPU name: 'colab' for Google Colab, or name of your
                        TPU on GCE.

usage: deepac templates [-h]

optional arguments:
  -h, --help  show this help message and exit
```


## deepacstrain_explain_fa2transfac

### Tool Description
Calculate transfac from fasta files.

### Metadata
- **Docker Image**: quay.io/biocontainers/deepacstrain:0.2.1--py_0
- **Homepage**: https://gitlab.com/rki_bioinformatics/DeePaC
- **Package**: https://anaconda.org/channels/bioconda/packages/deepacstrain/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/deepacstrain/overview
- **Total Downloads**: 8.8K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
DeePaC-strain 0.2.1. Using bacterial strain models.
usage: deepac explain fa2transfac [-h] -i IN_DIR -o OUT_DIR [-w]
                                  [-W WEIGHT_DIR]

optional arguments:
  -h, --help            show this help message and exit
  -i IN_DIR, --in-dir IN_DIR
                        Directory containing motifs per filter (.fasta)
  -o OUT_DIR, --out-dir OUT_DIR
                        Output directory
  -w, --weighting       Weight sequences by their DeepLIFT score
  -W WEIGHT_DIR, --weight-dir WEIGHT_DIR
                        Directory containing the DeepLIFT scores per filter
                        (only required if --weighting is chosen)
```

## deepacstrain_explain_fcontribs

### Tool Description
Get DeepLIFT/SHAP filter contribution scores.

### Metadata
- **Docker Image**: quay.io/biocontainers/deepacstrain:0.2.1--py_0
- **Homepage**: https://gitlab.com/rki_bioinformatics/DeePaC
- **Package**: https://anaconda.org/channels/bioconda/packages/deepacstrain/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/deepacstrain/overview
- **Total Downloads**: 8.8K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
DeePaC-strain 0.2.1. Using bacterial strain models.
usage: deepac explain fcontribs [-h] -m MODEL [-b] -t TEST_DATA -N
                                NONPATHO_TEST -P PATHO_TEST [-o OUT_DIR]
                                [-r {N,GC,own_ref_file}] [-a TRAIN_DATA]
                                [-F REF_SEQS]
                                [-i [INTER_NEURON [INTER_NEURON ...]]]
                                [-l INTER_LAYER] [-c CHUNK_SIZE] [-A] [-R]
                                [--no-check] [-p | -e]

optional arguments:
  -h, --help            show this help message and exit
  -m MODEL, --model MODEL
                        Model file (.h5)
  -b, --w-norm          Set flag if filter weight matrices should be mean-
                        centered
  -t TEST_DATA, --test_data TEST_DATA
                        Test data (.npy)
  -N NONPATHO_TEST, --nonpatho-test NONPATHO_TEST
                        Nonpathogenic reads of the test data set (.fasta)
  -P PATHO_TEST, --patho-test PATHO_TEST
                        Pathogenic reads of the test data set (.fasta)
  -o OUT_DIR, --out-dir OUT_DIR
                        Output directory
  -r {N,GC,own_ref_file}, --ref-mode {N,GC,own_ref_file}
                        Modus to calculate reference sequences
  -a TRAIN_DATA, --train-data TRAIN_DATA
                        Train data (.npy), necessary to calculate reference
                        sequences if ref_mode is 'GC'
  -F REF_SEQS, --ref-seqs REF_SEQS
                        User provided reference sequences (.fasta) if ref_mode
                        is 'own_ref_file'
  -i [INTER_NEURON [INTER_NEURON ...]], --inter-neuron [INTER_NEURON [INTER_NEURON ...]]
                        Perform calculations for this intermediate neuron only
  -l INTER_LAYER, --inter-layer INTER_LAYER
                        Perform calculations for this intermediate layer
  -c CHUNK_SIZE, --seq-chunk CHUNK_SIZE
                        Sequence chunk size. Decrease for lower memory usage.
  -A, --all-occurrences
                        Extract contributions for all occurrences of a filter
                        per read (Default: max only)
  -R, --recurrent       Interpret elements of the LSTM output
  --no-check            Disable additivity check.
  -p, --partial         Calculate partial nucleotide contributions per filter.
  -e, --easy-partial    Calculate easy partial nucleotide contributions per
                        filter. Works for the first convolutional layer only;
                        disables all-occurences mode.
```

## deepacstrain_explain_franking

### Tool Description
Generate filter rankings.

### Metadata
- **Docker Image**: quay.io/biocontainers/deepacstrain:0.2.1--py_0
- **Homepage**: https://gitlab.com/rki_bioinformatics/DeePaC
- **Package**: https://anaconda.org/channels/bioconda/packages/deepacstrain/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/deepacstrain/overview
- **Total Downloads**: 8.8K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
DeePaC-strain 0.2.1. Using bacterial strain models.
usage: deepac explain franking [-h]
                               [-m {original,rel_true_class,rel_pred_class}]
                               -f SCORES_DIR -y TRUE_LABEL -p PRED_LABEL -o
                               OUT_DIR

optional arguments:
  -h, --help            show this help message and exit
  -m {original,rel_true_class,rel_pred_class}, --mode {original,rel_true_class,rel_pred_class}
                        Use original filter scores or normalize scores
                        relative to true or predicted classes.
  -f SCORES_DIR, --scores-dir SCORES_DIR
                        Directory containing filter contribution scores (.csv)
  -y TRUE_LABEL, --true-label TRUE_LABEL
                        File with true read labels (.npy)
  -p PRED_LABEL, --pred-label PRED_LABEL
                        File with predicted read labels (.npy)
  -o OUT_DIR, --out-dir OUT_DIR
                        Output directory
```

## deepacstrain_explain_maxact

### Tool Description
Get DeepBind-like max-activation scores.

### Metadata
- **Docker Image**: quay.io/biocontainers/deepacstrain:0.2.1--py_0
- **Homepage**: https://gitlab.com/rki_bioinformatics/DeePaC
- **Package**: https://anaconda.org/channels/bioconda/packages/deepacstrain/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/deepacstrain/overview
- **Total Downloads**: 8.8K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
DeePaC-strain 0.2.1. Using bacterial strain models.
usage: deepac explain maxact [-h] -m MODEL -t TEST_DATA -N NONPATHO_TEST -P
                             PATHO_TEST [-o OUT_DIR] [-n N_CPUS] [-R]
                             [-l INTER_LAYER] [-c CHUNK_SIZE]

optional arguments:
  -h, --help            show this help message and exit
  -m MODEL, --model MODEL
                        Model file (.h5)
  -t TEST_DATA, --test-data TEST_DATA
                        Test data (.npy)
  -N NONPATHO_TEST, --nonpatho-test NONPATHO_TEST
                        Nonpathogenic reads of the test data set (.fasta)
  -P PATHO_TEST, --patho-test PATHO_TEST
                        Pathogenic reads of the test data set (.fasta)
  -o OUT_DIR, --out-dir OUT_DIR
                        Output directory
  -n N_CPUS, --n-cpus N_CPUS
                        Number of CPU cores. Default: all.
  -R, --recurrent       Interpret elements of the LSTM output
  -l INTER_LAYER, --inter-layer INTER_LAYER
                        Perform calculations for this intermediate layer
  -c CHUNK_SIZE, --seq-chunk CHUNK_SIZE
                        Sequence chunk size. Decrease for lower memory usage.
```

## deepacstrain_explain_mcompare

### Tool Description
Compare motifs.

### Metadata
- **Docker Image**: quay.io/biocontainers/deepacstrain:0.2.1--py_0
- **Homepage**: https://gitlab.com/rki_bioinformatics/DeePaC
- **Package**: https://anaconda.org/channels/bioconda/packages/deepacstrain/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/deepacstrain/overview
- **Total Downloads**: 8.8K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
DeePaC-strain 0.2.1. Using bacterial strain models.
usage: deepac explain mcompare [-h] -q IN_FILE1 -t IN_FILE2 [-a TRAIN_DATA]
                               [-e] [-r] [-s] [-m MIN_OVERLAP] [-o OUT_DIR]

optional arguments:
  -h, --help            show this help message and exit
  -q IN_FILE1, --in-file1 IN_FILE1
                        File containing all filter motifs in transfac format
  -t IN_FILE2, --in-file2 IN_FILE2
                        File containing all filter motifs in transfac format
  -a TRAIN_DATA, --train-data TRAIN_DATA
                        Training data (.npy), necessary to calculate
                        background GC content
  -e, --extensively     Compare every motif from --in_file1 with every motif
                        from --in_file2; default: compare only motifs with the
                        same ID
  -r, --rc              Consider RC-complement of a motif
  -s, --shift           Shift motifs to find best alignment
  -m MIN_OVERLAP, --min-overlap MIN_OVERLAP
                        Minimal overlap between two motifs if motifs are
                        shifted to find the best alignment (--shift)
  -o OUT_DIR, --out-dir OUT_DIR
                        Output directory
```

## deepacstrain_explain_transfac2IC

### Tool Description
Calculate information content from transfac files.

### Metadata
- **Docker Image**: quay.io/biocontainers/deepacstrain:0.2.1--py_0
- **Homepage**: https://gitlab.com/rki_bioinformatics/DeePaC
- **Package**: https://anaconda.org/channels/bioconda/packages/deepacstrain/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/deepacstrain/overview
- **Total Downloads**: 8.8K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
DeePaC-strain 0.2.1. Using bacterial strain models.
usage: deepac explain transfac2IC [-h] -i IN_FILE -t TRAIN [-o OUT_FILE]

optional arguments:
  -h, --help            show this help message and exit
  -i IN_FILE, --in-file IN_FILE
                        File containing all filter motifs in transfac format
  -t TRAIN, --train TRAIN
                        Training data set (.npy) to normalize for GC-content
  -o OUT_FILE, --out-file OUT_FILE
                        Name of the output file
```

## deepacstrain_explain_weblogos

### Tool Description
Get sequence logos.

### Metadata
- **Docker Image**: quay.io/biocontainers/deepacstrain:0.2.1--py_0
- **Homepage**: https://gitlab.com/rki_bioinformatics/DeePaC
- **Package**: https://anaconda.org/channels/bioconda/packages/deepacstrain/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/deepacstrain/overview
- **Total Downloads**: 8.8K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
DeePaC-strain 0.2.1. Using bacterial strain models.
usage: deepac explain weblogos [-h] -i IN_DIR [-f {.fasta,.transfac}]
                               [-t TRAIN_DATA] -o OUT_DIR

optional arguments:
  -h, --help            show this help message and exit
  -i IN_DIR, --in-dir IN_DIR
                        Directory containing motifs per filter
  -f {.fasta,.transfac}, --file-ext {.fasta,.transfac}
                        Extension of file format of input files (.fasta or
                        .transfac)
  -t TRAIN_DATA, --train-data TRAIN_DATA
                        Training data set (.npy) to compute GC-content.
                        N-padding lowers GC!
  -o OUT_DIR, --out-dir OUT_DIR
                        Output directory
```

## deepacstrain_explain_xlogos

### Tool Description
Get extended sequence logos.

### Metadata
- **Docker Image**: quay.io/biocontainers/deepacstrain:0.2.1--py_0
- **Homepage**: https://gitlab.com/rki_bioinformatics/DeePaC
- **Package**: https://anaconda.org/channels/bioconda/packages/deepacstrain/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/deepacstrain/overview
- **Total Downloads**: 8.8K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
DeePaC-strain 0.2.1. Using bacterial strain models.
usage: deepac explain xlogos [-h] -i FASTA_DIR -s SCORES_DIR [-I LOGO_DIR]
                             [-G GAIN] [-t TRAIN_DATA] -o OUT_DIR

optional arguments:
  -h, --help            show this help message and exit
  -i FASTA_DIR, --fasta-dir FASTA_DIR
                        Directory containing motifs per filter (.fasta)
  -s SCORES_DIR, --scores-dir SCORES_DIR
                        Directory containing nucleotide scores per filter
                        (.csv)
  -I LOGO_DIR, --logo-dir LOGO_DIR
                        Directory containing motifs in weighted transfac
                        format (only required if weighted weblogos should be
                        created)
  -G GAIN, --gain GAIN  Color saturation gain. Weblogo colors reach saturation
                        when the average nt score=1/gain. Default: 128000.
                        Recommended: input length * number of filters.
  -t TRAIN_DATA, --train-data TRAIN_DATA
                        Training data set to compute GC-content
  -o OUT_DIR, --out-dir OUT_DIR
                        Output directory
```

## deepacstrain_gwpa_factiv

### Tool Description
Get filter activations.

### Metadata
- **Docker Image**: quay.io/biocontainers/deepacstrain:0.2.1--py_0
- **Homepage**: https://gitlab.com/rki_bioinformatics/DeePaC
- **Package**: https://anaconda.org/channels/bioconda/packages/deepacstrain/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/deepacstrain/overview
- **Total Downloads**: 8.8K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
DeePaC-strain 0.2.1. Using bacterial strain models.
usage: deepac gwpa factiv [-h] -m MODEL -t TEST_DATA -f TEST_FASTA
                          [-o OUT_DIR] [-l INTER_LAYER] [-c CHUNK_SIZE]
                          [-F [INTER_NEURON [INTER_NEURON ...]]]

optional arguments:
  -h, --help            show this help message and exit
  -m MODEL, --model MODEL
                        Model file (.h5)
  -t TEST_DATA, --test-data TEST_DATA
                        Test data (.npy)
  -f TEST_FASTA, --test-fasta TEST_FASTA
                        Reads of the test data set (.fasta)
  -o OUT_DIR, --out-dir OUT_DIR
                        Output directory
  -l INTER_LAYER, --inter-layer INTER_LAYER
                        Perform calculations for this intermediate layer
  -c CHUNK_SIZE, --seq-chunk CHUNK_SIZE
                        Sequence chunk size. Decrease for lower memory usage.
  -F [INTER_NEURON [INTER_NEURON ...]], --inter-neuron [INTER_NEURON [INTER_NEURON ...]]
                        Perform calculations for this filter only
```

## deepacstrain_gwpa_fenrichment

### Tool Description
Run filter enrichment analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/deepacstrain:0.2.1--py_0
- **Homepage**: https://gitlab.com/rki_bioinformatics/DeePaC
- **Package**: https://anaconda.org/channels/bioconda/packages/deepacstrain/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/deepacstrain/overview
- **Total Downloads**: 8.8K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
DeePaC-strain 0.2.1. Using bacterial strain models.
usage: deepac gwpa fenrichment [-h] -i BED_DIR -g GFF [-o OUT_DIR]
                               [-l MOTIF_LENGTH] [-n N_CPUS] [-x]

optional arguments:
  -h, --help            show this help message and exit
  -i BED_DIR, --bed-dir BED_DIR
                        Input directory with filter activation values for a
                        species (.bed)
  -g GFF, --gff GFF     Gff file of species
  -o OUT_DIR, --out-dir OUT_DIR
                        Output directory
  -l MOTIF_LENGTH, --motif-length MOTIF_LENGTH
                        Motif length
  -n N_CPUS, --n-cpus N_CPUS
                        Number of CPU cores.
  -x, --extended        Check for multiple CDSs per gene and unnamed genes.
```

## deepacstrain_gwpa_fragment

### Tool Description
Fragment genomes for analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/deepacstrain:0.2.1--py_0
- **Homepage**: https://gitlab.com/rki_bioinformatics/DeePaC
- **Package**: https://anaconda.org/channels/bioconda/packages/deepacstrain/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/deepacstrain/overview
- **Total Downloads**: 8.8K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
DeePaC-strain 0.2.1. Using bacterial strain models.
usage: deepac gwpa fragment [-h] -g GENOMES_DIR [-r READ_LEN] [-s SHIFT]
                            [-o OUT_DIR]

optional arguments:
  -h, --help            show this help message and exit
  -g GENOMES_DIR, --genomes-dir GENOMES_DIR
                        Directory containing genomes in .fasta
  -r READ_LEN, --read_len READ_LEN
                        Length of extracted reads/fragments (default: 250)
  -s SHIFT, --shift SHIFT
                        Shift to start with the next fragment (default:50)
  -o OUT_DIR, --out-dir OUT_DIR
                        Output directory
```

## deepacstrain_gwpa_genomemap

### Tool Description
Generate a genome-wide phenotype potential map.

### Metadata
- **Docker Image**: quay.io/biocontainers/deepacstrain:0.2.1--py_0
- **Homepage**: https://gitlab.com/rki_bioinformatics/DeePaC
- **Package**: https://anaconda.org/channels/bioconda/packages/deepacstrain/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/deepacstrain/overview
- **Total Downloads**: 8.8K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
DeePaC-strain 0.2.1. Using bacterial strain models.
usage: deepac gwpa genomemap [-h] -f DIR_FRAGMENTED_GENOMES -p
                             DIR_FRAGMENTED_GENOMES_PREDS -g GENOMES_DIR
                             [-o OUT_DIR]

optional arguments:
  -h, --help            show this help message and exit
  -f DIR_FRAGMENTED_GENOMES, --dir-fragmented-genomes DIR_FRAGMENTED_GENOMES
                        Directory containing the fragmented genomes (.fasta)
  -p DIR_FRAGMENTED_GENOMES_PREDS, --dir-fragmented-genomes-preds DIR_FRAGMENTED_GENOMES_PREDS
                        Directory containing the predictions (.npy) of the
                        fragmented genomes
  -g GENOMES_DIR, --genomes-dir GENOMES_DIR
                        Directory containing genomes (.genome)
  -o OUT_DIR, --out-dir OUT_DIR
                        Output directory
```

## deepacstrain_gwpa_gff2genome

### Tool Description
Generate .genome files.

### Metadata
- **Docker Image**: quay.io/biocontainers/deepacstrain:0.2.1--py_0
- **Homepage**: https://gitlab.com/rki_bioinformatics/DeePaC
- **Package**: https://anaconda.org/channels/bioconda/packages/deepacstrain/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/deepacstrain/overview
- **Total Downloads**: 8.8K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
DeePaC-strain 0.2.1. Using bacterial strain models.
usage: deepac gwpa gff2genome [-h] gff3_dir out_dir

positional arguments:
  gff3_dir    Input directory.
  out_dir     Output directory.

optional arguments:
  -h, --help  show this help message and exit
```

## deepacstrain_gwpa_granking

### Tool Description
Generate gene rankings.

### Metadata
- **Docker Image**: quay.io/biocontainers/deepacstrain:0.2.1--py_0
- **Homepage**: https://gitlab.com/rki_bioinformatics/DeePaC
- **Package**: https://anaconda.org/channels/bioconda/packages/deepacstrain/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/deepacstrain/overview
- **Total Downloads**: 8.8K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
DeePaC-strain 0.2.1. Using bacterial strain models.
usage: deepac gwpa granking [-h] -p PATHO_DIR -g GFF_DIR [-o OUT_DIR] [-x]
                            [-n N_CPUS]

optional arguments:
  -h, --help            show this help message and exit
  -p PATHO_DIR, --patho-dir PATHO_DIR
                        Directory containing the pathogenicity scores over all
                        genomic regions per species (.bedgraph)
  -g GFF_DIR, --gff-dir GFF_DIR
                        Directory containing the annotation data of the
                        species (.gff)
  -o OUT_DIR, --out-dir OUT_DIR
                        Output directory
  -x, --extended        Check for multiple CDSs per gene and unnamed genes.
  -n N_CPUS, --n-cpus N_CPUS
                        Number of CPU cores.
```

## deepacstrain_gwpa_ntcontribs

### Tool Description
Generate a genome-wide nt contribution map.

### Metadata
- **Docker Image**: quay.io/biocontainers/deepacstrain:0.2.1--py_0
- **Homepage**: https://gitlab.com/rki_bioinformatics/DeePaC
- **Package**: https://anaconda.org/channels/bioconda/packages/deepacstrain/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/deepacstrain/overview
- **Total Downloads**: 8.8K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
DeePaC-strain 0.2.1. Using bacterial strain models.
usage: deepac gwpa ntcontribs [-h] -m MODEL -f DIR_FRAGMENTED_GENOMES -g
                              GENOMES_DIR [-o OUT_DIR]
                              [-r {N,GC,own_ref_file}] [-a TRAIN_DATA]
                              [-F REF_SEQS] [-L READ_LENGTH] [-c CHUNK_SIZE]
                              [-G] [--no-check]

optional arguments:
  -h, --help            show this help message and exit
  -m MODEL, --model MODEL
                        Model file (.h5)
  -f DIR_FRAGMENTED_GENOMES, --dir-fragmented-genomes DIR_FRAGMENTED_GENOMES
                        Directory containing the fragmented genomes (.fasta)
  -g GENOMES_DIR, --genomes-dir GENOMES_DIR
                        Directory containing genomes (.genome)
  -o OUT_DIR, --out-dir OUT_DIR
                        Output directory
  -r {N,GC,own_ref_file}, --ref-mode {N,GC,own_ref_file}
                        Modus to calculate reference sequences
  -a TRAIN_DATA, --train-data TRAIN_DATA
                        Train data (.npy), necessary to calculate reference
                        sequences if ref_mode is 'GC'
  -F REF_SEQS, --ref-seqs REF_SEQS
                        User provided reference sequences (.fasta) if ref_mode
                        is 'own_ref_file'
  -L READ_LENGTH, --read-length READ_LENGTH
                        Fragment length
  -c CHUNK_SIZE, --seq-chunk CHUNK_SIZE
                        Sequence chunk size. Decrease for lower memory usage.
  -G, --gradient        Use Integrated Gradients instead of DeepLIFT.
  --no-check            Disable additivity check.
```

## Metadata
- **Skill**: not generated
