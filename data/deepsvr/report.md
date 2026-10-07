# deepsvr CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| deepsvr_classify_data | Failed | image problem: the click CLI aborts at start because the image has no locale program or UTF-8 locale (FileNotFoundError: 'locale'); setting LC_ALL does not help. |
| deepsvr_prepare_data | Failed | image problem: the click CLI aborts at start because the image has no locale program or UTF-8 locale (FileNotFoundError: 'locale'); setting LC_ALL does not help. |
| deepsvr_train_classifier | Failed | image problem: the click CLI aborts at start because the image has no locale program or UTF-8 locale (FileNotFoundError: 'locale'); setting LC_ALL does not help. |

## deepsvr_prepare_data

### Tool Description
Prepare data for training or classification.

### Metadata
- **Docker Image**: quay.io/biocontainers/deepsvr:0.1.0--py_0
- **Homepage**: https://github.com/griffithlab/deepsvr
- **Package**: https://anaconda.org/channels/bioconda/packages/deepsvr/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/deepsvr/overview
- **Total Downloads**: 3.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/griffithlab/deepsvr
- **Stars**: N/A
### Original Help Text
```text
Usage: deepsvr prepare_data [OPTIONS]

  Prepare data for training or classification.

Options:
  -h, --help                      Show this message and exit.
  --header / --no-header          Specify whether header is present in sample
                                  file
  --skip_bam_readcount / --no-skip_bam_readcount
                                  If bam readcount files already exist in
                                  output directory as a result of a prior run
                                  of the prepare_data command, skip the
                                  bam-readcount step
  -sfp, --samples-file-path TEXT  File path of tsv file with sample
                                  information. File should have the following
                                  columns in order: sample_name,
                                  tumor_bam_path, normal_bam_path,
                                  manual_review_file_path, reviewer,
                                  solid_tumor,
                                  reference_genome_fasta_file_path.
  -odp, --output-dir-path TEXT    Specify output directory: Readcount files and
                                  compressed pandas dataframe will be output
                                  here (default:~/training_data)

(Rebuilt from deepsvr/cli.py in the image: `deepsvr --help` crashes because
the image has no `locale` program or UTF-8 locale.)
```

## deepsvr_classify_data

### Tool Description
Preform automated somatic variant refinement on mutations.

### Metadata
- **Docker Image**: quay.io/biocontainers/deepsvr:0.1.0--py_0
- **Homepage**: https://github.com/griffithlab/deepsvr
- **Package**: https://anaconda.org/channels/bioconda/packages/deepsvr/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/deepsvr/overview
- **Total Downloads**: 3.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/griffithlab/deepsvr
- **Stars**: N/A
### Original Help Text
```text
Usage: deepsvr classify_data [OPTIONS]

  Preform automated somatic variant refinement on mutations.

Options:
  -h, --help                      Show this message and exit.
  -pdp, --prepared-data-path TEXT
                                  Specify the 'train.pkl' file produced by the
                                  'prepare_data' to perform inference on.
                                  Ignore the call.pkl used in training
                                  classifiers
  -mfp, --model-file-path TEXT    Specify the file path for the model json
                                  file. Created by the train_classifier
                                  command.
  -mwp, --model-weights-path TEXT
                                  Specify the file path for the model weights
                                  file. Created by the train_classifier
                                  command.
  -pop, --predictions-out-path TEXT
                                  Specify the file path for the predictions
                                  tab separated file.

(Rebuilt from deepsvr/cli.py in the image: `deepsvr --help` crashes because
the image has no `locale` program or UTF-8 locale.)
```

## deepsvr_train_classifier

### Tool Description
Train a new classifier for somatic variant refinement.

### Metadata
- **Docker Image**: quay.io/biocontainers/deepsvr:0.1.0--py_0
- **Homepage**: https://github.com/griffithlab/deepsvr
- **Package**: https://anaconda.org/channels/bioconda/packages/deepsvr/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/deepsvr/overview
- **Total Downloads**: 3.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/griffithlab/deepsvr
- **Stars**: N/A
### Original Help Text
```text
Usage: deepsvr train_classifier [OPTIONS]

  Train a new classifier for somatic variant refinement.

Options:
  -h, --help                      Show this message and exit.
  -tfp, --training-file-path TEXT
                                  Specify the pickle file produced by the
                                  'prepare_data' command to be used to train a
                                  new classifier.
  -lfp, --label-file-path TEXT    Specify the label (manual review call)
                                  pickle file produced by the 'prepare_data'
                                  command to be used to train a new
                                  classifier.
  -mop, --model-out-file-path TEXT
                                  Specify output file path for model json
                                  file(default:./deepsvr_model.json)
  -wop, --weights-out-file-path TEXT
                                  Specify output file path for model weights
                                  file(default:data/deepsvr_model_weights.h5)

(Rebuilt from deepsvr/cli.py in the image: `deepsvr --help` crashes because
the image has no `locale` program or UTF-8 locale.)
```

## Metadata
- **Skill**: generated
