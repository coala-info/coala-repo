---
name: evidencemodeler
description: EVidenceModeler integrates diverse gene predictions and evidence types into a single consensus genome annotation. Use when user asks to combine ab initio predictions, protein homology, and transcript assemblies into a best-fit gene structure or partition large genomes for parallel annotation processing.
homepage: https://github.com/EVidenceModeler/EVidenceModeler
---


# evidencemodeler

## Overview
EVidenceModeler (EVM) serves as a consensus builder for genome annotation. Rather than predicting genes from scratch, it acts as a decision-making framework that integrates diverse evidence types—ab initio predictions, protein homology, and transcript assemblies—into a single automated gene structure. By applying user-defined weights to different evidence classes, EVM resolves overlapping or conflicting gene models to produce a final "best-fit" annotation.

## Core Workflow and CLI Usage

### 1. Input Validation
Before running the modeler, you must ensure your GFF3 files adhere to EVM's specific requirements (gene -> mRNA -> exon -> CDS structure).
```bash
# Validate gene prediction GFF3 files
$EVM_HOME/EvmUtils/gff3_gene_prediction_file_validator.pl predictions.gff3
```

### 2. Defining Evidence Weights
Create a tab-delimited `weights.txt` file. This file tells EVM which evidence to trust more.
*   **ABINITIO_PREDICTION**: Standard gene finders (e.g., Augustus, SNAP).
*   **TRANSCRIPT**: High-quality RNA-seq or PASA assemblies (usually weighted highest).
*   **PROTEIN**: Spliced alignments from related species.

**Example weights.txt:**
```text
ABINITIO_PREDICTION  augustus     1
ABINITIO_PREDICTION  glimmerHMM   1
TRANSCRIPT           PASA_models  10
PROTEIN              spliced_prot 5
```

### 3. Running EVidenceModeler
For small genomes or single contigs, run the main executable directly:
```bash
EVidenceModeler --genome genome.fasta \
    --weights weights.txt \
    --gene_predictions predictions.gff3 \
    --protein_alignments protein_alignments.gff3 \
    --transcript_alignments transcript_alignments.gff3 \
    --output_file_root evm_output
```

### 4. Large Genome Processing (Partitioning)
For whole genomes, use the utility scripts to partition the genome into manageable chunks, run them in parallel, and recombine.
1.  **Partition**: `$EVM_HOME/EvmUtils/partition_EVM_inputs.pl --genome genome.fasta --gene_predictions predictions.gff3 ...`
2.  **Generate Commands**: `$EVM_HOME/EvmUtils/write_EVM_commands.pl --genome genome.fasta --weights weights.txt ... > commands.list`
3.  **Execute**: Use ParaFly or a similar task runner to execute `commands.list`.
4.  **Recombine**: `$EVM_HOME/EvmUtils/recombine_EVM_outputs_recursive.pl --output_file_root evm_output`

## Expert Tips and Best Practices
*   **Unique Exon IDs**: EVM requires that if an exon is shared among different transcripts in your input GFF3, they must be presented as distinct features with unique IDs.
*   **Spliced Alignments Only**: Do not provide simple BLAST results for protein or transcript evidence. Use spliced-alignment tools like Exonerate, GeneWise, or PASA to ensure intron-aware evidence.
*   **Weighting Strategy**: Assign higher weights to evidence with higher biological confidence. PASA transcript assemblies typically receive the highest weight (e.g., 10), while ab initio predictors receive lower weights (e.g., 1).
*   **Alternative Splicing**: Note that EVM does not currently model alternative splicing; it will select the single best consensus structure for a locus.
*   **Memory Management**: For large genomes, always use the partitioning utilities. Running EVM on a full chromosome without partitioning can lead to excessive memory consumption.

## Reference documentation
- [EVidenceModeler Wiki](./references/github_com_EVidenceModeler_EVidenceModeler_wiki.md)
- [Bioconda EVM Overview](./references/anaconda_org_channels_bioconda_packages_evidencemodeler_overview.md)