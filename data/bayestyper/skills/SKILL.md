---
name: bayestyper
description: BayesTyper is a probabilistic genotyping framework that uses k-mer alignment to genotype diverse variation types across a variant graph. Use when user asks to genotype SNPs and structural variants, perform k-mer based variant calling, or estimate genotypes for complex genomic regions.
homepage: https://github.com/bioinformatics-centre/BayesTyper
metadata:
  docker_image: "quay.io/biocontainers/bayestyper:1.5--h077b44d_4"
---

# bayestyper

## Overview

BayesTyper is a probabilistic genotyping framework designed to handle diverse variation types, ranging from simple SNPs to complex structural variants (SVs). By representing variants in a graph and performing exact alignment of k-mers, it bypasses the reference bias often inherent in standard linear alignment-based callers. The tool is particularly useful when working with complex genomic regions where traditional realignment might fail. It typically operates in a multi-step workflow: candidate variant generation, k-mer counting, and the final genotyping inference.

## Command Line Usage and Best Practices

### Core Genotyping
The primary command for inference is `bayesTyper genotype`.

*   **Noise Estimation**: For most large-scale human datasets, the default noise estimation is stable. However, for smaller genomes or variant sets with very few SNVs, use the `--noise-genotyping` flag. This mode estimates noise parameters and genotypes jointly, which is more robust for small datasets but increases memory and time requirements.
*   **Ploidy Handling**: By default, BayesTyper assumes human ploidy. For other organisms or specific sex chromosome analysis, provide a ploidy file using `--chromosome-ploidy-file`. Supported levels are 0, 1 (haploid), and 2 (diploid).
*   **Haplotype Candidates**: If genotyping a small number of samples, consider increasing `--max-number-of-sample-haplotypes` (default is 32) to improve sensitivity, though this may increase computation time in complex clusters.

### Sample Batching and Merging
BayesTyper is optimized for batches of up to 30 samples. To process larger cohorts:
1.  Generate a unified candidate variant set across all samples.
2.  Run `bayesTyper genotype` on separate batches (≤ 30 samples each) using the same candidate set.
3.  Compress the resulting VCFs using `bgzip`.
4.  Merge batches using `bcftools`:
    ```bash
    bcftools merge --filter-logic x --info-rules ACP:max -O z -o merged_output.vcf.gz batch1.vcf.gz batch2.vcf.gz
    ```
    *Note: Non-PASS filters may not be consistent after merging.*

### Filtering and Refinement
BayesTyper applies several "hard" filters by default, including Genotype Posterior Probability (GPP < 0.99) and k-mer coverage thresholds (NAK/FAK).

*   **Refiltering**: Use `bayesTyperTools filter` to adjust stringency without rerunning the full genotyping stage.
    ```bash
    bayesTyperTools filter -v <input.vcf> -o <output_prefix> -z \
        --min-genotype-posterior 0.95 \
        --kmer-coverage-file <prefix>_genomic_parameters.txt
    ```
*   **Unfiltered Calls**: To retrieve all calls (e.g., for downstream sensitivity analysis), set all filter thresholds to 0.

### Tool-Specific Tips
*   **K-mer Size**: The k-mer size (default 55) is fixed at compile-time. If your read length or complexity requires a different size (e.g., k=31 for shorter reads), you must recompile from source using `-DKMER_SIZE=<value>`.
*   **Insertion Alleles**: When converting alleles from other callers (like Manta), ensure insertion sequences are provided in the `SEQ` or `SVINSSEQ` attributes, or provide a fasta file to `bayesTyperTools convertAllele`.
*   **Memory Management**: Complex variant clusters can significantly increase memory usage. If the tool crashes on specific regions, check the complexity of the input VCF in those clusters.



## Subcommands

| Command | Description |
|---------|-------------|
| bayestyper | BayesTyper (v1.5 ) |
| bayestyper_bayesTyperTools | BayesTyperTools (v1.5 ) |

## Reference documentation
- [BayesTyper Main Repository](./references/github_com_bioinformatics-centre_BayesTyper.md)
- [Executing BayesTyper on sample batches](./references/github_com_bioinformatics-centre_BayesTyper_wiki_Executing-BayesTyper-on-sample-batches.md)
- [Filtering Guide](./references/github_com_bioinformatics-centre_BayesTyper_wiki_Filtering.md)
- [Building from Source (K-mer configuration)](./references/github_com_bioinformatics-centre_BayesTyper_wiki_Building-BayesTyper-from-source.md)