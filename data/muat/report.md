# muat CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| muat_download | Failed | image problem: every muat run unpacks the packaged checkpoint zips into the root-owned site-packages folder at start, so it fails with a read-only/permission error; it only works as root with --no-match-user --no-read-only |
| muat_predict-ensemble_muat-wes | Failed | image problem: every muat run unpacks the packaged checkpoint zips into the root-owned site-packages folder at start, so it fails with a read-only/permission error; it only works as root with --no-match-user --no-read-only |
| muat_predict-ensemble_muat-wgs | Failed | image problem: every muat run unpacks the packaged checkpoint zips into the root-owned site-packages folder at start, so it fails with a read-only/permission error; it only works as root with --no-match-user --no-read-only |
| muat_predict_wes | Failed | image problem: every muat run unpacks the packaged checkpoint zips into the root-owned site-packages folder at start, so it fails with a read-only/permission error; it only works as root with --no-match-user --no-read-only |
| muat_predict_wgs | Failed | image problem: every muat run unpacks the packaged checkpoint zips into the root-owned site-packages folder at start, so it fails with a read-only/permission error; it only works as root with --no-match-user --no-read-only |
| muat_preprocess | Failed | image problem: every muat run unpacks the packaged checkpoint zips into the root-owned site-packages folder at start, so it fails with a read-only/permission error; it only works as root with --no-match-user --no-read-only |
| muat_train_from-checkpoint | Failed | image problem: every muat run unpacks the packaged checkpoint zips into the root-owned site-packages folder at start, so it fails with a read-only/permission error; it only works as root with --no-match-user --no-read-only |
| muat_train_from-scratch | Failed | image problem: every muat run unpacks the packaged checkpoint zips into the root-owned site-packages folder at start, so it fails with a read-only/permission error; it only works as root with --no-match-user --no-read-only |

## muat_download

### Tool Description
Download datasets.

### Metadata
- **Docker Image**: quay.io/biocontainers/muat:0.1.12--pyh7e72e81_0
- **Homepage**: https://github.com/primasanjaya/muat
- **Package**: https://anaconda.org/channels/bioconda/packages/muat/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/muat/overview
- **Total Downloads**: 5.2K
- **Last updated**: 2025-05-09
- **GitHub**: https://github.com/primasanjaya/muat
- **Stars**: N/A
### Original Help Text
```text
usage: muat download [-h] --pcawg --download-dir DOWNLOAD_DIR

options:
  -h, --help            show this help message and exit
  --pcawg               Download the PCAWG dataset.
  --download-dir DOWNLOAD_DIR
                        Directory for storing the downloaded dataset.
```


## muat_preprocess

### Tool Description
Preprocess VCF, SomAgg VCF, or TSV files with specified genome build and optional dictionaries.

### Metadata
- **Docker Image**: quay.io/biocontainers/muat:0.1.12--pyh7e72e81_0
- **Homepage**: https://github.com/primasanjaya/muat
- **Package**: https://anaconda.org/channels/bioconda/packages/muat/overview
- **Validation**: PASS

### Original Help Text
```text
usage: muat preprocess [-h] (--vcf | --somagg | --tsv) (--hg19 HG19 |
                       --hg38 HG38)
                       --input-filepath INPUT_FILEPATH [INPUT_FILEPATH ...]
                       [--tmp-dir TMP_DIR]
                       [--motif-dictionary-filepath MOTIF_DICTIONARY_FILEPATH]
                       [--position-dictionary-filepath POSITION_DICTIONARY_FILEPATH]
                       [--ges-dictionary-filepath GES_DICTIONARY_FILEPATH]

options:
  -h, --help            show this help message and exit
  --vcf                 Preprocess VCF files.
  --somagg              Preprocess SomAgg VCF files.
  --tsv                 Preprocess TSV files.
  --hg19 HG19           Path to GRCh37/hg19 (.fa or .fa.gz)
  --hg38 HG38           Path to GRCh38/hg38 (.fa or .fa.gz)
  --input-filepath INPUT_FILEPATH [INPUT_FILEPATH ...]
                        Input file paths.
  --tmp-dir TMP_DIR     Directory for storing preprocessed files.
  --motif-dictionary-filepath MOTIF_DICTIONARY_FILEPATH
                        Path to the motif dictionary (.tsv).
  --position-dictionary-filepath POSITION_DICTIONARY_FILEPATH
                        Path to the genomic position dictionary (.tsv).
  --ges-dictionary-filepath GES_DICTIONARY_FILEPATH
                        Path to the genic exonic strand dictionary (.tsv).
```


## Metadata
- **Skill**: generated

## muat_predict_wgs

### Tool Description
Predict the tumour type of samples from somatic mutations (whole genome), using a single model.

### Metadata
- **Docker Image**: quay.io/biocontainers/muat:0.1.12--pyh7e72e81_0
- **Homepage**: https://github.com/primasanjaya/muat
- **Package**: https://anaconda.org/channels/bioconda/packages/muat/overview
- **Validation**: PASS

### Original Help Text
```text
usage: muat predict wgs [-h] (--hg19 HG19 | --hg38 HG38 | --no-preprocess)
                        (--mutation-type MUTATION_TYPE |
                        --ckpt-filepath CKPT_FILEPATH)
                        [--input-filepath INPUT_FILEPATH [INPUT_FILEPATH ...]]
                        --result-dir RESULT_DIR [--tmp-dir TMP_DIR]

options:
  -h, --help            show this help message and exit
  --hg19 HG19           Path to GRCh37/hg19 (.fa or .fa.gz)
  --hg38 HG38           Path to GRCh38/hg19 (.fa or .fa.gz)
  --no-preprocess       Predict directly from preprocessed data (.muat.tsv)
  --mutation-type MUTATION_TYPE
                        Mutation type; only {snv, snv+mnv, snv+mnv+indel,
                        snv+mnv+indel+svmei, snv+mnv+indel+svmei+neg} can be
                        applied.
  --ckpt-filepath CKPT_FILEPATH
                        Path to load the checkpoint (.pthx). The mutation type
                        will be adjusted accordingly when loading from the
                        checkpoint.
  --input-filepath INPUT_FILEPATH [INPUT_FILEPATH ...]
                        Input file paths (.vcf or .vcf.gz) / .muat.tsv for no
                        preprocess
  --result-dir RESULT_DIR
                        Result directory where the output will be written
                        (.tsv).
  --tmp-dir TMP_DIR     Directory for storing preprocessed files.
```

## muat_predict_wes

### Tool Description
Predict the tumour type of samples from somatic mutations (whole exome), using a single model.

### Metadata
- **Docker Image**: quay.io/biocontainers/muat:0.1.12--pyh7e72e81_0
- **Homepage**: https://github.com/primasanjaya/muat
- **Package**: https://anaconda.org/channels/bioconda/packages/muat/overview
- **Validation**: PASS

### Original Help Text
```text
usage: muat predict wes [-h] (--hg19 HG19 | --hg38 HG38 | --no-preprocess)
                        (--mutation-type MUTATION_TYPE |
                        --ckpt-filepath CKPT_FILEPATH)
                        [--input-filepath INPUT_FILEPATH [INPUT_FILEPATH ...]]
                        --result-dir RESULT_DIR [--tmp-dir TMP_DIR]

options:
  -h, --help            show this help message and exit
  --hg19 HG19           Path to GRCh37/hg19 (.fa or .fa.gz)
  --hg38 HG38           Path to GRCh37/hg19 (.fa or .fa.gz)
  --no-preprocess       Predict from preprocessed data (.muat.tsv)
  --mutation-type MUTATION_TYPE
                        Mutation type; only {snv, snv+mnv, snv+mnv+indel} can
                        be applied.
  --ckpt-filepath CKPT_FILEPATH
                        Absolut Path to load the checkpoint (.pthx). The
                        mutation type will be adjusted accordingly when
                        loading from the checkpoint.
  --input-filepath INPUT_FILEPATH [INPUT_FILEPATH ...]
                        Input file paths (.vcf or .vcf.gz) or .muat.tsv for no
                        preprocess
  --result-dir RESULT_DIR
                        Result directory where the output will be written
                        (.tsv).
  --tmp-dir TMP_DIR     Directory for storing preprocessed files.
```

## muat_predict-ensemble_muat-wgs

### Tool Description
Ensemble prediction (whole genome): averages logits across fold checkpoints.

### Metadata
- **Docker Image**: quay.io/biocontainers/muat:0.1.12--pyh7e72e81_0
- **Homepage**: https://github.com/primasanjaya/muat
- **Package**: https://anaconda.org/channels/bioconda/packages/muat/overview
- **Validation**: PASS

### Original Help Text
```text
usage: muat predict-ensemble muat-wgs [-h] (--hg19 HG19 | --hg38 HG38 |
                                      --no-preprocess)
                                      --mutation-type MUTATION_TYPE
                                      [--input-filepath INPUT_FILEPATH [INPUT_FILEPATH ...]]
                                      --result-dir RESULT_DIR
                                      [--tmp-dir TMP_DIR]

options:
  -h, --help            show this help message and exit
  --hg19 HG19           Path to GRCh37/hg19 (.fa or .fa.gz)
  --hg38 HG38           Path to GRCh38/hg19 (.fa or .fa.gz)
  --no-preprocess       Predict directly from preprocessed data (.muat.tsv)
  --mutation-type MUTATION_TYPE
                        Mutation type; only {snv, snv+mnv, snv+mnv+indel,
                        snv+mnv+indel+svmei, snv+mnv+indel+svmei+neg} can be
                        applied.
  --input-filepath INPUT_FILEPATH [INPUT_FILEPATH ...]
                        Input file paths (.vcf or .vcf.gz) / .muat.tsv for no
                        preprocess
  --result-dir RESULT_DIR
                        Result directory where the output will be written
                        (.tsv).
  --tmp-dir TMP_DIR     Directory for storing preprocessed files.
```

## muat_predict-ensemble_muat-wes

### Tool Description
Ensemble prediction (whole exome): averages logits across fold checkpoints.

### Metadata
- **Docker Image**: quay.io/biocontainers/muat:0.1.12--pyh7e72e81_0
- **Homepage**: https://github.com/primasanjaya/muat
- **Package**: https://anaconda.org/channels/bioconda/packages/muat/overview
- **Validation**: PASS

### Original Help Text
```text
usage: muat predict-ensemble muat-wes [-h] (--hg19 HG19 | --hg38 HG38 |
                                      --no-preprocess)
                                      --mutation-type MUTATION_TYPE
                                      [--input-filepath INPUT_FILEPATH [INPUT_FILEPATH ...]]
                                      --result-dir RESULT_DIR
                                      [--tmp-dir TMP_DIR]

options:
  -h, --help            show this help message and exit
  --hg19 HG19           Path to GRCh37/hg19 (.fa or .fa.gz)
  --hg38 HG38           Path to GRCh37/hg19 (.fa or .fa.gz)
  --no-preprocess       Predict directly from preprocessed data (.muat.tsv)
  --mutation-type MUTATION_TYPE
                        Mutation type; only {snv, snv+mnv, snv+mnv+indel} can
                        be applied.
  --input-filepath INPUT_FILEPATH [INPUT_FILEPATH ...]
                        Input file paths (.vcf or .vcf.gz) / .muat.tsv for no
                        preprocess
  --result-dir RESULT_DIR
                        Result directory where the output will be written
                        (.tsv).
  --tmp-dir TMP_DIR     Directory for storing preprocessed files.
```

## muat_train_from-scratch

### Tool Description
Train a MuAt model from scratch.

### Metadata
- **Docker Image**: quay.io/biocontainers/muat:0.1.12--pyh7e72e81_0
- **Homepage**: https://github.com/primasanjaya/muat
- **Package**: https://anaconda.org/channels/bioconda/packages/muat/overview
- **Validation**: PASS

### Original Help Text
```text
usage: muat train from-scratch [-h] --mutation-type MUTATION_TYPE --use-motif
                               [--use-position] [--use-ges]
                               --train-split-filepath TRAIN_SPLIT_FILEPATH
                               --val-split-filepath VAL_SPLIT_FILEPATH
                               --save-dir SAVE_DIR [--epoch EPOCH]
                               [--learning-rate LEARNING_RATE]
                               [--batch-size BATCH_SIZE] [--n-layer N_LAYER]
                               [--n-head N_HEAD] [--n-emb N_EMB]
                               [--mutation-sampling-size MUTATION_SAMPLING_SIZE]
                               [--sampling-replacement]
                               [--motif-dictionary-filepath MOTIF_DICTIONARY_FILEPATH]
                               [--position-dictionary-filepath POSITION_DICTIONARY_FILEPATH]
                               [--ges-dictionary-filepath GES_DICTIONARY_FILEPATH]

options:
  -h, --help            show this help message and exit
  --mutation-type MUTATION_TYPE
                        Mutation type; choose from {snv, snv+mnv,
                        snv+mnv+indel, snv+mnv+indel+svmei,
                        snv+mnv+indel+svmei+neg}.
  --use-motif           Use motif input.
  --use-position        Use genomic position input.
  --use-ges             Use genic, exonic, and strand annotation.
  --train-split-filepath TRAIN_SPLIT_FILEPATH
                        Training split data; example file in
                        example_files/train_split_example.tsv.
  --val-split-filepath VAL_SPLIT_FILEPATH
                        Internal validation split data; example file in
                        example_files/val_split_example.tsv.
  --save-dir SAVE_DIR   Directory to save the model.
  --epoch EPOCH         Number of epochs (default: 5).
  --learning-rate LEARNING_RATE
                        Learning rate (default: 6e-4).
  --batch-size BATCH_SIZE
                        Batch size (default: 2).
  --n-layer N_LAYER     Number of attention layers (default: 1).
  --n-head N_HEAD       Number of attention heads (default: 8).
  --n-emb N_EMB         Embedding dimension (default: 128).
  --mutation-sampling-size MUTATION_SAMPLING_SIZE
                        Maximum number of mutations to fetch for the model
                        (default: 5000).
  --sampling-replacement
                        Use sampling with replacement. Default is False
  --motif-dictionary-filepath MOTIF_DICTIONARY_FILEPATH
                        Path to the motif dictionary (.tsv).
  --position-dictionary-filepath POSITION_DICTIONARY_FILEPATH
                        Path to the genomic position dictionary (.tsv).
  --ges-dictionary-filepath GES_DICTIONARY_FILEPATH
                        Path to the genic exonic strand dictionary (.tsv).
```

## muat_train_from-checkpoint

### Tool Description
Train a MuAt model starting from a checkpoint.

### Metadata
- **Docker Image**: quay.io/biocontainers/muat:0.1.12--pyh7e72e81_0
- **Homepage**: https://github.com/primasanjaya/muat
- **Package**: https://anaconda.org/channels/bioconda/packages/muat/overview
- **Validation**: PASS

### Original Help Text
```text
usage: muat train from-checkpoint [-h] --ckpt-filepath CKPT_FILEPATH
                                  --mutation-type MUTATION_TYPE
                                  --train-split-filepath TRAIN_SPLIT_FILEPATH
                                  --val-split-filepath VAL_SPLIT_FILEPATH
                                  --save-dir SAVE_DIR --epoch EPOCH
                                  [--learning-rate LEARNING_RATE]
                                  [--batch-size BATCH_SIZE]
                                  [--mutation-sampling-size MUTATION_SAMPLING_SIZE]
                                  [--sampling-replacement]

options:
  -h, --help            show this help message and exit
  --ckpt-filepath CKPT_FILEPATH
                        Path to load the checkpoint (.pthx).
  --mutation-type MUTATION_TYPE
                        Mutation type; choose from {snv, snv+mnv,
                        snv+mnv+indel, snv+mnv+indel+svmei,
                        snv+mnv+indel+svmei+neg}.
  --train-split-filepath TRAIN_SPLIT_FILEPATH
                        Training split data; example file in
                        example_files/train_split_example.tsv.
  --val-split-filepath VAL_SPLIT_FILEPATH
                        Internal validation split data; example file in
                        example_files/val_split_example.tsv.
  --save-dir SAVE_DIR   Directory to save the model.
  --epoch EPOCH         Number of epochs (default: 5).
  --learning-rate LEARNING_RATE
                        Learning rate (default: 6e-4).
  --batch-size BATCH_SIZE
                        Batch size (default: 2).
  --mutation-sampling-size MUTATION_SAMPLING_SIZE
                        Maximum number of mutations to fetch for the model
                        (default: 5000).
  --sampling-replacement
                        Use sampling with replacement. Default is False
```
