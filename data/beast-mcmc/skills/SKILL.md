---
name: beast-mcmc
description: BEAST performs Bayesian MCMC analysis to reconstruct time-scaled phylogenies and test evolutionary hypotheses from molecular sequences. Use when user asks to reconstruct rooted trees, sample from a posterior distribution of phylogenies, summarize trees with TreeAnnotator, or merge MCMC logs.
homepage: https://beast.community
metadata:
  docker_image: "biocontainers/beast-mcmc:v1.10.4dfsg-1-deb_cv1"
---

# beast-mcmc

## Overview
BEAST (Bayesian Evolutionary Analysis Sampling Trees) is a sophisticated framework for reconstructing rooted, time-scaled phylogenies and testing evolutionary hypotheses. Unlike many phylogenetic tools that produce a single "best" tree, BEAST uses Markov Chain Monte Carlo (MCMC) to sample from a posterior distribution of trees, allowing for the integration of uncertainty. This skill focuses on the command-line execution of the BEAST engine and its suite of post-processing utilities to ensure efficient and statistically sound evolutionary inferences.

## Execution and Performance
The primary command for running an analysis is `beast`. It requires an XML configuration file, typically generated via the BEAUti GUI.

### Basic Command Patterns
- **Standard Run**: `beast input_file.xml`
- **Specify Seed**: `beast -seed 12345 input_file.xml` (Ensures reproducibility).
- **Overwrite Output**: `beast -overwrite input_file.xml` (Forces overwriting of existing log/tree files).

### Optimizing with BEAGLE
The BEAGLE library is critical for accelerating likelihood calculations, especially for large datasets or complex substitution models.
- **Enable BEAGLE**: `beast -beagle input_file.xml`
- **Hardware Selection**:
  - Use CPU: `beast -beagle_CPU input_file.xml`
  - Use GPU: `beast -beagle_GPU input_file.xml`
- **Precision**: Use `-beagle_double` for higher numerical stability or `-beagle_single` for speed on compatible hardware.
- **Threading**: For BEAGLE v3.1+, use `-beagle_thread_count <n>` to specify the number of threads.

## Post-Processing Utilities
After the MCMC run completes, use the following tools to analyze the output.

### Summarizing Trees (TreeAnnotator)
TreeAnnotator is used to find the Maximum Clade Credibility (MCC) tree from the posterior sample.
- **Pattern**: `treeannotator -burnin <number_of_states> -heights <mean|median|ca> input.trees output.mcc.tre`
- **Tip**: A 10% burn-in is a standard starting point (e.g., if you sampled 10,000 trees, use `-burnin 1000`).

### Merging Runs (LogCombiner)
If you have run multiple independent MCMC chains to confirm convergence, use LogCombiner to merge them.
- **Combine Logs**: `logcombiner -log run1.log -log run2.log -o combined.log`
- **Combine Trees**: `logcombiner -trees -log run1.trees -log run2.trees -o combined.trees`

## Expert Tips and Best Practices
- **Convergence Diagnostics**: Always check the Effective Sample Size (ESS) in Tracer. An ESS > 200 for all parameters is the standard requirement for publication-quality results.
- **Negative Branch Lengths**: If TreeAnnotator produces negative branch lengths, it is often due to using "average" node heights for clades that appear at low frequencies. Consider using "Median" heights or "Common Ancestor" heights to mitigate this.
- **Memory Management**: For very large datasets, increase the Java heap space by passing JVM arguments: `java -Xmx4g -jar beast.jar input.xml`.
- **Sampling from Prior**: To check if your data is actually informing the model, run the analysis without data by checking the "Sample from prior only" option in BEAUti or modifying the XML to ensure the likelihood is ignored.

## Reference documentation
- [About BEAST](./references/beast_community_about.md)
- [Frequently Asked Questions](./references/beast_community_faq.html.md)
- [Installing BEAST](./references/beast_community_installing.md)
- [BEAST Topics and Programs](./references/beast_community_topics.html.md)