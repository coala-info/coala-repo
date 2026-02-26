# phynteny_transformer CWL Generation Report

## phynteny_transformer

### Tool Description
Phynteny Transformer

### Metadata
- **Docker Image**: quay.io/biocontainers/phynteny_transformer:0.1.3--pyhdfd78af_0
- **Homepage**: https://github.com/susiegriggo/Phynteny_transformer
- **Package**: https://anaconda.org/channels/bioconda/packages/phynteny_transformer/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/phynteny_transformer/overview
- **Total Downloads**: 1.1K
- **Last updated**: 2025-11-06
- **GitHub**: https://github.com/susiegriggo/Phynteny_transformer
- **Stars**: N/A
### Original Help Text
```text
usage: phynteny_transformer [-h] -o OUT [--prefix PREFIX]
                            [--esm_model {facebook/esm2_t48_15B_UR50D,facebook/esm2_t6_8M_UR50D,facebook/esm2_t12_35M_UR50D,facebook/esm2_t30_150M_UR50D,facebook/esm2_t33_650M_UR50D}]
                            [-m MODELS] [-f] [--batch-size BATCH_SIZE]
                            [--confidence-threshold CONFIDENCE_THRESHOLD]
                            [--debug] [--save-attention-weights]
                            [--show-model-info] [--version] [--advanced]
                            INFILE

Phynteny Transformer

positional arguments:
  INFILE                Input GenBank file

options:
  -h, --help            show this help message and exit
  -o, --out OUT         Output directory
  --prefix PREFIX       Output prefix
  --esm_model {facebook/esm2_t48_15B_UR50D,facebook/esm2_t6_8M_UR50D,facebook/esm2_t12_35M_UR50D,facebook/esm2_t30_150M_UR50D,facebook/esm2_t33_650M_UR50D}
                        Specify path to ESM model if not the default
  -m, --models MODELS   Path to the models to use for predictions
  -f, --force           Overwrite output directory
  --batch-size BATCH_SIZE
                        Batch size for processing data
  --confidence-threshold CONFIDENCE_THRESHOLD
                        Confidence threshold for high-confidence predictions
                        (0.0-1.0)
  --debug               Enable verbose debug logging to console
  --save-attention-weights
                        Save attention weight matrices to files during
                        prediction. Attention weights will be saved as pickle
                        files in the output directory under
                        'attention_weights/' folder. Each genome will have its
                        own file containing attention weights from all models.
  --show-model-info     Display detailed information about the model
                        architecture including parameter counts and exit
  --version             show program's version number and exit
  --advanced            Show advanced options for custom models


For advanced options, use --advanced flag.
```

