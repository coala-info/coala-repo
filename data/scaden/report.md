# scaden CWL Generation Report

## scaden_example

### Tool Description
Generate an example dataset

### Metadata
- **Docker Image**: quay.io/biocontainers/scaden:1.1.2--pyhdfd78af_0
- **Homepage**: https://github.com/KevinMenden/scaden
- **Package**: https://anaconda.org/channels/bioconda/packages/scaden/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/scaden/overview
- **Total Downloads**: 14.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/KevinMenden/scaden
- **Stars**: N/A
### Original Help Text
```text
____                _            
    / ___|  ___ __ _  __| | ___ _ __  
    \___ \ / __/ _` |/ _` |/ _ \ '_ \ 
     ___) | (_| (_| | (_| |  __/ | | |
    |____/ \___\__,_|\__,_|\___|_| |_|

    
Usage: scaden example [OPTIONS]

  Generate an example dataset

Options:
  -c, --cells INTEGER    Number of cells [default: 10]
  -t, --types INTEGER    Number of cell types [default: 5]
  -g, --genes INTEGER    Number of genes [default: 100]
  -o, --out TEXT         Output directory [default: ./]
  -n, --samples INTEGER  Number of bulk samples [default: 10]
  --help                 Show this message and exit.
```


## scaden_merge

### Tool Description
Merge simulated datasets into on training dataset

### Metadata
- **Docker Image**: quay.io/biocontainers/scaden:1.1.2--pyhdfd78af_0
- **Homepage**: https://github.com/KevinMenden/scaden
- **Package**: https://anaconda.org/channels/bioconda/packages/scaden/overview
- **Validation**: PASS

### Original Help Text
```text
____                _            
    / ___|  ___ __ _  __| | ___ _ __  
    \___ \ / __/ _` |/ _` |/ _ \ '_ \ 
     ___) | (_| (_| | (_| |  __/ | | |
    |____/ \___\__,_|\__,_|\___|_| |_|

    
Usage: scaden merge [OPTIONS]

  Merge simulated datasets into on training dataset

Options:
  -d, --data TEXT    Directory containing simulated datasets (in .h5ad format)
  -p, --prefix TEXT  Prefix of output file [default: data]
  -f, --files TEXT   Comma-separated list of filenames to merge
  --help             Show this message and exit.
```


## scaden_predict

### Tool Description
Predict cell type composition using a trained Scaden model

### Metadata
- **Docker Image**: quay.io/biocontainers/scaden:1.1.2--pyhdfd78af_0
- **Homepage**: https://github.com/KevinMenden/scaden
- **Package**: https://anaconda.org/channels/bioconda/packages/scaden/overview
- **Validation**: PASS

### Original Help Text
```text
____                _            
    / ___|  ___ __ _  __| | ___ _ __  
    \___ \ / __/ _` |/ _` |/ _ \ '_ \ 
     ___) | (_| (_| | (_| |  __/ | | |
    |____/ \___\__,_|\__,_|\___|_| |_|

    
Usage: scaden predict [OPTIONS] <prediction data>

  Predict cell type composition using a trained Scaden model

Options:
  --model_dir TEXT  Path to trained model
  --outname TEXT    Name of predictions file.
  --seed INTEGER    Set random seed
  --help            Show this message and exit.
```


## scaden_process

### Tool Description
Process a dataset for training

### Metadata
- **Docker Image**: quay.io/biocontainers/scaden:1.1.2--pyhdfd78af_0
- **Homepage**: https://github.com/KevinMenden/scaden
- **Package**: https://anaconda.org/channels/bioconda/packages/scaden/overview
- **Validation**: PASS

### Original Help Text
```text
____                _            
    / ___|  ___ __ _  __| | ___ _ __  
    \___ \ / __/ _` |/ _` |/ _ \ '_ \ 
     ___) | (_| (_| | (_| |  __/ | | |
    |____/ \___\__,_|\__,_|\___|_| |_|

    
Usage: scaden process [OPTIONS] <training dataset to be processed> <data for
                      prediction>

  Process a dataset for training

Options:
  --processed_path TEXT  Path of processed file. Must end with .h5ad
  --var_cutoff FLOAT     Filter out genes with a variance less than the
                         specified cutoff. A low cutoff is recommended,this
                         should only remove genes that are obviously
                         uninformative.
  --help                 Show this message and exit.
```


## scaden_simulate

### Tool Description
Create artificial bulk RNA-seq data from scRNA-seq dataset(s)

### Metadata
- **Docker Image**: quay.io/biocontainers/scaden:1.1.2--pyhdfd78af_0
- **Homepage**: https://github.com/KevinMenden/scaden
- **Package**: https://anaconda.org/channels/bioconda/packages/scaden/overview
- **Validation**: PASS

### Original Help Text
```text
____                _            
    / ___|  ___ __ _  __| | ___ _ __  
    \___ \ / __/ _` |/ _` |/ _ \ '_ \ 
     ___) | (_| (_| | (_| |  __/ | | |
    |____/ \___\__,_|\__,_|\___|_| |_|

    
Usage: scaden simulate [OPTIONS]

  Create artificial bulk RNA-seq data from scRNA-seq dataset(s)

Options:
  -o, --out TEXT           Directory to store output files in
  -d, --data TEXT          Path to scRNA-seq dataset(s)
  -c, --cells INTEGER      Number of cells per sample [default: 100]
  -n, --n_samples INTEGER  Number of samples to simulate [default: 1000]
  --pattern TEXT           File pattern to recognize your processed scRNA-seq
                           count files
  -u, --unknown TEXT       Specifiy cell types to merge into the unknown
                           category. Specify this flag for every cell type you
                           want to merge in unknown. [default: unknown]
  -p, --prefix TEXT        Prefix to append to training .h5ad file [default:
                           data]
  -f, --data-format TEXT   Data format of scRNA-seq data, can be 'txt' or
                           'h5ad' [default: 'txt']
  --help                   Show this message and exit.
```


## scaden_train

### Tool Description
Train a Scaden model

### Metadata
- **Docker Image**: quay.io/biocontainers/scaden:1.1.2--pyhdfd78af_0
- **Homepage**: https://github.com/KevinMenden/scaden
- **Package**: https://anaconda.org/channels/bioconda/packages/scaden/overview
- **Validation**: PASS

### Original Help Text
```text
____                _            
    / ___|  ___ __ _  __| | ___ _ __  
    \___ \ / __/ _` |/ _` |/ _ \ '_ \ 
     ___) | (_| (_| | (_| |  __/ | | |
    |____/ \___\__,_|\__,_|\___|_| |_|

    
Usage: scaden train [OPTIONS] <training data>

  Train a Scaden model

Options:
  --train_datasets TEXT  Comma-separated list of datasets used for training.
                         Uses all by default.
  --model_dir TEXT       Path to store the model in
  --batch_size INTEGER   Batch size to use for training. Default: 128
  --learning_rate FLOAT  Learning rate used for training. Default: 0.0001
  --steps INTEGER        Number of training steps
  --seed INTEGER         Set random seed
  --help                 Show this message and exit.
```


## Metadata
- **Skill**: generated
