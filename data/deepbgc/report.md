# deepbgc CWL Generation Report

## deepbgc_download

### Tool Description
Download trained models and other file dependencies to the DeepBGC downloads directory.

### Metadata
- **Docker Image**: quay.io/biocontainers/deepbgc:0.1.31--pyhca03a8a_0
- **Homepage**: https://github.com/Merck/DeepBGC
- **Package**: https://anaconda.org/channels/bioconda/packages/deepbgc/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/deepbgc/overview
- **Total Downloads**: 71.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Merck/DeepBGC
- **Stars**: N/A
### Original Help Text
```text
usage: deepbgc download [-h] [--debug]

    Download trained models and other file dependencies to the DeepBGC downloads directory.
    
    By default, files are downloaded to: '/root/.local/share/deepbgc/data'
    Set DEEPBGC_DOWNLOADS_DIR env variable to specify a different downloads directory."
    

optional arguments:
  -h, --help  show this help message and exit
  --debug
```


## deepbgc_prepare

### Tool Description
Prepare genomic sequence by annotating proteins and Pfam domains.

### Metadata
- **Docker Image**: quay.io/biocontainers/deepbgc:0.1.31--pyhca03a8a_0
- **Homepage**: https://github.com/Merck/DeepBGC
- **Package**: https://anaconda.org/channels/bioconda/packages/deepbgc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: deepbgc prepare [-h] [--debug] [--limit-to-record LIMIT_TO_RECORD]
                       [--prodigal-meta-mode] [--protein]
                       [--output-gbk OUTPUT_GBK] [--output-tsv OUTPUT_TSV]
                       inputs [inputs ...]

Prepare genomic sequence by annotating proteins and Pfam domains.
    
Examples:
    
  # Show detailed help 
  deepbgc prepare --help 
    
  # Detect proteins and pfam domains in a FASTA sequence and save the result as GenBank file 
  deepbgc prepare --output sequence.prepared.gbk sequence.fa
  

positional arguments:
  inputs                Input sequence file path(s) (FASTA/GenBank)

optional arguments:
  -h, --help            show this help message and exit
  --debug
  --limit-to-record LIMIT_TO_RECORD
                        Process only specific record ID. Can be provided multiple times

required arguments:

  --prodigal-meta-mode  Run Prodigal in '-p meta' mode to enable detecting genes in short contigs
  --protein             Accept amino-acid protein sequences as input (experimental). Will treat each file as a single record with multiple proteins.
  --output-gbk OUTPUT_GBK
                        Output GenBank file path
  --output-tsv OUTPUT_TSV
                        Output TSV file path
```


## deepbgc_pipeline

### Tool Description
Run DeepBGC pipeline: Preparation, BGC detection, BGC classification and generate the report directory.

### Metadata
- **Docker Image**: quay.io/biocontainers/deepbgc:0.1.31--pyhca03a8a_0
- **Homepage**: https://github.com/Merck/DeepBGC
- **Package**: https://anaconda.org/channels/bioconda/packages/deepbgc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: deepbgc pipeline [-h] [--debug] [-o OUTPUT]
                        [--limit-to-record LIMIT_TO_RECORD] [--minimal-output]
                        [--prodigal-meta-mode] [--protein] [-d DETECTORS]
                        [--no-detector] [-l LABELS] [-s SCORE]
                        [--merge-max-protein-gap MERGE_MAX_PROTEIN_GAP]
                        [--merge-max-nucl-gap MERGE_MAX_NUCL_GAP]
                        [--min-nucl MIN_NUCL] [--min-proteins MIN_PROTEINS]
                        [--min-domains MIN_DOMAINS]
                        [--min-bio-domains MIN_BIO_DOMAINS] [-c CLASSIFIERS]
                        [--no-classifier]
                        [--classifier-score CLASSIFIER_SCORE]
                        inputs [inputs ...]

Run DeepBGC pipeline: Preparation, BGC detection, BGC classification and generate the report directory.
    
Examples:
    
  # Show detailed help 
  deepbgc pipeline --help 
    
  # Detect BGCs in a nucleotide FASTA sequence using DeepBGC model 
  deepbgc pipeline sequence.fa
  
  # Detect BGCs using the ClusterFinder GeneBorder detection model and a higher score threshold
  deepbgc pipeline --detector clusterfinder_geneborder --score 0.8 sequence.fa
  
  # Add additional clusters detected using DeepBGC model with a strict score threshold
  deepbgc pipeline --continue --output sequence/ --label deepbgc_90_score --score 0.9 sequence/sequence.full.gbk
  

positional arguments:
  inputs                Input sequence file path (FASTA, GenBank, Pfam CSV)

optional arguments:
  -h, --help            show this help message and exit
  --debug
  -o OUTPUT, --output OUTPUT
                        Custom output directory path
  --limit-to-record LIMIT_TO_RECORD
                        Process only specific record ID. Can be provided multiple times
  --minimal-output      Produce minimal output with just the GenBank sequence file
  --prodigal-meta-mode  Run Prodigal in '-p meta' mode to enable detecting genes in short contigs
  --protein             Accept amino-acid protein sequences as input (experimental). Will treat each file as a single record with multiple proteins.

BGC detection options:

  -d DETECTORS, --detector DETECTORS
                        Trained detection model name (run "deepbgc download" to download models) or path to trained model pickle file. Can be provided multiple times (-d first -d second)
  --no-detector         Disable BGC detection
  -l LABELS, --label LABELS
                        Label for detected clusters (equal to --detector by default). If multiple detectors are provided, a label should be provided for each one
  -s SCORE, --score SCORE
                        Average protein-wise DeepBGC score threshold for extracting BGC regions from Pfam sequences (default: 0.5)
  --merge-max-protein-gap MERGE_MAX_PROTEIN_GAP
                        Merge detected BGCs within given number of proteins (default: 0)
  --merge-max-nucl-gap MERGE_MAX_NUCL_GAP
                        Merge detected BGCs within given number of nucleotides (default: 0)
  --min-nucl MIN_NUCL   Minimum BGC nucleotide length (default: 1)
  --min-proteins MIN_PROTEINS
                        Minimum number of proteins in a BGC (default: 1)
  --min-domains MIN_DOMAINS
                        Minimum number of protein domains in a BGC (default: 1)
  --min-bio-domains MIN_BIO_DOMAINS
                        Minimum number of known biosynthetic (as defined by antiSMASH) protein domains in a BGC (default: 0)

BGC classification options:

  -c CLASSIFIERS, --classifier CLASSIFIERS
                        Trained classification model name (run "deepbgc download" to download models) or path to trained model pickle file. Can be provided multiple times (-c first -c second)
  --no-classifier       Disable BGC classification
  --classifier-score CLASSIFIER_SCORE
                        DeepBGC classification score threshold for assigning classes to BGCs (default: 0.5)
```


## deepbgc_train

### Tool Description
Train a BGC detector/classifier on a set of BGC samples.

### Metadata
- **Docker Image**: quay.io/biocontainers/deepbgc:0.1.31--pyhca03a8a_0
- **Homepage**: https://github.com/Merck/DeepBGC
- **Package**: https://anaconda.org/channels/bioconda/packages/deepbgc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: deepbgc train [-h] [--debug] -m MODEL [-t TARGET] -o OUTPUT [-l LOG]
                     [-c CLASSES] [--config CONFIG CONFIG] [-v VALIDATION]
                     [--verbose INT]
                     inputs [inputs ...]

Train a BGC detector/classifier on a set of BGC samples.
    
Examples:
    
  # Train a detector using pre-processed samples in Pfam CSV format. 
  deepbgc train --model deepbgc.json --output MyDeepBGCDetector.pkl BGCs.pfam.tsv negatives.pfam.tsv
    
  # Train a BGC classifier using a TSV classes file and a set of BGC samples in Pfam TSV format and save the trained classifier to a file. 
  deepbgc train --model random_forest.json --output MyDeepBGCClassifier.pkl --classes path/to/BGCs.classes.csv BGCs.pfam.tsv
  

positional arguments:
  inputs                Training sequences (Pfam TSV) file paths

optional arguments:
  -h, --help            show this help message and exit
  --debug
  -m MODEL, --model MODEL
                        Path to JSON model config file
  -t TARGET, --target TARGET
                        Target column to predict in sequence prediction
  -o OUTPUT, --output OUTPUT
                        Output trained model file path
  -l LOG, --log LOG     Progress log output path (e.g. TensorBoard)
  -c CLASSES, --classes CLASSES
                        Class TSV file path - train a sequence classifier using provided classes (binary columns), indexed by sequence_id column
  --config CONFIG CONFIG
                        Variables in model JSON file to replace (e.g. --config PFAM2VEC path/to/pfam2vec.csv)
  -v VALIDATION, --validation VALIDATION
                        Validation sequence file path. Repeat to specify multiple files
  --verbose INT         Verbosity level: 0=none, 1=progress bar, 2=once per epoch (default: 2)
```


## deepbgc_info

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/deepbgc:0.1.31--pyhca03a8a_0
- **Homepage**: https://github.com/Merck/DeepBGC
- **Package**: https://anaconda.org/channels/bioconda/packages/deepbgc/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
_____                  ____    ____   ____ 
 |  _ \  ___  ___ ____ | __ )  / ___) / ___)
 | | \ \/ _ \/ _ \  _ \|  _ \ | |  _ | |    
 | |_/ /  __/  __/ |_) | |_) || |_| || |___ 
 |____/ \___|\___| ___/|____/  \____| \____)
=================|_|===== version 0.1.31 =====
WARNING 25/02 07:33:18   Data downloads directory does not exist yet: /root/.local/share/deepbgc/data/common
WARNING 25/02 07:33:18   Run "deepbgc download" to download all dependencies or set DEEPBGC_DOWNLOADS_DIR env var
INFO    25/02 07:33:18   Downloads directory for current version does not exist yet: /root/.local/share/deepbgc/data/0.1.0
INFO    25/02 07:33:18   Run "deepbgc download" to download current models
```


## Metadata
- **Skill**: generated
