---
name: popins2
description: PopIns2 discovers and genotypes large non-reference insertions across multiple individuals using a population-scale de Bruijn graph approach. Use when user asks to assemble unmapped reads, merge contigs into supercontigs, anchor novel sequences to a reference genome, or genotype insertions across a population.
homepage: https://github.com/kehrlab/PopIns2
metadata:
  docker_image: "quay.io/biocontainers/popins2:0.13.0--h077b44d_0"
---

# popins2

## Overview
PopIns2 is a specialized bioinformatics suite designed to discover and genotype large non-reference insertions across multiple individuals. Unlike standard variant callers that rely on direct mapping, PopIns2 uses a colored de Bruijn graph approach to aggregate unmapped or poorly aligned reads from an entire population. This allows for the reconstruction of "supercontigs" representing novel genetic material not present in the reference genome, which are then anchored back to specific genomic locations and genotyped across all samples.

## Workflow and CLI Patterns

The PopIns2 workflow is strictly sequential. Each command must be executed in the order listed below to maintain data integrity.

### 1. Sample Assembly
Extract and assemble unmapped/low-quality reads from individual BAM files.
```bash
# Run for each sample
popins2 assemble --sample <sample_id> <input.bam>
```
*   **Tip**: Ensure the input BAM is indexed (`bwa index`).
*   **Decontamination**: Use an additional reference FASTA with `--extra-ref` to filter out known contaminants (e.g., viral or bacterial sequences) before assembly.

### 2. Population Merging
Combine contigs from all samples into a colored compacted de Bruijn Graph (ccdbg) to generate supercontigs.
```bash
popins2 merge -r <project_directory> -di
```
*   **Critical Flags**: Always use `-r` to specify the source directory. The `-d` and `-i` flags are highly recommended for graph simplification and path identification.
*   **Alternative**: If you already have a Bifrost graph, use `-y <graph.gfa> -z <colors.bfg_colors>`.

### 3. Contig Mapping
Map the low-quality reads of each sample back to the newly generated supercontigs.
```bash
# Run for each sample
popins2 contigmap <sample_id>
```

### 4. Anchoring (Placement)
Anchor the supercontigs to the reference genome using a three-step process.
```bash
# Step A: Collect potential anchor locations
popins2 place-refalign

# Step B: Perform split-alignment for each sample
popins2 place-splitalign <sample_id>

# Step C: Combine results into a final VCF
popins2 place-finish
```

### 5. Genotyping
Determine the presence and zygosity of each insertion for every sample.
```bash
# Run for each sample
popins2 genotype <sample_id>
```

## Best Practices and Troubleshooting

*   **Directory Structure**: Maintain a consistent project structure where each sample has its own subdirectory containing the BAM and BAI files.
*   **Resource Management**: The `merge` step is memory-intensive as it builds the global graph. Ensure your environment has sufficient RAM for the population size.
*   **Compiler Optimization**: If running on a cluster, be aware that the default build uses `-march=native`. If you encounter "Illegal instruction" errors, recompile without this flag or ensure all nodes share the same CPU architecture.
*   **Bifrost Compatibility**: PopIns2 is sensitive to Bifrost versions. It is recommended to use a Bifrost version prior to the April 2022 API changes (specifically before commit `703be6d`) and ensure it was built with `MAX_KMER_SIZE=64`.
*   **Post-Processing**: To create a population-wide VCF, sort and index individual `insertions.vcf` files using `vcf-sort` and `bgzip`, then combine them using `vcf-merge`.



## Subcommands

| Command | Description |
|---------|-------------|
| popins2 assemble | Assembly of unmapped reads. |
| popins2 contigmap | Alignment of unmapped reads to assembled contigs. |
| popins2 genotype | Computes genotype likelihoods for a sample for all insertions given in the input VCF file by aligning all reads, which are mapped to the reference genome around the insertion breakpoint or to the contig, to the reference and to the alternative insertion sequence. VCF records with the genotype likelihoods in GT:PL format for the individual are written to a file insertions.vcf in the sample directory. |
| popins2 merge | Build or read a colored and compacted de Bruijn Graph (CCDBG) and generate supercontigs. |
| popins2 multik | Multi-k framework for a colored and compacted de Bruijn Graph (CCDBG) |
| popins2 place-finish | Combining breakpoint positions from split-read alignment. |
| popins2 place-refalign | Contig placing by alignment of contig ends to reference genome. |
| popins2 place-splitalign | Contig placing by split-read alignment. |

## Reference documentation
- [PopIns2 GitHub README](./references/github_com_kehrlab_PopIns2.md)
- [Post-processing Guide](./references/github_com_kehrlab_PopIns2_wiki_Post-processing.md)
- [Troubleshooting and FAQ](./references/github_com_kehrlab_PopIns2_wiki_Troubleshooting---FAQ.md)