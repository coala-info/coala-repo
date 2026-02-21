---
name: magicblast
description: Magic-BLAST is a specialized alignment tool built on the NCBI BLAST framework, optimized for mapping NGS runs.
homepage: https://ncbi.github.io/magicblast/
---

# magicblast

## Overview
Magic-BLAST is a specialized alignment tool built on the NCBI BLAST framework, optimized for mapping NGS runs. Unlike standard BLAST, it treats read pairs as a single unit and handles spliced RNA-seq alignments by calculating composite scores across introns. It is unique because it indexes the read batches rather than the genome, making it efficient for mapping against large or diverse sequence collections.

## Database Preparation
Before mapping, the reference genome or transcriptome must be formatted as a BLAST database. While Magic-BLAST can use a FASTA file directly, it is significantly slower for references larger than bacterial genomes.

**Create a nucleotide database:**
```bash
makeblastdb -in reference.fa -dbtype nucl -parse_seqids -out db_name
```
*   **Critical:** The `-parse_seqids` flag is required to retain original sequence identifiers in the output.

## Mapping Local Reads
Magic-BLAST supports FASTA and FASTQ formats.

**Single-end reads:**
```bash
# For FASTA (default)
magicblast -query reads.fa -db db_name

# For FASTQ
magicblast -query reads.fastq -db db_name -infmt fastq
```

**Paired-end reads:**
*   **Two files:** Use `-query` for the first mate and `-query_mate` for the second.
    ```bash
    magicblast -query r1.fastq -query_mate r2.fastq -db db_name -infmt fastq
    ```
*   **Single interleaved file:** Use the `-paired` flag.
    ```bash
    magicblast -query interleaved.fastq -db db_name -infmt fastq -paired
    ```

## Mapping SRA Data
Magic-BLAST can stream data directly from the NCBI Sequence Read Archive (SRA).

*   **Single accession:** `magicblast -sra SRR123456 -db db_name`
*   **Multiple accessions:** `magicblast -sra SRR123,SRR456 -db db_name`
*   **Batch file (one accession per line):** `magicblast -sra_batch accessions.txt -db db_name`

## Alignment Logic: RNA vs. DNA
The tool's behavior changes based on whether the target is a genome (splicing possible) or a transcriptome/bacterial genome (splicing impossible).

*   **RNA-seq to Genome (Default):** Spliced alignment is enabled by default.
*   **DNA-seq or Bacterial Mapping:** Disable splicing to improve accuracy and speed.
    ```bash
    magicblast -query reads.fa -db bacteria_db -splice F
    ```
*   **Mapping to Transcriptome:** Use the `-reftype` shorthand to disable splicing and repeat-masking logic.
    ```bash
    magicblast -query reads.fa -db transcriptome_db -reftype transcriptome
    ```

## Performance and Output
*   **Multi-threading:** Use `-num_threads <N>` to utilize multiple CPU cores.
*   **Output Format:** Default is SAM. Use `-outfmt tabular` for a tab-delimited format.
*   **Compression:** Use `-gzo` to produce gzipped output.
*   **Filtering:** Use `-no_unaligned` to suppress reporting of reads that failed to map.

**Example optimized command:**
```bash
magicblast -query reads.fastq -db hg38 -infmt fastq -num_threads 12 -no_unaligned -out results.sam
```

## Reference documentation
- [Create a BLAST database](./references/ncbi_github_io_magicblast_cook_blastdb.html.md)
- [Reads in FASTA or FASTQ](./references/ncbi_github_io_magicblast_cook_fasta.html.md)
- [Paired reads](./references/ncbi_github_io_magicblast_cook_paired.html.md)
- [RNA vs DNA](./references/ncbi_github_io_magicblast_cook_rnavsdna.html.md)
- [Output formats](./references/ncbi_github_io_magicblast_doc_output.html.md)
- [Use NCBI SRA repository](./references/ncbi_github_io_magicblast_cook_sra.html.md)