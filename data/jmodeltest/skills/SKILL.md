---
name: jmodeltest
description: jModelTest identifies the most appropriate model of nucleotide substitution for DNA sequence alignments to support phylogenetic inference. Use when user asks to select a substitution model, evaluate information criteria like AIC or BIC, or estimate model-averaged parameters for genomic data.
homepage: https://github.com/ddarriba/jmodeltest2
---


# jmodeltest

## Overview
jModelTest 2 is a specialized tool for identifying the most appropriate model of nucleotide substitution for a given DNA sequence alignment. By evaluating various substitution schemes, rate variations (Gamma distribution), and invariant sites, it helps researchers avoid over-parameterization or model under-fitting in phylogenetic inference. It implements five selection strategies: hierarchical and dynamical likelihood ratio tests (hLRT and dLRT), Akaike and Bayesian information criteria (AIC and BIC), and decision theory (DT).

## Common CLI Patterns

The tool is typically executed as a Java archive. The following patterns represent standard usage for model selection:

### Basic Model Selection
To run a standard suite of tests (e.g., 88 models) using AIC and BIC:
```bash
java -jar jModelTest.jar -d input_alignment.fasta -g 4 -i -f -AIC -BIC -a
```
*   `-d`: Path to the input alignment (Phylip, Nexus, or Fasta).
*   `-g`: Number of Gamma rate categories.
*   `-i`: Include models with a proportion of invariable sites (+I).
*   `-f`: Include models with unequal base frequencies (+F).
*   `-AIC -BIC`: Calculate Akaike and Bayesian Information Criteria.
*   `-a`: Estimate model-averaged parameters.

### Advanced Tree Optimization
To specify the base tree search operation (e.g., NNI or Best):
```bash
java -jar jModelTest.jar -d input.phy -s 11 -t ML -o NNI
```
*   `-s`: Number of substitution schemes (3, 5, 7, 11, or 203).
*   `-t`: Base tree for likelihood calculations (e.g., ML, BIONJ).
*   `-o`: Tree topology search operation (NNI, SPR, or BEST).

### High Performance and Logging
For large datasets or cluster environments:
```bash
java -jar jModelTest.jar -d input.phy -tr 8 --set-local-config --set-property phyml.binary=/path/to/phyml
```
*   `-tr`: Number of threads for parallel execution.
*   `--set-local-config`: Uses a local configuration file instead of the default.
*   `--set-property`: Overrides specific properties like the path to the PhyML engine.

## Expert Tips

1.  **Hypothesis Order**: When using hLRT, you can define the order of hypotheses using the `-O` argument to control the sequence of nested model comparisons.
2.  **Checkpointing**: For long-running analyses, jModelTest 2 supports checkpointing. If a run is interrupted, it can often be resumed from the last completed model evaluation.
3.  **PhyML Compatibility**: jModelTest relies on PhyML for likelihood calculations. Ensure the PhyML binary in your path is compatible with the version of jModelTest you are running to avoid "binary not in list of compatibility" errors.
4.  **Output Redirection**: Use the argument for forwarding standard output to a file to keep a clean record of the selection process, which is useful for downstream PAUP* or MrBayes blocks.
5.  **Model Averaging**: Beyond selecting a single "best" model, use the `-a` flag to obtain model-averaged parameter estimates. This accounts for model uncertainty by weighting parameters based on their posterior probabilities or AIC weights.

## Reference documentation
- [jmodeltest2 README](./references/github_com_ddarriba_jmodeltest2.md)