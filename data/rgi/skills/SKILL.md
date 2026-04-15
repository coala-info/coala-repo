---
name: rgi
description: The Resistance Gene Identifier (rgi) predicts antimicrobial resistance genes and mutations by matching genomic sequences against the Comprehensive Antibiotic Resistance Database. Use when user asks to identify resistance determinants in assemblies or proteins, analyze metagenomic reads for resistome profiling, or predict the pathogen-of-origin and plasmid association for detected alleles.
homepage: https://card.mcmaster.ca
metadata:
  docker_image: "quay.io/biocontainers/rgi:6.0.5--pyh05cac1d_0"
---

# rgi

## Overview
The Resistance Gene Identifier (rgi) is the primary computational tool for the Comprehensive Antibiotic Resistance Database (CARD). It provides a standardized method for identifying antimicrobial resistance (AMR) determinants by matching query sequences against curated homology and SNP-based models. Use this skill to automate the detection of resistance genes in bacterial or fungal pathogens, determine the mechanism of action (e.g., antibiotic inactivation, target alteration), and predict the pathogen-of-origin or plasmid association for detected alleles.

## Core Workflows

### 1. Analyzing Assemblies and Proteins (rgi main)
Use `rgi main` for high-quality genomic data (contigs or protein sequences). It categorizes hits into three levels of confidence:
- **Perfect**: 100% identity over the entire length of the reference.
- **Strict**: Hits that fall within the curated bitscore cutoffs (highly likely to be functional).
- **Loose**: Hits that fall outside cutoffs but show homology (useful for discovery of new variants).

**Common Pattern:**
```bash
rgi main --input_sequence [input.fasta] --output_file [output_prefix] --input_type [contig|protein] --local --clean
```

### 2. Analyzing Metagenomic Reads (rgi bwt)
Use `rgi bwt` when working with raw FASTQ short reads. This workflow maps reads against CARD reference sequences using algorithms like KMA or Bowtie2 to provide a profile of the resistome without requiring assembly.

**Common Pattern:**
```bash
rgi bwt --read_one [R1.fastq] --read_two [R2.fastq] --output_file [output_prefix] --aligner [kma|bowtie2]
```

### 3. Pathogen and Plasmid Prediction (rgi kmer)
Use `rgi kmer` to determine if a detected resistance gene is likely chromosomal or plasmid-borne, and to predict the host pathogen.

**Common Pattern:**
```bash
rgi kmer_query --input_sequence [input.fasta] --output_file [output_prefix]
```

## Expert Tips and Best Practices
- **Database Updates**: Always ensure you are using the latest CARD data. Run `rgi load` to import the latest ARO (Antibiotic Resistance Ontology) and model files.
- **Bitscore vs. Identity**: Rely on the "Strict" bitscore cutoffs rather than simple percent identity. CARD models are curated with specific bitscore thresholds that account for the diversity of different gene families.
- **SNP-based Resistance**: For pathogens like *Mycobacterium tuberculosis*, ensure you are using the "Protein Variant" or "rRNA Gene Variant" models, as resistance is often conferred by specific point mutations rather than gene acquisition.
- **Heatmap Generation**: Use the `rgi heatmap` command to visualize results across multiple samples, which is particularly useful for comparative genomics or longitudinal metagenomic studies.
- **Clean Up**: Use the `--clean` flag in `rgi main` to remove temporary files (like BLAST/Diamond outputs) and save disk space.



## Subcommands

| Command | Description |
|---------|-------------|
| rgi | Use the Resistance Gene Identifier to predict resistome(s) from protein or nucleotide data based on homology and SNP models. Check https://card.mcmaster.ca/download for software and data updates. Receive email notification of monthly CARD updates via the CARD Mailing List (https://mailman.mcmaster.ca/mailman/listinfo/card-l) |
| rgi bwt | Aligns metagenomic reads to CARD and wildCARD reference using kma, bowtie2 or bwa and provide reports. |
| rgi heatmap | Creates a heatmap when given multiple RGI results. |
| rgi kmer_query | Tests sequenes using CARD*kmers |
| rgi load | Resistance Gene Identifier - 6.0.5 - Load |
| rgi main | Resistance Gene Identifier - 6.0.5 - Main |

## Reference documentation
- [CARD Analyze - RGI Overview](./references/card_mcmaster_ca_analyze.md)
- [CARD Home - Database Statistics and Capabilities](./references/card_mcmaster_ca_home.md)
- [RGI Download and Installation](./references/card_mcmaster_ca_download.md)
- [FungAMR - Fungal Resistance Data](./references/card_mcmaster_ca_fungamrhome.md)
- [TB Mutations - M. tuberculosis Specific Models](./references/card_mcmaster_ca_tbhome.md)