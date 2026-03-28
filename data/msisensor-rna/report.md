# msisensor-rna CWL Generation Report

## msisensor-rna_genes

### Tool Description
Select informative genes for microsatellite instability detection.

### Metadata
- **Docker Image**: quay.io/biocontainers/msisensor-rna:0.1.6--pyhdfd78af_0
- **Homepage**: https://github.com/xjtu-omics/msisensor-rna
- **Package**: https://anaconda.org/channels/bioconda/packages/msisensor-rna/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/msisensor-rna/overview
- **Total Downloads**: 1.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/xjtu-omics/msisensor-rna
- **Stars**: N/A
### Original Help Text
```text
usage: msisensor-rna <command> [options] genes [-h] -i INPUT -o OUTPUT
                                               [-thresh_t THREADS]
                                               [-thresh_cov THRESH_COV]
                                               [-thresh_p THRESH_P_RANKSUM]
                                               [-thresh_auc THRESH_AUCSCORE]
                                               [-p POSITIVE_NUM]

Select informative genes for microsatellite instability detection.

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        The path of input file. e.g. xxx.csv [required]
  -o OUTPUT, --output OUTPUT
                        The output file of gene information. e.g. xxx.csv
                        [required]
  -thresh_t THREADS, --threads THREADS
                        The threads used to run this program. [default=4]
  -thresh_cov THRESH_COV, --thresh_cov THRESH_COV
                        Threshold for coefficient of variation of gene
                        expression value of all samples (Mean/Std).
                        [default=0.5]
  -thresh_p THRESH_P_RANKSUM, --thresh_p_ranksum THRESH_P_RANKSUM
                        Threshold for Pvalue of rank sum test between MSI-H
                        and MSS samples. [default=0.01]
  -thresh_auc THRESH_AUCSCORE, --thresh_AUCscore THRESH_AUCSCORE
                        Threshold for AUC score: AUC score was calculating by
                        the sklearn package. [default=0.65]
  -p POSITIVE_NUM, --positive_num POSITIVE_NUM
                        The minimum positive sample of MSI for training.
                        [default = 10]
```


## msisensor-rna_train

### Tool Description
Train custom model for microsatellite instability detection.

### Metadata
- **Docker Image**: quay.io/biocontainers/msisensor-rna:0.1.6--pyhdfd78af_0
- **Homepage**: https://github.com/xjtu-omics/msisensor-rna
- **Package**: https://anaconda.org/channels/bioconda/packages/msisensor-rna/overview
- **Validation**: PASS

### Original Help Text
```text
usage: msisensor-rna <command> [options] train [-h] -i INPUT -m MODEL -t
                                               CANCER_TYPE
                                               [-c {SVM,RandomForest,LogisticRegression,MLPClassifier,GaussianNB,AdaBoostClassifier}]
                                               [-di INPUT_DESCRIPTION]
                                               [-dm MODEL_DESCRIPTION]
                                               [-p POSITIVE_NUM] [-a AUTHOR]
                                               [-e EMAIL]

Train custom model for microsatellite instability detection.

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        The path of input file. [required]
  -m MODEL, --model MODEL
                        The trained model of the input file. [required]
  -t CANCER_TYPE, --cancer_type CANCER_TYPE
                        The cancer type for this training. e.g. CRC, STAD,
                        PanCancer etc.
  -c {SVM,RandomForest,LogisticRegression,MLPClassifier,GaussianNB,AdaBoostClassifier}, --classifier {SVM,RandomForest,LogisticRegression,MLPClassifier,GaussianNB,AdaBoostClassifier}
                        The machine learning classifier for MSI detection.
                        [default = SVM]
  -di INPUT_DESCRIPTION, --input_description INPUT_DESCRIPTION
                        The description of the input file. [default = None]
  -dm MODEL_DESCRIPTION, --model_description MODEL_DESCRIPTION
                        Description for this trained model.
  -p POSITIVE_NUM, --positive_num POSITIVE_NUM
                        The minimum positive sample of MSI for training.
                        [default = 10]
  -a AUTHOR, --author AUTHOR
                        The author who trained the model. [default = None]
  -e EMAIL, --email EMAIL
                        The email of the author. [default = None]
```


## msisensor-rna_show

### Tool Description
Show the information of the model and add more details.

### Metadata
- **Docker Image**: quay.io/biocontainers/msisensor-rna:0.1.6--pyhdfd78af_0
- **Homepage**: https://github.com/xjtu-omics/msisensor-rna
- **Package**: https://anaconda.org/channels/bioconda/packages/msisensor-rna/overview
- **Validation**: PASS

### Original Help Text
```text
usage: msisensor-rna <command> [options] show [-h] -m MODEL [-t CANCER_TYPE]
                                              [-di INPUT_DESCRIPTION]
                                              [-dm MODEL_DESCRIPTION]
                                              [-g GENE_LIST]

Show the information of the model and add more details.

options:
  -h, --help            show this help message and exit
  -m MODEL, --model MODEL
                        The trained model path. [required]
  -t CANCER_TYPE, --cancer_type CANCER_TYPE
                        Rename the cancer type. e.g. CRC, STAD, PanCancer etc.
                        [default = None]
  -di INPUT_DESCRIPTION, --input_description INPUT_DESCRIPTION
                        Add description for the input file. [default = None]
  -dm MODEL_DESCRIPTION, --model_description MODEL_DESCRIPTION
                        Add description for this trained model. [default =
                        None]
  -g GENE_LIST, --gene_list GENE_LIST
                        The path for the genes must be included for this
                        model. [default = None]
```


## msisensor-rna_detection

### Tool Description
Microsatellite instability detection.

### Metadata
- **Docker Image**: quay.io/biocontainers/msisensor-rna:0.1.6--pyhdfd78af_0
- **Homepage**: https://github.com/xjtu-omics/msisensor-rna
- **Package**: https://anaconda.org/channels/bioconda/packages/msisensor-rna/overview
- **Validation**: PASS

### Original Help Text
```text
usage: msisensor-rna <command> [options] detection [-h] -i INPUT -o OUTPUT -m
                                                   MODEL [-d RUN_DIRECTLY]

Microsatellite instability detection.

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        The path of input file. [required]
  -o OUTPUT, --output OUTPUT
                        The path of output file prefix. [required]
  -m MODEL, --model MODEL
                        The path of the microsatellite regions. [required]
  -d RUN_DIRECTLY, --run_directly RUN_DIRECTLY
                        Run the program directly without any Confirm. [default
                        = False]
```


## Metadata
- **Skill**: generated
