---
name: trinotate
description: Trinotate is a comprehensive framework for functional annotation of transcriptomic data, specifically optimized for non-model organisms where a reference genome may be unavailable.
homepage: https://trinotate.github.io/
---

# trinotate

## Overview
Trinotate is a comprehensive framework for functional annotation of transcriptomic data, specifically optimized for non-model organisms where a reference genome may be unavailable. It orchestrates several biological analysis tools to assign biological context to sequences. The workflow typically involves generating protein translations, running homology and domain searches, and importing the resulting data into a unified Trinotate SQLite database for report generation and downstream functional enrichment analysis.

## Core Workflow

### 1. Data Preparation
Before running Trinotate, ensure you have your transcriptome assembly (FASTA) and have generated candidate coding regions.
- **Generate Proteome:** Use TransDecoder to identify long ORFs and predict proteins from your `Trinity.fasta`.
- **Initialize Database:** Copy the boilerplate Trinotate SQLite database provided with the installation to your working directory.

### 2. Sequence Analysis (Parallelizable)
Run these searches independently to gather functional evidence:
- **Protein Homology:** `blastp -query transdecoder.pep -db uniprot_sprot.fasta -max_target_seqs 1 -outfmt 6 -evalue 1e-5 -num_threads 8 > blastp.outfmt6`
- **Transcript Homology:** `blastx -query Trinity.fasta -db uniprot_sprot.fasta -max_target_seqs 1 -outfmt 6 -evalue 1e-5 -num_threads 8 > blastx.outfmt6`
- **Domain Identification:** `hmmscan --cpu 8 --domtblout TrinotatePFAM.out Pfam-A.hmm transdecoder.pep`
- **Signal Peptides:** `signalp -f short -n signalp.out transdecoder.pep`
- **Transmembrane Domains:** `tmhmm --short < transdecoder.pep > tmhmm.out`

### 3. Loading the Database
Populate the SQLite database with the generated results:
- **Load transcripts/proteins:** `Trinotate Trinotate.sqlite init --gene_trans_map Trinity.fasta.gene_trans_map --transcript_fasta Trinity.fasta --transdecoder_pep transdecoder.pep`
- **Load BLAST results:** `Trinotate Trinotate.sqlite LOAD_blastp blastp.outfmt6` and `Trinotate Trinotate.sqlite LOAD_blastx blastx.outfmt6`
- **Load Pfam:** `Trinotate Trinotate.sqlite LOAD_pfam TrinotatePFAM.out`
- **Load SignalP/TMHMM:** `Trinotate Trinotate.sqlite LOAD_signalp signalp.out` and `Trinotate Trinotate.sqlite LOAD_tmhmm tmhmm.out`

### 4. Output and Reporting
Generate the final annotation report:
- `Trinotate Trinotate.sqlite report > trinotate_annotation_report.xls`

## Expert Tips
- **Database Updates:** Always ensure your `uniprot_sprot.fasta` and `Pfam-A.hmm` are the versions compatible with the Trinotate pre-calculated data tables to ensure GO terms and EggNOG assignments map correctly.
- **Memory Management:** For large transcriptomes, use the `--num_threads` flag in BLAST and HMMER to speed up processing, but monitor RAM usage as HMMER can be memory-intensive.
- **E-value Thresholds:** While `1e-5` is standard for BLAST, consider stricter thresholds (e.g., `1e-10`) if you require higher confidence for functional assignments in non-model species.

## Reference documentation
- [Trinotate Wiki Documentation](./references/trinotate_github_io_index.md)
- [Bioconda Trinotate Overview](./references/anaconda_org_channels_bioconda_packages_trinotate_overview.md)