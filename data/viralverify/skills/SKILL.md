---
name: viralverify
description: viralverify classifies genomic contigs to identify viral sequences, particularly in metagenomic data. Use when user asks to classify genomic contigs, identify viruses, distinguish viral fragments from host contamination, detect plasmids, or verify results with BLAST.
homepage: https://github.com/ablab/viralVerify
metadata:
  docker_image: "quay.io/biocontainers/viralverify:1.1--hdfd78af_0"
---

# viralverify

## Overview
viralverify is a specialized tool for the classification of genomic contigs. It utilizes gene prediction via Prodigal and HMM searches against a Naive Bayes Classifier (NBC) to determine the origin of a sequence. Unlike tools that rely solely on k-mer frequencies, viralverify focuses on gene content, allowing it to identify viruses even on short contigs as long as a single virus-specific gene is present. It is particularly effective for analyzing metagenomic data where distinguishing between viral fragments and host contamination is critical.

## Usage Instructions

### Basic Classification
To run a standard classification on an assembly output:
```bash
viralverify -f input_contigs.fasta -o output_directory --hmm /path/to/hmm_db
```

### Advanced Classification Options
*   **Plasmid Detection**: To enable separate classification for plasmidic vs. non-plasmidic non-viral contigs, use the `-p` flag:
    ```bash
    viralverify -f input.fasta -o output_dir --hmm /path/to/hmm_db -p
    ```
*   **BLAST Verification**: To cross-reference results against a nucleotide database (e.g., NCBI nt) for novel virus/plasmid discovery:
    ```bash
    viralverify -f input.fasta -o output_dir --hmm /path/to/hmm_db --db /path/to/blast_db
    ```
*   **Performance Tuning**: Use the `-t` flag to specify the number of threads for `hmmsearch`:
    ```bash
    viralverify -f input.fasta -o output_dir --hmm /path/to/hmm_db -t 16
    ```

### Interpreting Results
The tool generates a comma-separated table named `<input_file>_result_table.csv` containing:
1.  **Contig Name**: The identifier from the fasta file.
2.  **Prediction Result**: Viral, non-viral, or uncertain.
3.  **Log-likelihood Ratio**: The score used for classification.
4.  **HMMs**: A list of predicted HMM hits.

Fasta files containing the categorized sequences are stored in the `Prediction_results_fasta` subfolder within your output directory.

## Expert Tips and Best Practices
*   **Sensitivity Threshold**: The default sensitivity threshold (`-thr`) is 7. If you encounter too many false positives, increase this value (e.g., `-thr 10`). Conversely, decrease it if you suspect false negatives in highly novel samples.
*   **Host Filtering**: For metagenomes with potential host contamination (e.g., human or plant samples), always filter out reads that align to the host genome *prior* to assembly to improve the accuracy of the NBC.
*   **Database Requirements**: Ensure `Prodigal` and `hmmsearch` are in your `$PATH`. The tool requires either the specific virus/chromosome HMM database provided by the developers or a recent release of the Pfam-A database.
*   **Short Contigs**: Because viralverify is gene-based, it can handle short contigs that k-mer tools might miss, but it requires at least one recognizable gene. If a contig is too short to contain a full gene, it will likely be marked as "uncertain."

## Reference documentation
- [viralVerify GitHub Repository](./references/github_com_ablab_viralVerify.md)
- [viralverify Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_viralverify_overview.md)