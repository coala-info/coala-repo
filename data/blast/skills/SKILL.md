---
name: blast
description: BLAST compares primary biological sequence information to identify homologous sequences and functional motifs. Use when user asks to align nucleotide or protein sequences, search sequence databases, or identify evolutionary relationships between biological sequences.
homepage: https://blast.ncbi.nlm.nih.gov/doc/blast-help/
---

# blast

## Overview
BLAST (Basic Local Alignment Search Tool) is the industry-standard algorithm for comparing primary biological sequence information, such as the amino-acid sequences of proteins or the nucleotides of DNA sequences. This skill enables the efficient execution of sequence alignments to identify homologous sequences, functional motifs, and evolutionary relationships. It covers the transition from web-based searches to high-volume standalone BLAST+ CLI usage, including database management and parameter optimization for specific research needs.

## Program Selection Guide
Choose the specific BLAST executable based on your query and target database types:

- **blastn**: Nucleotide query against a nucleotide database. Best for mapping DNA/RNA.
- **blastp**: Protein query against a protein database. Best for finding protein homologs.
- **blastx**: Translated nucleotide query against a protein database. Useful for finding potential proteins in genomic DNA.
- **tblastn**: Protein query against a translated nucleotide database. Useful for finding genes in uncharacterized DNA.
- **tblastx**: Translated nucleotide query against a translated nucleotide database. Most sensitive for distant relationships between DNA sequences.
- **Magic-BLAST**: Optimized for mapping large next-generation sequencing (NGS) runs (RNA or DNA) against a whole genome.
- **IgBLAST**: Specialized for analyzing immunoglobulin and T cell receptor variable domain sequences.

## Common CLI Patterns
Standalone BLAST+ uses a consistent command structure. Basic syntax:
`[program] -query [input_file] -db [database_name] -out [output_file] [options]`

### Local Search Examples
- **Standard Protein Search**:
  `blastp -query protein.fasta -db nr -out results.txt -evalue 1e-5`
- **Nucleotide Search with High Sensitivity**:
  `blastn -query dna.fasta -db core_nt -out results.txt -task blastn -word_size 11`

### Remote Search
To use NCBI's compute resources and databases without downloading them locally, use the `-remote` flag:
`blastp -query query.fa -db nr -remote -out remote_results.txt`
*Note: Remote searches are subject to usage limits and lower priority than interactive web searches.*

## Parameter Optimization
Adjust these parameters to refine search sensitivity and speed:

- **Expect Value (-evalue)**: The statistical significance threshold. Default is 0.05. Lower values (e.g., `1e-10`) are more stringent; higher values allow for more distant/random matches.
- **Max Target Sequences (-max_target_seqs)**: Limits the number of aligned sequences to keep. Default is often 100.
- **Word Size (-word_size)**: The initial seed length for the alignment. 
    - For `blastn`: Default is 28 (megablast) or 11 (blastn). Smaller values increase sensitivity but slow down the search.
    - For `blastp`: Default is 3 or 6.
- **Filtering (-seg / -dust)**: Use `-seg yes` (protein) or `-dust yes` (nucleotide) to mask low-complexity regions that cause "sticky" or artifactual hits.

## Database Management
- **Core_nt**: A refined nucleotide database optimized for speed and relevance, excluding large eukaryotic chromosome assemblies.
- **ClusteredNR**: A non-redundant protein database where sequences are clustered at 90% identity. Searching this is faster and provides better taxonomic reach.
- **Local Formatting**: To use a custom FASTA file as a database, format it first:
  `makeblastdb -in custom.fasta -dbtype nucl -out my_local_db`

## Expert Tips
- **Mimicking Web BLAST**: To get results in standalone BLAST+ that match the NCBI web interface defaults, explicitly set `-evalue 0.05 -max_target_seqs 100`.
- **Batch Processing**: For large-scale searches, avoid individual API calls. Use standalone BLAST+ on a local server or utilize **ElasticBLAST** for cloud-based (AWS/GCP) scaling.
- **Short Sequences**: When searching with primers or short sequences, `blastn` parameters automatically adjust, but ensure the word size is small enough to capture the match.
- **Output Formats**: Use `-outfmt` to change results to CSV (10), JSON (15), or XML (5) for easier downstream parsing.



## Subcommands

| Command | Description |
|---------|-------------|
| blast_formatter | Stand-alone BLAST formatter client, version 2.17.0+ |
| blastn | Nucleotide-Nucleotide BLAST 2.17.0+ |
| blastp | Protein-Protein BLAST 2.17.0+ |
| blastx | Translated Query-Protein Subject BLAST 2.17.0+ |
| makeblastdb | Application to create BLAST databases, version 2.17.0+ |
| makeblastdb segmasker | Application to create BLAST databases |
| makeblastdb windowmasker | Application to create BLAST databases |
| tblastn | Protein Query-Translated Subject BLAST 2.17.0+ |
| tblastx | Translated Query-Translated Subject BLAST 2.17.0+ |

## Reference documentation
- [BLAST Help FAQ](./references/blast_ncbi_nlm_nih_gov_doc_blast-help_FAQ.html.md)
- [BLAST Databases](./references/blast_ncbi_nlm_nih_gov_doc_blast-help_blastdatabases.html.md)
- [Download and Standalone Info](./references/blast_ncbi_nlm_nih_gov_doc_blast-help_downloadblastdata.html.md)
- [Developer API Guidelines](./references/blast_ncbi_nlm_nih_gov_doc_blast-help_developerinfo.html.md)