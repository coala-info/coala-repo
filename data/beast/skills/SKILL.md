---
name: beast
description: BEAST performs Bayesian evolutionary analysis to reconstruct phylogenies and test evolutionary hypotheses using MCMC sampling. Use when user asks to reconstruct phylogenetic trees, perform tip-dating to calibrate molecular clocks, estimate population dynamics, or summarize tree distributions with TreeAnnotator.
homepage: https://beast.community
---


# beast

## Overview
The BEAST (Bayesian Evolutionary Analysis Sampling Trees) skill enables the reconstruction of phylogenies and the testing of evolutionary hypotheses. Unlike standard phylogenetic tools that produce a single tree, BEAST uses Markov chain Monte Carlo (MCMC) to sample from the posterior distribution of trees, providing a robust measure of uncertainty. It is the industry standard for "tip-dating" (using sequence sampling dates to calibrate clocks) and phylodynamic analysis (estimating population growth and viral spread).

## Core Workflow
1.  **Preparation (BEAUti):** Use the BEAUti graphical interface to load alignments (NEXUS/FASTA) and specify models (substitution, clock, and tree priors). This generates the required `.xml` configuration file.
2.  **Execution (BEAST):** Run the MCMC chain using the BEAST CLI.
3.  **Diagnosis (Tracer):** Load the resulting `.log` file into Tracer to check for convergence and ensure Effective Sample Size (ESS) values exceed 200.
4.  **Summarization (TreeAnnotator):** Process the `.trees` file to produce a Maximum Clade Credibility (MCC) tree.
5.  **Visualization (FigTree):** View the annotated MCC tree.

## CLI Usage and Patterns

### Running a Basic Analysis
Execute a pre-configured XML file:
```bash
beast input_file.xml
```

### Performance Optimization
BEAST performance scales with the BEAGLE library. Always attempt to use it for large datasets:
- **Use BEAGLE (CPU):** `beast -beagle input.xml`
- **Use BEAGLE (GPU):** `beast -beagle_gpu input.xml`
- **Specify Thread Count:** `beast -threads <count> input.xml`

### Common CLI Options
- `-prefix <name>`: Add a prefix to all output files (log, trees).
- `-resume`: Restart an interrupted run from the last checkpoint (requires existing log/trees).
- `-overwrite`: Overwrite existing output files without prompting.
- `-seed <number>`: Specify a fixed seed for reproducibility.

### Post-Processing with TreeAnnotator
To summarize the posterior distribution of trees into a single MCC tree:
```bash
treeannotator -burnin <number_of_states> -heights [median|mean] input.trees output.mcc.tree
```
*Note: Burn-in is typically 10% of the total states.*

## Expert Tips
- **Effective Sample Size (ESS):** If ESS values are < 200, the chain has not mixed well. Increase the chain length in the XML or tune the operators.
- **Negative Branch Lengths:** If TreeAnnotator produces negative branch lengths, it is often due to using "Mean Heights" on clades with low posterior probability. Switch to "Median Heights" or "Common Ancestor Heights."
- **Sampling from Prior:** To check if your data is actually informing the results, run the analysis without data by checking "Sample from prior only" in BEAUti. If the posterior looks identical to the prior, your data lacks signal for that parameter.
- **BEAST vs BEAST 2:** This skill is for BEAST X (v10.x). While similar in purpose, BEAST 2 uses a different XML schema and package architecture.

## Reference documentation
- [About BEAST](./references/beast_community_about.md)
- [Frequently Asked Questions](./references/beast_community_faq.html.md)
- [Installing BEAST](./references/beast_community_installing.md)
- [BEAST Topics and Tutorials](./references/beast_community_topics.html.md)