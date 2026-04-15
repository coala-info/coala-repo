---
name: varifier
description: Varifier assesses the accuracy of variant calls by comparing a query VCF against a truth FASTA sequence using probe mapping and sequence alignment. Use when user asks to evaluate VCF precision and recall, compare variant calls to a truth assembly, or calculate fractional and edit-distance-based accuracy statistics.
homepage: https://github.com/iqbal-lab-org/varifier
metadata:
  docker_image: "quay.io/biocontainers/varifier:0.4.0--pyhdfd78af_0"
---

# varifier

## Overview

The `varifier` tool provides a robust framework for assessing the accuracy of variant calls by comparing a query VCF against a "truth" FASTA sequence. Instead of comparing VCF records directly, which can be confounded by different ways of representing the same indel, `varifier` uses probe mapping and sequence alignment to determine if the called alleles exist in the truth genome. It produces detailed statistics including binary, fractional, and edit-distance-based precision and recall.

## Core Workflow

To evaluate a VCF file, you must provide the truth assembly, the reference assembly used for calling, and the VCF itself.

### Basic Evaluation
Run the standard evaluation pipeline:
```bash
varifier vcf_eval truth.fasta ref.fasta test.vcf out_dir
```

### Key Outputs
The results are stored in the specified `out_dir`. The most critical file is `summary_stats.json`, which contains:
- **Precision/Recall**: Binary (all or nothing), Fractional (proportion of allele match), and Edit Distance (penalizes based on sequence difference).
- **Excluded_record_counts**: Breakdown of records skipped due to being heterozygous, having no genotype, or failing filters.

## Command Line Options and Best Practices

### Filtering and Genotypes
- **Heterozygous Calls**: Note that `varifier` automatically ignores heterozygous calls and records without a genotype (`GT`). It is designed for haploid or consensus-style verification.
- **Filter PASS**: Use `--filter_pass` to only evaluate variants marked as "PASS" in the VCF.
- **Reference Calls**: Use `--use_ref_calls` if you want to include `0/0` calls in the evaluation.

### Alignment and Normalization
- **Global Alignment**: For complex regions, use `--use_mafft` to enable global alignment via MAFFT, which can improve accuracy for larger indels.
- **Indel Handling**: Adjust `--indel_max_fix_length` to control the maximum size of indels that the tool attempts to normalize or fix during alignment.
- **Homopolymers**: Use `--hp_min_fix_length` to specifically address and fix potential errors in homopolymer runs.

### Verification Logic
- **Binary Measure**: The allele must be 100% correct to count as a True Positive (TP).
- **Fractional Measure**: Provides a score between 0 and 1 based on the matching proportion of the allele.
- **Edit Distance Measure**: Calculates a score based on the edit distance between the called allele, the reference, and the truth, focusing only on the divergent parts of the sequence.

## Expert Tips
- **Reference Consistency**: Ensure that the `ref.fasta` provided is the exact same file used to generate the `test.vcf`. If the `REF` column in the VCF does not match the sequence in `ref.fasta`, those records will be excluded.
- **Memory Management**: For very large VCFs or highly fragmented assemblies, monitor memory usage as the probe mapping step can be resource-intensive.
- **Non-ACGT Characters**: If your sequences contain ambiguous bases (N, R, Y, etc.), ensure you are using a version of `varifier` (v0.3.0+) that supports `--use_non_acgt`.



## Subcommands

| Command | Description |
|---------|-------------|
| varifier make_truth_vcf | Make truth VCF file |
| varifier vcf_eval | Evaluate VCF file |

## Reference documentation
- [Main Usage and Installation](./references/github_com_iqbal-lab-org_varifier.md)
- [Summary Stats JSON Details](./references/github_com_iqbal-lab-org_varifier_wiki_Summary-stats-JSON-file.md)