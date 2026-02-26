# amplify CWL Generation Report

## amplify_AMPlify

### Tool Description
Predict whether a sequence is AMP or not. Input sequences should be in fasta format. Sequences should be shorter than 201 amino acids long, and should not contain amino acids other than the 20 standard ones.

### Metadata
- **Docker Image**: quay.io/biocontainers/amplify:2.0.1--py36hdfd78af_0
- **Homepage**: https://github.com/bcgsc/AMPlify
- **Package**: https://anaconda.org/channels/bioconda/packages/amplify/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/amplify/overview
- **Total Downloads**: 14.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bcgsc/AMPlify
- **Stars**: N/A
### Original Help Text
```text
usage: AMPlify.py [-h] [-m {balanced,imbalanced}] -s SEQS [-od OUT_DIR]
                  [-of {txt,tsv}] [-sub {on,off}] [-att {on,off}]

AMPlify v2.0.0
------------------------------------------------------
Predict whether a sequence is AMP or not.
Input sequences should be in fasta format. 
Sequences should be shorter than 201 amino acids long, 
and should not contain amino acids other than the 20 standard ones. 

optional arguments:
  -h, --help            show this help message and exit
  -m {balanced,imbalanced}, --model {balanced,imbalanced}
                        Balanced or imbalanced model (balanced by default,
                        optional)
  -s SEQS, --seqs SEQS  Sequences for prediction, fasta file
  -od OUT_DIR, --out_dir OUT_DIR
                        Output directory (optional)
  -of {txt,tsv}, --out_format {txt,tsv}
                        Output format, txt or tsv (tsv by default, optional)
  -sub {on,off}, --sub_model {on,off}
                        Whether to output sub-model results, on or off (off by
                        default, optional)
  -att {on,off}, --attention {on,off}
                        Whether to output attention scores, on or off (off by
                        default, optional)
```


## amplify_train_amplify

### Tool Description
AMPlify v2.0.0 training. Given training sets with two labels: AMP and non-AMP, train the AMP prediction model.

### Metadata
- **Docker Image**: quay.io/biocontainers/amplify:2.0.1--py36hdfd78af_0
- **Homepage**: https://github.com/bcgsc/AMPlify
- **Package**: https://anaconda.org/channels/bioconda/packages/amplify/overview
- **Validation**: PASS

### Original Help Text
```text
usage: train_amplify.py [-h] -amp_tr AMP_TR -non_amp_tr NON_AMP_TR
                        [-amp_te AMP_TE] [-non_amp_te NON_AMP_TE]
                        [-sample_ratio {balanced,imbalanced}] -out_dir OUT_DIR
                        -model_name MODEL_NAME

AMPlify v2.0.0 training
------------------------------------------------------
Given training sets with two labels: AMP and non-AMP,
train the AMP prediction model.    

optional arguments:
  -h, --help            show this help message and exit
  -amp_tr AMP_TR        Training AMP set, fasta file
  -non_amp_tr NON_AMP_TR
                        Training non-AMP set, fasta file
  -amp_te AMP_TE        Test AMP set, fasta file (optional)
  -non_amp_te NON_AMP_TE
                        Test non-AMP set, fasta file (optional)
  -sample_ratio {balanced,imbalanced}
                        Whether the training set is balanced or not (balanced
                        by default, optional)
  -out_dir OUT_DIR      Output directory
  -model_name MODEL_NAME
                        File name of trained model weights
```

