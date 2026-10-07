# deepmicroclass CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| deepmicroclass_predict | PASS |  |
| deepmicroclass_train | Failed | tool bug: the train subcommand has no handler and crashes with KeyError 'func' (train.py is empty in this release). |

## deepmicroclass_predict

### Tool Description
Predict the class of a sequence

### Metadata
- **Docker Image**: quay.io/biocontainers/deepmicroclass:1.0.3--pyhdfd78af_1
- **Homepage**: https://github.com/chengsly/DeepMicroClass
- **Package**: https://anaconda.org/channels/bioconda/packages/deepmicroclass/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/deepmicroclass/overview
- **Total Downloads**: 1.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/chengsly/DeepMicroClass
- **Stars**: N/A
### Original Help Text
```text
usage: DeepMicroClass predict [-h] --input INPUT --output_dir OUTPUT_DIR
                              [--model MODEL] [--encoding {onehot,embedding}]
                              [--mode {hybrid,single}]
                              [--single-len SINGLE_LEN] [--device {cpu,cuda}]

options:
  -h, --help            show this help message and exit
  --input INPUT, -i INPUT
                        Path to the input fasta file
  --output_dir OUTPUT_DIR, -o OUTPUT_DIR
                        Path to the output directory
  --model MODEL, -m MODEL
                        Path to the trained model
  --encoding {onehot,embedding}, -e {onehot,embedding}
                        Encoding method
  --mode {hybrid,single}, -md {hybrid,single}
                        Prediction mode
  --single-len SINGLE_LEN, -sl SINGLE_LEN
                        Length to use in the single mode
  --device {cpu,cuda}, -d {cpu,cuda}
                        Device to use
```

## deepmicroclass_train

### Tool Description
Train the model

### Metadata
- **Docker Image**: quay.io/biocontainers/deepmicroclass:1.0.3--pyhdfd78af_1
- **Homepage**: https://github.com/chengsly/DeepMicroClass
- **Package**: https://anaconda.org/channels/bioconda/packages/deepmicroclass/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/deepmicroclass/overview
- **Total Downloads**: 1.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/chengsly/DeepMicroClass
- **Stars**: N/A
### Original Help Text
```text
usage: DeepMicroClass train [-h] [--input INPUT] [--log_prefix LOG_PREFIX]

options:
  -h, --help            show this help message and exit
  --input INPUT, -i INPUT
                        Path to the input fasta file
  --log_prefix LOG_PREFIX, -l LOG_PREFIX
                        Prefix for the log directory
```

