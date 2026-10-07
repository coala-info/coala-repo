# deepacstrain CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| deepacstrain_convert | Failed | image problem: TensorFlow 2.2 on Python 3.8.6 crashes; eager mode fails with SystemError and --debug-no-eager runs end with a double-free segfault (exit 139). |
| deepacstrain_eval | Failed | image problem: TensorFlow 2.2 on Python 3.8.6 crashes; eager mode fails with SystemError and --debug-no-eager runs end with a double-free segfault (exit 139). |
| deepacstrain_filter | PASS |  |
| deepacstrain_getmodels | Failed | tool bug: getmodels calls os.rmdir on deepac_builtin_models/weights before it exists and stops with FileNotFoundError. |
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


## Metadata
- **Skill**: not generated
