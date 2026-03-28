---
name: pypgatk
description: pypgatk is a proteogenomics toolkit used to generate customized protein search databases from genomic variants, non-canonical reading frames, and alternative transcripts. Use when user asks to download reference data, translate VCF variants to protein databases, perform three-frame translation, generate decoy databases, or map peptides back to genomic coordinates.
homepage: http://github.com/bigbio/py-pgatk
---

# pypgatk

## Overview

pypgatk (ProteoGenomics Analysis Toolkit) is a specialized suite of tools designed to bridge the gap between genomics and proteomics. It enables the creation of search-ready FASTA databases that incorporate variants, non-canonical reading frames, and alternative transcripts. This is essential for identifying novel proteoforms and mutations in mass spectrometry data that are typically absent from standard reference proteomes. The toolkit handles the entire pipeline from data acquisition and sequence translation to post-identification genomic mapping.

## Core CLI Workflows

The toolkit is accessed via the `pgatk` command followed by specific subcommands.

### 1. Data Acquisition
Download reference genomes, annotations, and variant files for specific species using Taxonomy IDs.

```bash
# Download Ensembl data for Human (TaxID: 9606)
pgatk ensembl-downloader -t 9606 -o ensembl_human

# Download cancer mutations from cBioPortal
pgatk cbioportal-downloader --download_all --output_directory cbioportal_data
```

### 2. Variant-to-Protein Translation
Translate genomic variants into protein sequences. This usually requires a transcript FASTA (often generated via `gffread`) and a GTF annotation file.

```bash
# Translate VCF variants to a protein database
pgatk vcf-to-proteindb \
    --vcf input.vcf.gz \
    --input_fasta transcripts.fa \
    --gene_annotations_gtf annotations.gtf \
    --output_proteindb variant_proteins.fa
```

### 3. Non-Canonical ORF Discovery
Generate databases for proteogenomics by translating DNA sequences in multiple frames or targeting specific biotypes.

```bash
# Three-frame translation of transcript sequences
pgatk threeframe-translation \
    --input_fasta transcripts.fa \
    --output_proteindb threeframe_db.fa

# Translate DNA sequences with biotype filtering (e.g., lncRNAs)
pgatk dnaseq-to-proteindb \
    --input_fasta genome.fa \
    --config_file config.yaml \
    --output_proteindb non_canonical.fa
```

### 4. Database Refinement and Decoys
Prepare the final database for search engines by adding decoys and validating sequences.

```bash
# Generate target-decoy database using DecoyPYrat (recommended for proteogenomics)
pgatk generate-decoy \
    --input target_proteins.fa \
    --output target_decoy.fa \
    --method decoypyrat

# Filter short sequences and handle stop codons
pgatk ensembl-check \
    --input_fasta database.fa \
    --output_fasta cleaned_database.fa
```

### 5. Post-Processing and Genomic Mapping
Map identified peptides back to the genome for visualization in browsers like IGV or UCSC.

```bash
# Map identified peptides to genomic coordinates
pgatk map-peptide2genome \
    --input_psm identifications.tsv \
    --input_gtf annotations.gtf \
    --output_gff3 peptides_on_genome.gff3
```

## Expert Tips and Best Practices

- **Transcript Preparation**: Before running `vcf-to-proteindb`, use `gffread` to extract transcript sequences from the genome FASTA using the GTF file. This ensures coordinate consistency.
- **Decoy Strategy**: For proteogenomics, the `decoypyrat` method is generally preferred over simple reversal to maintain similar amino acid composition and peptide length distributions in the decoy set.
- **Variant Filtering**: When using `vcf-to-proteindb`, ensure the VCF contains consequence annotations (e.g., from VEP) if you want to filter for specific mutation types, though the tool can often process raw VCFs by intersecting with GTF coordinates.
- **Memory Management**: For large VCFs (like gnomAD), use the chromosome-specific processing options if available to reduce memory overhead.



## Subcommands

| Command | Description |
|---------|-------------|
| pgatk generate-decoy | Generate decoy protein sequences for a target protein database. |
| pypgatk blast_get_position | Get the position of peptides in a reference database. |
| pypgatk cbioportal-downloader | Download data from cBioPortal |
| pypgatk cbioportal-to-proteindb | Configuration for cbioportal to proteindb tool |
| pypgatk cosmic-downloader | Download mutation data from COSMIC |
| pypgatk cosmic-to-proteindb | Convert COSMIC mutation data to a protein database. |
| pypgatk dnaseq-to-proteindb | Configuration to perform conversion between ENSEMBL Files |
| pypgatk ensembl-check | Perform Ensembl database check |
| pypgatk ensembl-downloader | This tool enables to download from enseml ftp the FASTA and GTF files |
| pypgatk peptide-class-fdr | The peptide_class_fdr allows to filter the peptide psm files (IdXML files) using two different FDR threshold types: - Global FDR - Global FDR + Peptide Class FDR The peptide classes can be defined in two ways as simple class: - "altorf,pseudo,ncRNA,COSMIC,cbiomut,var_mut,var_rs" where each class represent only one kind of peptide source pseudo gene, ncRNA, etc. The second for of representing peptide classes is using groups of classes: - "{ non_canonical:[altorf,pseudo,ncRNA];mutations:[COSMIC,cbiomut];variants:[var _mut,var_rs]}" in this case a class is a group of peptide sources for example: mutations with two difference sources as COSMIC and cbiomut (CBioportal mutation) . |
| pypgatk validate_peptides | Validate peptides using the pypgatk pipeline. |
| pypgatk vcf-to-proteindb | Configuration to perform conversion between ENSEMBL Files |
| pypgatk_mztab_class_fdr | Filter peptides by global-fdr and class-fdr |

## Reference documentation
- [pgatk -- ProteoGenomics Analysis Toolkit](./references/github_com_bigbio_pgatk_blob_master_README.md)
- [pypgatk Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_pypgatk_overview.md)