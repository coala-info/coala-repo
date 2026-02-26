# deepmicroclass CWL Generation Report

## deepmicroclass_DeepMicroClass

### Tool Description
A deep learning framework for classifying metagenomic sequences

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
usage: DeepMicroClass [-h] {test,train,predict} ...

DeepMicroClass: A deep learning framework for classifying metagenomic
sequences

positional arguments:
  {test,train,predict}
    test                Test the prediction function. It will use default
                        settings to test DeepMicroClass. And output the test
                        result in the current working directory. The expected
                        result is in /usr/local/lib/python3.12/site-
                        packages/DeepMicroClass/demo/test.fa_pred_one-
                        hot_hybrid.tsv
    train               Train the model
    predict             Predict the class of a sequence

options:
  -h, --help            show this help message and exit
```

