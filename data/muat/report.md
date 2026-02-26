# muat CWL Generation Report

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


## muat_predict

### Tool Description
Predicts variants from sequencing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/muat:0.1.12--pyh7e72e81_0
- **Homepage**: https://github.com/primasanjaya/muat
- **Package**: https://anaconda.org/channels/bioconda/packages/muat/overview
- **Validation**: PASS

### Original Help Text
```text
usage: muat predict [-h] {wgs,wes} ...

positional arguments:
  {wgs,wes}   Available commands.
    wgs       Whole Genome Sequence.
    wes       Whole Exome Sequence.

options:
  -h, --help  show this help message and exit
```


## muat_train

### Tool Description
Train a model

### Metadata
- **Docker Image**: quay.io/biocontainers/muat:0.1.12--pyh7e72e81_0
- **Homepage**: https://github.com/primasanjaya/muat
- **Package**: https://anaconda.org/channels/bioconda/packages/muat/overview
- **Validation**: PASS

### Original Help Text
```text
usage: muat train [-h] {from-scratch,from-checkpoint} ...

positional arguments:
  {from-scratch,from-checkpoint}
                        Available commands.
    from-scratch        Train from scratch.
    from-checkpoint     Train from a checkpoint.

options:
  -h, --help            show this help message and exit
```


## muat_predict-ensemble

### Tool Description
Predicts variants using an ensemble of models.

### Metadata
- **Docker Image**: quay.io/biocontainers/muat:0.1.12--pyh7e72e81_0
- **Homepage**: https://github.com/primasanjaya/muat
- **Package**: https://anaconda.org/channels/bioconda/packages/muat/overview
- **Validation**: PASS

### Original Help Text
```text
usage: muat predict-ensemble [-h] {muat-wgs,muat-wes} ...

positional arguments:
  {muat-wgs,muat-wes}  Available commands.
    muat-wgs           MuAt Whole Genome Sequence.
    muat-wes           MuAt Whole Exome Sequence.

options:
  -h, --help           show this help message and exit
```

