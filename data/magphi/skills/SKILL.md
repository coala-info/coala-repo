---
name: magphi
description: "Magphi extracts genomic regions located between two user-defined seed sequences from draft or complete genomes. Use when user asks to extract intervening sequences between genomic markers, identify genomic islands, or perform comparative analysis of specific genomic regions across multiple genomes."
homepage: https://github.com/milnus/Magphi
---


# magphi

## Overview
Magphi is a bioinformatics utility designed to "bridge" the gap between two user-defined genomic markers. By using BLAST to locate these "seeds," the tool can handle natural sequence variation that would break strict pattern-matching approaches. It is specifically built for comparative genomics workflows where a researcher knows the flanking sequences of a region of interest and wants to extract the intervening sequence or its annotations from a large set of draft or complete genomes.

## Usage Guidelines

### Seed Sequence Preparation
The quality of your extraction depends on the design of your seed file.
- **Length**: Seeds should be at least 100bp. BLAST performance degrades significantly with shorter sequences.
- **Naming Convention**: Seeds must be provided in pairs within a multi-fasta file. Use a unique base name for the pair and append `_1` and `_2` to distinguish the flanks.
  - Example: `>island_A_1` and `>island_A_2`.
- **Redundancy**: If a seed is used in multiple different pairs, it must be duplicated in the fasta file with unique names for each pair.

### Common CLI Patterns

**Basic extraction from GFF3 files:**
```bash
Magphi -g genomes/*.gff -s seeds.fa -o output_results
```

**Extracting regions using protein seeds (tblastn):**
Use this when seeds are conserved proteins and you are searching across phylogenetically diverse genomes.
```bash
Magphi -g genomes/*.fasta -s seeds.faa -p -o protein_search
```

**Handling large genomic islands:**
If the region between your seeds is expected to be larger than 50kb, increase the maximum seed distance.
```bash
Magphi -g genomes/*.gff -s seeds.fa -md 100000
```

**Working with draft genomes (contig breaks):**
By default, Magphi ignores regions that are interrupted by a contig break. To see these partial extractions:
```bash
Magphi -g genomes/*.fasta -s seeds.fa -b
```

### Input Requirements
- **Format Consistency**: Do not mix Fasta and GFF3 files in a single command.
- **Compression**: You can use gzipped files (`.gz`), but all input files must be either gzipped or unzipped; mixing is not supported.
- **GFF3 Note**: GFF3 files must have the genome sequence appended at the end (after the `##FASTA` directive).

### Interpreting Results
Magphi produces several summary tables. Focus on these for high-level analysis:
- **master_seed_evidence.csv**: The primary file for quality control. It shows how each seed pair mapped and the evidence level for the extraction.
- **inter_seed_distance.csv**: Useful for identifying insertions or deletions between your markers across the population.
- **annotation_num_matrix.csv**: If using GFF3 inputs, this provides a quick count of features found within the extracted region.

## Best Practices and Tips
- **Seed Orientation**: Magphi automatically reorients extracted sequences based on the first seed in the pair. If you need to maintain the original genomic orientation, use the `-S` flag.
- **Inclusion**: By default, the seed sequences themselves are removed from the extracted output. Use `-is` if you want the flanking markers included in the resulting fasta/gff files.
- **Performance**: For large datasets, use the `-c` flag to specify the number of CPUs to parallelize the BLAST searches.

## Reference documentation
- [Magphi GitHub Repository](./references/github_com_milnus_Magphi.md)
- [Magphi Wiki](./references/github_com_milnus_Magphi_wiki.md)
- [Bioconda Magphi Overview](./references/anaconda_org_channels_bioconda_packages_magphi_overview.md)