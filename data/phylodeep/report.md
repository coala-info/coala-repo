# phylodeep CWL Generation Report

## phylodeep_checkdeep

### Tool Description
A priori model adequacy check of phylogenetic trees for phylodynamic models. Recommended to perform before selecting phylodynamic models and estimating parameters.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylodeep:0.9--pyhdfd78af_0
- **Homepage**: https://github.com/evolbioinfo/phylodeep
- **Package**: https://anaconda.org/channels/bioconda/packages/phylodeep/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/phylodeep/overview
- **Total Downloads**: 2.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/evolbioinfo/phylodeep
- **Stars**: N/A
### Original Help Text
```text
usage: checkdeep [-h] -t TREE_FILE -m {BD,BDEI,BDSS} -o OUTPUTFILE_PNG

A priori model adequacy check of phylogenetic trees for phylodynamic models.
Recommended to perform before selecting phylodynamic models and estimating
parameters.

optional arguments:
  -h, --help            show this help message and exit

tree-related arguments:
  -t TREE_FILE, --tree_file TREE_FILE
                        input tree in newick format (must be rooted, without
                        polytomies and containing at least 50 tips).

phylodynamic model arguments:
  -m {BD,BDEI,BDSS}, --model {BD,BDEI,BDSS}
                        Choose one of the models for the a priori check. For
                        trees of size, between 50 and 199 tips you can choose
                        either BD (constant-rate birth-death with incomplete
                        sampling), or BDEI (BD with exposed-infectious class).
                        For trees of size >= 200 tips, you can choose between
                        BD, BDEI and BDSS (BD with superspreading).

output:
  -o OUTPUTFILE_PNG, --outputfile_png OUTPUTFILE_PNG
                        The name of the output file (in png format).
```


## phylodeep_modeldeep

### Tool Description
Model selection for phylodynamics using pretrained neural networks.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylodeep:0.9--pyhdfd78af_0
- **Homepage**: https://github.com/evolbioinfo/phylodeep
- **Package**: https://anaconda.org/channels/bioconda/packages/phylodeep/overview
- **Validation**: PASS

### Original Help Text
```text
usage: modeldeep [-h] -t TREE_FILE -p PROBA_SAMPLING
                 [-v {CNN_FULL_TREE,FFNN_SUMSTATS}] -o OUTPUT

Model selection for phylodynamics using pretrained neural networks.

optional arguments:
  -h, --help            show this help message and exit

tree-related arguments:
  -t TREE_FILE, --tree_file TREE_FILE
                        input tree in newick format (must be rooted, without
                        polytomies and containing at least 50 tips).
  -p PROBA_SAMPLING, --proba_sampling PROBA_SAMPLING
                        presumed sampling probability for removed tips. Must
                        be between 0.01 and 1

neural-network-prediction arguments:
  -v {CNN_FULL_TREE,FFNN_SUMSTATS}, --vector_representation {CNN_FULL_TREE,FFNN_SUMSTATS}
                        Choose a type of tree representation and neural
                        networks. You can choose either CNN_FULL_TREE: CNN
                        trained on full tree representation or FFNN_SUMSTATS:
                        FFNN trained on summary statistics. By default set to
                        CNN_FULL_TREE.

output:
  -o OUTPUT, --output OUTPUT
                        The name of the output csv file (comma-separated)
                        containing predicted probabilities of each model.
```


## phylodeep_paramdeep

### Tool Description
Parameter inference for phylodynamics using pretrained neural networks.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylodeep:0.9--pyhdfd78af_0
- **Homepage**: https://github.com/evolbioinfo/phylodeep
- **Package**: https://anaconda.org/channels/bioconda/packages/phylodeep/overview
- **Validation**: PASS

### Original Help Text
```text
usage: paramdeep [-h] -t TREE_FILE -p PROBA_SAMPLING -m {BD,BDEI,BDSS}
                 [-v {CNN_FULL_TREE,FFNN_SUMSTATS}] [-c] -o OUTPUT

Parameter inference for phylodynamics using pretrained neural networks.

optional arguments:
  -h, --help            show this help message and exit

tree-related arguments:
  -t TREE_FILE, --tree_file TREE_FILE
                        input tree in newick format (must be rooted, without
                        polytomies and containing at least 50 tips).
  -p PROBA_SAMPLING, --proba_sampling PROBA_SAMPLING
                        presumed sampling probability for removed tips. Must
                        be between 0.01 and 1

neural-network-prediction arguments:
  -m {BD,BDEI,BDSS}, --model {BD,BDEI,BDSS}
                        Choose one of the models to be for which you want to
                        obtain parameter estimates. For parameter inference,
                        you can choose either BD (basic birth-death with
                        incomplete sampling) or BDEI (BD with exposed-
                        infectious) for trees of size between 50 and 199 tips
                        and BD, BDEI or BDSS (BD with superspreading
                        individuals) for trees of size >= 200 tips.
  -v {CNN_FULL_TREE,FFNN_SUMSTATS}, --vector_representation {CNN_FULL_TREE,FFNN_SUMSTATS}
                        Choose neural networks: either CNN_FULL_TREE: CNN
                        trained on full tree representation or FFNN_SUMSTATS:
                        FFNN trained on summary statistics. By default set to
                        CNN_FULL_TREE.
  -c, --ci_computation  By default (without --ci_computation option),
                        paramdeep outputs a csv file (comma-separated) with
                        point estimates for each parameter. With
                        --ci_computation option turned on, paramdeep computes
                        and outputs 95% confidence intervals (2.5% and 97.5%)
                        for each estimate using approximated parametric
                        bootstrap.

output:
  -o OUTPUT, --output OUTPUT
                        The name of the output file.
```


## Metadata
- **Skill**: generated
