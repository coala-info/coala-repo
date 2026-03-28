# deepac CWL Generation Report

## deepac_predict

### Tool Description
Predicts the presence of bacteriophages in DNA sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/deepac:0.14.1--pyhdfd78af_0
- **Homepage**: https://gitlab.com/rki_bioinformatics/DeePaC
- **Package**: https://anaconda.org/channels/bioconda/packages/deepac/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/deepac/overview
- **Total Downloads**: 44.2K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: deepac predict [-h] [-a] (-s | -r | -c CUSTOM) [-o OUTPUT] [-n N_CPUS]
                      [-g GPUS [GPUS ...]] [-R] [-b BATCH_SIZE] [--get-logits]
                      [--plot-kind PLOT_KIND] [--alpha ALPHA]
                      [--replicates REPLICATES] [--trim]
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
  -b BATCH_SIZE, --batch-size BATCH_SIZE
                        Batch size.
  --get-logits          Return logits instead of the final predictions.
  --plot-kind PLOT_KIND
                        Plot kind for the RC-constraint compliance check.
  --alpha ALPHA         Alpha value for the RC-constraint compliance check
                        plot.
  --replicates REPLICATES
                        Number of replicates for MC uncertainty estimation.
  --trim                Automatically trim the sequences to the read length
                        specified by the input size of the model (if using
                        fasta input).
```


## deepac_filter

### Tool Description
Filter predictions based on thresholds and classes.

### Metadata
- **Docker Image**: quay.io/biocontainers/deepac:0.14.1--pyhdfd78af_0
- **Homepage**: https://gitlab.com/rki_bioinformatics/DeePaC
- **Package**: https://anaconda.org/channels/bioconda/packages/deepac/overview
- **Validation**: PASS

### Original Help Text
```text
usage: deepac filter [-h] [-r PAIRED_FASTA] [-R PAIRED_PREDICTIONS]
                     [-t THRESHOLD] [-c C_THRESH] [-o OUTPUT] [-s STD]
                     [-n N_CLASSES]
                     [-P POSITIVE_CLASSES [POSITIVE_CLASSES ...]] [-p]
                     [--precision PRECISION] [--neg-output NEG_OUTPUT]
                     [--undef-output UNDEF_OUTPUT]
                     input predictions

positional arguments:
  input                 Input file path [.fasta].
  predictions           Predictions in matching order [.npy].

optional arguments:
  -h, --help            show this help message and exit
  -r PAIRED_FASTA, --paired-fasta PAIRED_FASTA
                        Second mate input file path [.fasta].
  -R PAIRED_PREDICTIONS, --paired-predictions PAIRED_PREDICTIONS
                        Second mate predictions in matching order [.npy].
  -t THRESHOLD, --threshold THRESHOLD
                        Threshold for binary classification [default=0.5].
  -c C_THRESH, --confidence-threshold C_THRESH
                        Confidence threshold [default=None].
  -o OUTPUT, --output OUTPUT
                        Output file path for positive predictions [.fasta].
  -s STD, --std STD     Standard deviations of predictions if MC dropout used.
  -n N_CLASSES, --n-classes N_CLASSES
                        Format pathogenic potentials to given precision
                        [default=2].
  -P POSITIVE_CLASSES [POSITIVE_CLASSES ...], --positive-classes POSITIVE_CLASSES [POSITIVE_CLASSES ...]
                        Format pathogenic potentials to given precision
                        [default=1].
  -p, --potentials      Print pathogenic potential values in .fasta headers.
  --precision PRECISION
                        Format pathogenic potentials to given precision
                        [default=3].
  --neg-output NEG_OUTPUT
                        Output file path for negative predictions [.fasta].
  --undef-output UNDEF_OUTPUT
                        Output file path for predictions not passing the
                        confidence threshold [.fasta].
```


## deepac_train

### Tool Description
Train a deep learning model for DNA classification.

### Metadata
- **Docker Image**: quay.io/biocontainers/deepac:0.14.1--pyhdfd78af_0
- **Homepage**: https://gitlab.com/rki_bioinformatics/DeePaC
- **Package**: https://anaconda.org/channels/bioconda/packages/deepac/overview
- **Validation**: PASS

### Original Help Text
```text
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


## deepac_preproc

### Tool Description
Preprocessing config file.

### Metadata
- **Docker Image**: quay.io/biocontainers/deepac:0.14.1--pyhdfd78af_0
- **Homepage**: https://gitlab.com/rki_bioinformatics/DeePaC
- **Package**: https://anaconda.org/channels/bioconda/packages/deepac/overview
- **Validation**: PASS

### Original Help Text
```text
usage: deepac preproc [-h] [--trim] config

positional arguments:
  config      Preprocessing config file.

optional arguments:
  -h, --help  show this help message and exit
  --trim      Automatically trim the sequences to the read length specified in
              the config file.
```


## deepac_eval

### Tool Description
Evaluate deep-AC models.

### Metadata
- **Docker Image**: quay.io/biocontainers/deepac:0.14.1--pyhdfd78af_0
- **Homepage**: https://gitlab.com/rki_bioinformatics/DeePaC
- **Package**: https://anaconda.org/channels/bioconda/packages/deepac/overview
- **Validation**: PASS

### Original Help Text
```text
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


## deepac_convert

### Tool Description
Convert a trained deepac model to a format suitable for inference.

### Metadata
- **Docker Image**: quay.io/biocontainers/deepac:0.14.1--pyhdfd78af_0
- **Homepage**: https://gitlab.com/rki_bioinformatics/DeePaC
- **Package**: https://anaconda.org/channels/bioconda/packages/deepac/overview
- **Validation**: PASS

### Original Help Text
```text
usage: deepac convert [-h] [-w] [-i] config model

positional arguments:
  config         Training config file.
  model          Saved model.

optional arguments:
  -h, --help     show this help message and exit
  -w, --weights  Use prepared weights instead of the model file.
  -i, --init     Initialize a random model from config.
```


## deepac_getmodels

### Tool Description
Rebuilds or fetches deep learning models for deep-AMR.

### Metadata
- **Docker Image**: quay.io/biocontainers/deepac:0.14.1--pyhdfd78af_0
- **Homepage**: https://gitlab.com/rki_bioinformatics/DeePaC
- **Package**: https://anaconda.org/channels/bioconda/packages/deepac/overview
- **Validation**: PASS

### Original Help Text
```text
usage: deepac getmodels [-h] [-s] [-r] [-f | --download-only]

optional arguments:
  -h, --help       show this help message and exit

  -s, --sensitive  Rebuild the sensitive model.
  -r, --rapid      Rebuild the rapid CNN model.
  -f, --fetch      Fetch and compile the latest models and configs from the
                   online repository.
  --download-only  Fetch weights and config files but do not compile the
                   models.
```


## deepac_test

### Tool Description
Test the deepac tool

### Metadata
- **Docker Image**: quay.io/biocontainers/deepac:0.14.1--pyhdfd78af_0
- **Homepage**: https://gitlab.com/rki_bioinformatics/DeePaC
- **Package**: https://anaconda.org/channels/bioconda/packages/deepac/overview
- **Validation**: PASS

### Original Help Text
```text
usage: deepac test [-h] [-n N_CPUS] [-g GPUS [GPUS ...]] [-x] [-p] [-a] [-q]
                   [-k] [-s SCALE] [-L] [-o] [--input-modes [INPUT_MODES ...]]
                   [--no-check]

optional arguments:
  -h, --help            show this help message and exit
  -n N_CPUS, --n-cpus N_CPUS
                        Number of CPU cores. Default: all.
  -g GPUS [GPUS ...], --gpus GPUS [GPUS ...]
                        GPU devices to use. Default: all
  -x, --explain         Test explain workflows.
  -p, --gwpa            Test gwpa workflows.
  -a, --all             Test all functions.
  -q, --quick           Don't test heavy models (e.g. on low-memory machines
                        or when no GPU available).
  -k, --keep            Don't delete previous test output.
  -s SCALE, --scale SCALE
                        Generate s*1024 reads for testing (Default: s=1).
  -L, --large           Test a larger, more complex custom model.
  -o, --offline         Perform offline tests (don't fetch the pretrained
                        models).
  --input-modes [INPUT_MODES ...]
                        Input modes to test: memory, sequence and/or tfdata.
                        Default: all.
  --no-check            Disable additivity check.
```


## deepac_explain

### Tool Description
DeePaC explain subcommands. See command --help for details.

### Metadata
- **Docker Image**: quay.io/biocontainers/deepac:0.14.1--pyhdfd78af_0
- **Homepage**: https://gitlab.com/rki_bioinformatics/DeePaC
- **Package**: https://anaconda.org/channels/bioconda/packages/deepac/overview
- **Validation**: PASS

### Original Help Text
```text
usage: deepac explain [-h]
                      {maxact,fcontribs,franking,fa2transfac,weblogos,xlogos,transfac2IC,mcompare}
                      ...

positional arguments:
  {maxact,fcontribs,franking,fa2transfac,weblogos,xlogos,transfac2IC,mcompare}
                        DeePaC explain subcommands. See command --help for
                        details.
    maxact              Get DeepBind-like max-activation scores.
    fcontribs           Get DeepLIFT/SHAP filter contribution scores.
    franking            Generate filter rankings.
    fa2transfac         Calculate transfac from fasta files.
    weblogos            Get sequence logos.
    xlogos              Get extended sequence logos.
    transfac2IC         Calculate information content from transfac files.
    mcompare            Compare motifs.

optional arguments:
  -h, --help            show this help message and exit
```


## deepac_gwpa

### Tool Description
DeePaC gwpa subcommands. See command --help for details.

### Metadata
- **Docker Image**: quay.io/biocontainers/deepac:0.14.1--pyhdfd78af_0
- **Homepage**: https://gitlab.com/rki_bioinformatics/DeePaC
- **Package**: https://anaconda.org/channels/bioconda/packages/deepac/overview
- **Validation**: PASS

### Original Help Text
```text
usage: deepac gwpa [-h]
                   {fragment,genomemap,granking,ntcontribs,factiv,fenrichment,gff2genome}
                   ...

positional arguments:
  {fragment,genomemap,granking,ntcontribs,factiv,fenrichment,gff2genome}
                        DeePaC gwpa subcommands. See command --help for
                        details.
    fragment            Fragment genomes for analysis.
    genomemap           Generate a genome-wide phenotype potential map.
    granking            Generate gene rankings.
    ntcontribs          Generate a genome-wide nt contribution map.
    factiv              Get filter activations.
    fenrichment         Run filter enrichment analysis.
    gff2genome          Generate .genome files.

optional arguments:
  -h, --help            show this help message and exit
```


## deepac_templates

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/deepac:0.14.1--pyhdfd78af_0
- **Homepage**: https://gitlab.com/rki_bioinformatics/DeePaC
- **Package**: https://anaconda.org/channels/bioconda/packages/deepac/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
IPython could not be loaded!
usage: deepac templates [-h]
deepac templates: error: argument -h/--help: ignored explicit argument 'elp'
```


## Metadata
- **Skill**: generated
