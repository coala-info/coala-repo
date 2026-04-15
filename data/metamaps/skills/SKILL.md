---
name: metamaps
description: MetaMaps performs high-resolution taxonomic assignment and abundance estimation for long-read metagenomic data. Use when user asks to build a reference database, map long reads to a database, or classify microbial species and strains.
homepage: https://github.com/DiltheyLab/MetaMaps
metadata:
  docker_image: "quay.io/biocontainers/metamaps:0.1.98102e9--h21ec9f0_2"
---

# metamaps

## Overview

MetaMaps is a specialized tool for the analysis of long-read metagenomic data. It bridges the gap between fast k-mer based methods and slower, exact alignment approaches by providing high-resolution taxonomic assignments and abundance estimations. It is particularly effective for identifying species and strains within complex microbial communities using the higher information content of long reads.

## Core Workflow

### 1. Database Construction
Before analyzing reads, you must build a MetaMaps database. This requires reference FASTA files and NCBI-style taxonomy files (nodes.dmp, names.dmp).

```bash
perl buildDB.pl --DB databases/myDB --FASTAs references.fa --taxonomy /path/to/taxonomy/
```

*   **Tip**: Use `annotateRefSeqSequencesWithUniqueTaxonIDs.pl` if working with RefSeq to ensure every sequence has a unique, valid taxon ID.
*   **Database Stats**: Check the composition of your database using `DBinfo.pl`:
    ```bash
    perl DBinfo.pl databases/myDB species
    ```

### 2. Mapping Reads
You can map reads directly or use a pre-built index for better performance on repeated runs.

**Direct Mapping:**
```bash
./metamaps mapDirectly --all -r databases/myDB/DB.fa -q sample_reads.fastq -o results/mapping_output
```

**Indexed Mapping:**
1. Create Index:
   ```bash
   ./metamaps index -r databases/myDB/DB.fa -i databases/myDB/index -m 2000 --pi 80
   ```
2. Map against Index:
   ```bash
   ./metamaps mapAgainstIndex --all -i databases/myDB/index -q sample_reads.fastq -o results/mapping_output
   ```

### 3. Classification and Abundance Estimation
After mapping, run the classification step to generate the final taxonomic profiles.

```bash
./metamaps classify --mappings results/mapping_output --DB databases/myDB
```

## Expert Tips and Best Practices

*   **Memory Management**: For large databases or limited hardware, use the `--maxmemory` flag (in GB) during mapping to prevent crashes:
    ```bash
    ./metamaps mapDirectly --maxmemory 20 ...
    ```
*   **Sensitivity Tuning**: Adjust the minimum read length (`-m`) and percentage identity (`--pi`) based on your sequencing quality. For Nanopore, `--pi 80` is a common starting point.
*   **Multi-threading**: MetaMaps utilizes OpenMP. Ensure your environment has `OMP_NUM_THREADS` set or check if the specific build supports the `--threads` flag for parallel processing.
*   **Output Interpretation**: The classification step produces several files. Focus on the `.EM.WIMP` or similar summary files for the most accurate abundance estimations after the Expectation-Maximization algorithm has converged.



## Subcommands

| Command | Description |
|---------|-------------|
| metamaps | Simultaneous metagenomic classification and mapping. |
| metamaps | Simultaneous metagenomic classification and mapping. |
| metamaps_classify | Classify contigs based on sequence identity and length. |
| metamaps_index | Index a reference genome for mapping. |

## Reference documentation
- [Commands and Usage Examples](./references/github_com_DiltheyLab_MetaMaps_blob_master_Commands.txt.md)
- [Experimental and Simulation Commands](./references/github_com_DiltheyLab_MetaMaps_blob_master_Commands_experiments.txt.md)
- [Database Information Script](./references/github_com_DiltheyLab_MetaMaps_blob_master_DBinfo.pl.md)
- [Database Building Guide](./references/github_com_DiltheyLab_MetaMaps_blob_master_buildDB.pl.md)
- [Main README](./references/github_com_DiltheyLab_MetaMaps_blob_master_README.md)