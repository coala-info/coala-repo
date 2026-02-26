# adpred CWL Generation Report

## adpred_run-adpred

### Tool Description
Predicts activation domains (ADs) from protein sequences or UniProt IDs using deep learning and secondary structure prediction.

### Metadata
- **Docker Image**: quay.io/biocontainers/adpred:1.3.1--pyhdfd78af_0
- **Homepage**: https://github.com/FredHutch/adpred
- **Package**: https://anaconda.org/channels/bioconda/packages/adpred/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/adpred/overview
- **Total Downloads**: 17.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/FredHutch/adpred
- **Stars**: N/A
### Original Help Text
```text
2026-02-24 14:52:59.839599: I tensorflow/core/platform/cpu_feature_guard.cc:193] This TensorFlow binary is optimized with oneAPI Deep Neural Network Library (oneDNN) to use the following CPU instructions in performance-critical operations:  SSE4.1 SSE4.2 AVX AVX2 AVX_VNNI FMA
To enable them in other operations, rebuild TensorFlow with the appropriate compiler flags.
2026-02-24 14:52:59.889641: I tensorflow/core/util/util.cc:169] oneDNN custom operations are on. You may see slightly different numerical results due to floating-point round-off errors from different computation orders. To turn them off, set the environment variable `TF_ENABLE_ONEDNN_OPTS=0`.

    
If you wish to use a local installation of psipred, please indicate this,
    by assigning the path to local_psipred (e.g. local_psipred = "~/psipred/run_psipred")


2026-02-24 14:53:01.208416: I tensorflow/core/platform/cpu_feature_guard.cc:193] This TensorFlow binary is optimized with oneAPI Deep Neural Network Library (oneDNN) to use the following CPU instructions in performance-critical operations:  SSE4.1 SSE4.2 AVX AVX2 AVX_VNNI FMA
To enable them in other operations, rebuild TensorFlow with the appropriate compiler flags.
using adpred version 1.2.8You should perovide sequence or uniprot Id..., see --helpTraceback (most recent call last):
  File "/usr/local/bin/run-adpred", line 75, in <module>
    predictions_f = open(out_prefix + '.predictions.csv','w')
TypeError: unsupported operand type(s) for +: 'NoneType' and 'str'
```

