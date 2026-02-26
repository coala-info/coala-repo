# scvis CWL Generation Report

## scvis_train

### Tool Description
Train a scVIS model.

### Metadata
- **Docker Image**: quay.io/biocontainers/scvis:0.1.0--scvis_0
- **Homepage**: https://bitbucket.org/jerry00/scvis-dev/commits/all
- **Package**: https://anaconda.org/channels/bioconda/packages/scvis/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/scvis/overview
- **Total Downloads**: 2.3K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
WARNING: The TensorFlow contrib module will not be included in TensorFlow 2.0.
For more information, please see:
  * https://github.com/tensorflow/community/blob/master/rfcs/20180907-contrib-sunset.md
  * https://github.com/tensorflow/addons
If you depend on functionality not listed there, please file an issue.

usage: scvis train [-h] --data_matrix_file DATA_MATRIX_FILE
                   [--config_file CONFIG_FILE] [--out_dir OUT_DIR]
                   [--data_label_file DATA_LABEL_FILE]
                   [--pretrained_model_file PRETRAINED_MODEL_FILE]
                   [--normalize NORMALIZE] [--verbose]
                   [--verbose_interval VERBOSE_INTERVAL] [--show_plot]

optional arguments:
  -h, --help            show this help message and exit
  --data_matrix_file DATA_MATRIX_FILE
                        The high-dimensional data matrix
  --config_file CONFIG_FILE
                        Path to a yaml format configuration file
  --out_dir OUT_DIR     Path for output files
  --data_label_file DATA_LABEL_FILE
                        Just used for colouring scatter plots
  --pretrained_model_file PRETRAINED_MODEL_FILE
                        A pretrained scvis model, continue to train this model
  --normalize NORMALIZE
                        The data will be divided by this number if provided
                        (default: the maximum value).
  --verbose             Print running information
  --verbose_interval VERBOSE_INTERVAL
                        Print running information after running # of mini-
                        batches
  --show_plot           Plot intermediate embedding when this parameter is set
```


## scvis_map

### Tool Description
Map new data to a pretrained scvis model.

### Metadata
- **Docker Image**: quay.io/biocontainers/scvis:0.1.0--scvis_0
- **Homepage**: https://bitbucket.org/jerry00/scvis-dev/commits/all
- **Package**: https://anaconda.org/channels/bioconda/packages/scvis/overview
- **Validation**: PASS

### Original Help Text
```text
WARNING: The TensorFlow contrib module will not be included in TensorFlow 2.0.
For more information, please see:
  * https://github.com/tensorflow/community/blob/master/rfcs/20180907-contrib-sunset.md
  * https://github.com/tensorflow/addons
If you depend on functionality not listed there, please file an issue.

usage: scvis map [-h] --data_matrix_file DATA_MATRIX_FILE
                 [--config_file CONFIG_FILE] [--out_dir OUT_DIR]
                 [--data_label_file DATA_LABEL_FILE] --pretrained_model_file
                 PRETRAINED_MODEL_FILE [--normalize NORMALIZE]

optional arguments:
  -h, --help            show this help message and exit
  --data_matrix_file DATA_MATRIX_FILE
                        The high-dimensional data matrix
  --config_file CONFIG_FILE
                        Path to a yaml format configuration file
  --out_dir OUT_DIR     Path for output files
  --data_label_file DATA_LABEL_FILE
                        Just used for colouring scatter plots
  --pretrained_model_file PRETRAINED_MODEL_FILE
                        A pretrained scvis model used to map new data
  --normalize NORMALIZE
                        Data will be divided by this number if provided
                        (default: from the trained model)
```


## Metadata
- **Skill**: generated

## scvis

### Tool Description
Learning a parametric mapping for high-dimensional single cell data or mapping high-dimensional single cell data to a low-dimensional space given a pretrained mapping

### Metadata
- **Docker Image**: quay.io/biocontainers/scvis:0.1.0--scvis_0
- **Homepage**: https://bitbucket.org/jerry00/scvis-dev/commits/all
- **Package**: https://anaconda.org/channels/bioconda/packages/scvis/overview
- **Validation**: PASS
### Original Help Text
```text
WARNING: The TensorFlow contrib module will not be included in TensorFlow 2.0.
For more information, please see:
  * https://github.com/tensorflow/community/blob/master/rfcs/20180907-contrib-sunset.md
  * https://github.com/tensorflow/addons
If you depend on functionality not listed there, please file an issue.

usage: scvis [-h] [--version] {train,map} ...

positional arguments:
  {train,map}
    train      Learning a parametric mapping for high-dimensional single cell
               data
    map        Mapping high-dimensional single cell data to a low-dimensional
               space given a pretrained mapping

optional arguments:
  -h, --help   show this help message and exit
  --version    show program's version number and exit
```

