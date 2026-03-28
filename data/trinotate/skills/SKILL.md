---
name: trinotate
description: Trinotate is a functional annotation suite that integrates transcriptome data and search results into a structured SQLite database. Use when user asks to functionally annotate a transcriptome, integrate homology and protein domain results, or generate comprehensive annotation reports.
homepage: https://trinotate.github.io/
---


# trinotate

## Overview
Trinotate is a comprehensive suite designed for the functional annotation of transcriptomes. It excels at processing non-model organism data where a reference genome is unavailable. The tool acts as a central integrator, taking raw outputs from various bioinformatics tools and parsing them into a structured SQLite database. This allows researchers to generate functional annotation reports that combine evolutionary homology, protein family assignments, and cellular localization predictions.

## Core Workflow
The standard Trinotate workflow follows a specific sequence of data preparation, external tool execution, and database integration.

### 1. Data Preparation
Prepare your transcriptome (e.g., `Trinity.fasta`) and translate transcripts into long open reading frames (ORFs) using TransDecoder.
```bash
# Generate protein sequences
TransDecoder.LongOrfs -t Trinity.fasta
TransDecoder.Predict -t Trinity.fasta
```

### 2. Running Functional Searches
Execute homology and domain searches. These are the most time-consuming steps and should be run in parallel if possible.
```bash
# Protein homology (SwissProt/Uniprot)
blastp -query transdecoder.pep -db uniprot_sprot.pep -num_threads 8 -max_target_seqs 1 -outfmt 6 > blastp.outfmt6

# Transcript homology
blastx -query Trinity.fasta -db uniprot_sprot.pep -num_threads 8 -max_target_seqs 1 -outfmt 6 > blastx.outfmt6

# Protein family identification
hmmscan --cpu 8 --domtblout TrinotatePFAM.out Pfam-A.hmm transdecoder.pep > pfam.log
```

### 3. Database Initialization and Loading
Initialize the boilerplate SQLite database and populate it with the transcriptome structure and search results.
```bash
# Retrieve the latest Trinotate pre-generated resource database
wget "https://data.broadinstitute.org/Trinity/Trinotate_RESOURCES/Trinotate_v3_RESOURCES.tar.gz"

# Initialize database with gene-to-transcript map
Trinotate Trinotate.sqlite init --gene_trans_map Trinity.fasta.gene_trans_map --transcript_fasta Trinity.fasta --transdecoder_pep transdecoder.pep

# Load search results
Trinotate Trinotate.sqlite LOAD_swissprot_blastp blastp.outfmt6
Trinotate Trinotate.sqlite LOAD_swissprot_blastx blastx.outfmt6
Trinotate Trinotate.sqlite LOAD_pfam TrinotatePFAM.out
```

### 4. Report Generation
Extract the integrated annotations into a tab-delimited summary file.
```bash
Trinotate Trinotate.sqlite report > trinotate_annotation_report.xls
```

## Expert Tips
- **Database Updates**: Always use the `admin/Build_Trinotate_Boilerplate_SQLite_db.pl` script if you need to customize the underlying protein headers or use a non-standard homology database.
- **E-value Thresholds**: While loading results, you can filter by E-value using the `-E` flag to ensure only high-confidence annotations enter the database.
- **Memory Management**: For large transcriptomes, ensure the SQLite database is stored on a fast I/O drive (SSD) to prevent bottlenecks during the `LOAD` commands.



## Subcommands

| Command | Description |
|---------|-------------|
| Trinotate | Trinotate: Annotation of,"Trinity"-assembled Transcriptome sequences. |
| blastp | Protein-Protein BLAST 2.14.1+ |
| blastx | Translated Query-Protein Subject BLAST 2.14.1+ |
| hmmscan | search sequence(s) against a profile database |

## Reference documentation
- [Trinotate Overview](./references/trinotate_github_io_index.md)
- [Bioconda Trinotate Package](./references/anaconda_org_channels_bioconda_packages_trinotate_overview.md)