---
name: ragout
description: Ragout performs chromosome-level scaffolding of genome assemblies using multiple reference genomes. Use when user asks to scaffold draft genome assemblies to chromosome level or reconstruct genome structure using reference genomes.
homepage: https://github.com/fenderglass/Ragout
---


# ragout

yaml
name: ragout
description: Chromosome-level scaffolding of genome assemblies using multiple reference genomes. Use when you have draft genome assemblies (contigs/scaffolds) and one or more related reference genomes, and you need to produce a chromosome-scale assembly. This tool is particularly useful for analyzing genome rearrangements and reconstructing the most parsimonious structure of a target genome.
```
## Overview
Ragout is a powerful tool designed for chromosome-level scaffolding of genome assemblies. It takes your initial assembly fragments (contigs or scaffolds) and one or more related reference genomes to construct a chromosome-scale assembly. Ragout excels at identifying and analyzing genome rearrangements such as inversions and translocations, enabling the reconstruction of a more complete and ordered genome structure. It is suitable for both small and large genomes, including those of mammalian complexity.

## Usage Instructions

Ragout operates via its command-line interface. The core functionality involves providing your draft assembly fragments and reference genomes to the `ragout` command.

### Basic Command Structure

The fundamental command structure for Ragout is as follows:

```bash
ragout <input_assembly_fragments> <reference_genomes> [options]
```

### Key Arguments and Options

*   **`input_assembly_fragments`**: Path to your input assembly contigs or scaffolds. This is typically a FASTA file.
*   **`reference_genomes`**: Paths to one or more reference genome FASTA files. These should be related to your input assembly.
*   **`--outdir`**: Specifies the output directory for Ragout's results. If not provided, results will be placed in the current directory.
*   **`--prefix`**: A prefix for output files.
*   **`--threads`**: Number of threads to use for computation.
*   **`--min_contig_len`**: Minimum length of contigs to consider.
*   **`--min_scaffold_len`**: Minimum length of scaffolds to consider.

### Common Workflow Patterns

1.  **Scaffolding with a single reference:**
    ```bash
    ragout my_contigs.fasta human_reference.fasta --outdir ragout_output --prefix human_scaffold --threads 8
    ```

2.  **Scaffolding with multiple references:**
    Ragout can leverage multiple references to improve scaffolding accuracy. Provide paths to each reference genome.
    ```bash
    ragout my_contigs.fasta ref1.fasta ref2.fasta --outdir ragout_output --prefix multi_ref_scaffold --threads 16
    ```

### Expert Tips

*   **Reference Quality**: The quality and completeness of your reference genomes significantly impact Ragout's performance. Ensure your references are well-annotated and cover the genomic regions of interest.
*   **Input Fragment Length**: Longer input contigs or scaffolds generally lead to better scaffolding results. Pre-processing your assembly to merge or extend short contigs can be beneficial.
*   **Parameter Tuning**: Experiment with `--min_contig_len` and `--min_scaffold_len` based on the characteristics of your input assembly.
*   **Output Analysis**: Ragout produces several output files, including scaffolded FASTA files and structural rearrangement reports. Analyze these outputs to understand the inferred genome structure and any detected rearrangements.
*   **Resource Management**: For large genomes, consider increasing the `--threads` parameter and ensuring sufficient memory is available.

## Reference documentation
- [Ragout Overview](./references/anaconda_org_channels_bioconda_packages_ragout_overview.md)
- [Ragout GitHub Repository](./references/github_com_mikolmogorov_Ragout.md)
- [Ragout Documentation (docs folder)](./references/github_com_mikolmogorov_Ragout_tree_master_docs.md)