---
name: snp-sites
description: snp-sites extracts single nucleotide polymorphisms from multi-FASTA alignment files and converts them into VCF, Phylip, or SNP-only FASTA formats. Use when user asks to extract SNPs from a whole-genome alignment, convert alignments to VCF or Phylip format, or filter alignments to include only variable sites.
homepage: https://github.com/sanger-pathogens/snp-sites
metadata:
  docker_image: "quay.io/biocontainers/snp-sites:2.5.1--h577a1d6_7"
---

# snp-sites

## Overview
snp-sites is a high-performance C utility designed to solve the scalability issues of extracting single nucleotide polymorphisms (SNPs) from massive whole-genome alignments. It transforms large multi-FASTA files into compact, informative formats while maintaining a very low memory footprint (e.g., processing an 8GB alignment using less than 60MB of RAM). This tool is essential for preparing data for downstream applications like RAxML, Artemis, or BEAST.

## Command Line Usage

The basic syntax for snp-sites is:
`snp-sites [options] <input_file.aln>`

### Common Output Formats
By default, the tool outputs a multi-FASTA alignment containing only the SNP sites to STDOUT. Use the following flags to change the output format:

*   **VCF Output**: `-v`
    Generates a VCF file containing the position of each SNP relative to the first sequence in the alignment. Useful for visualization in tools like Artemis.
*   **Phylip Output**: `-p`
    Generates a relaxed Phylip format file. This is the standard input for many phylogenetic tree-building applications like RAxML.
*   **Multi-FASTA (Default)**: `-m`
    Outputs a multi-FASTA alignment containing only the variable sites.

### Filtering and Refinement
*   **Strict ACGT Filtering**: `-c`
    Only output columns that contain exclusively ACGT characters. This filters out any columns containing gaps (`-`), unknowns (`N`), or ambiguous bases.
*   **Monomorphic Sites**: `-b`
    Output monomorphic sites. This is specifically required for certain types of analysis in BEAST to correctly model the substitution rate.
*   **Internal Reference**: `-r`
    Include an internal pseudo-reference sequence in the output.

### File Handling
*   **Output to File**: `-o <filename>`
    Direct the output to a specific file instead of STDOUT.
*   **Gzip Support**: The tool natively supports gzipped input files (e.g., `input.aln.gz`) without needing to decompress them first.

## Expert Tips and Best Practices

*   **Memory Efficiency**: Because snp-sites is highly optimized, you can run it on standard desktop hardware even when dealing with thousands of taxa and gigabyte-scale alignments.
*   **Pipeline Integration**: Since the tool defaults to STDOUT, it is easily piped into other utilities. However, when generating Phylip or VCF files for large datasets, always use the `-o` flag to avoid flooding the terminal.
*   **Handling Gaps**: If your downstream phylogenetic tool is sensitive to gaps or ambiguous characters, always use the `-c` flag to ensure a "clean" SNP-only alignment.
*   **Reference Selection**: Note that in VCF output, the first sequence in your multi-FASTA file is treated as the reference. Ensure your alignment is ordered correctly if you require a specific strain to be the reference point.

## Reference documentation
- [SNP-sites GitHub README](./references/github_com_sanger-pathogens_snp-sites.md)
- [SNP-sites Wiki](./references/github_com_sanger-pathogens_snp-sites_wiki.md)