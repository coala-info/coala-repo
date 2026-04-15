---
name: referenceseeker
description: ReferenceSeeker identifies the most suitable reference genomes for a query assembly using a combination of kmer-based lookups and Average Nucleotide Identity calculations. Use when user asks to find reference genomes for a query assembly, calculate ANI and conserved DNA values, or rank genomic candidates for comparative genomics.
homepage: https://github.com/oschwengers/referenceseeker
metadata:
  docker_image: "quay.io/biocontainers/referenceseeker:1.8.0--pyhdfd78af_0"
---

# referenceseeker

## Overview
ReferenceSeeker is a high-performance tool designed to rapidly determine the most appropriate reference genomes for a given query assembly. It employs a two-step hierarchical approach: first, it performs a fast kmer profile-based lookup using Mash to identify potential candidates; second, it calculates specific Average Nucleotide Identity (ANI) and conserved DNA values for those candidates. This method overcomes the limitations of kmer-only distances, which can fail to distinguish between sequence identity and genome coverage, providing a more reliable ranking for comparative genomics.

## Usage Instructions

### Basic Command Pattern
The tool requires a path to a pre-built taxon database and the query genome in FASTA format (can be gzipped).
```bash
referenceseeker <database_directory> <query_genome.fasta>
```

### Common CLI Patterns
*   **Bidirectional Analysis**: For higher precision, compute ANI and conserved DNA values in both directions (query to reference and reference to query).
    ```bash
    referenceseeker --bidirectional <database> <genome>
    ```
*   **Custom Thresholds**: Adjust the community standard thresholds (default: ANI >= 95%, Conserved DNA >= 69%) to be more or less stringent.
    ```bash
    referenceseeker --ani 97 --conserved-dna 80 <database> <genome>
    ```
*   **Performance Optimization**: Use multiple threads for the ANI calculation step.
    ```bash
    referenceseeker --threads 8 <database> <genome>
    ```
*   **Unfiltered Results**: View all candidates identified by the initial Mash lookup without applying ANI/DNA conservation filters.
    ```bash
    referenceseeker --unfiltered <database> <genome>
    ```

### Output Interpretation
The output is a tab-separated table sent to STDOUT. Key columns include:
*   **ANI**: Average Nucleotide Identity (percentage).
*   **Con. DNA**: Percentage of conserved DNA.
*   **Ranking**: Candidates are ranked by the product of ANI and conserved DNA values.
*   **Metadata**: Includes NCBI Taxonomy ID, Assembly Status, and Organism name.

## Expert Tips
*   **Database Selection**: Ensure you are using the correct taxon-specific database (e.g., bacteria, archaea, fungi) for your query to avoid unnecessary computation and false positives.
*   **Installation**: The most reliable way to manage dependencies (Mash and MUMmer4) is via Bioconda: `conda install -c bioconda referenceseeker`.
*   **Verification**: Before running large batches, test your installation and database path using the provided mock data:
    ```bash
    referenceseeker referenceseeker/test/db referenceseeker/test/data/Salmonella_enterica_CFSAN000189.fasta
    ```

## Reference documentation
- [ReferenceSeeker GitHub Repository](./references/github_com_oschwengers_referenceseeker.md)
- [ReferenceSeeker Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_referenceseeker_overview.md)