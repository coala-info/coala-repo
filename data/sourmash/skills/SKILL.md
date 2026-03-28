---
name: sourmash
description: Sourmash performs fast genomic sketching and comparison using MinHash algorithms to create representative signatures of DNA or RNA sequences. Use when user asks to create genomic signatures, calculate similarity between datasets, search databases for matches, or perform taxonomic classification of metagenomic samples.
homepage: https://github.com/sourmash-bio/sourmash
---


# sourmash

## Overview
Sourmash is a command-line tool and Python library used for "genomic sketching." It implements the MinHash and FracMinHash algorithms to reduce large DNA/RNA sequences into small, representative "signatures." These signatures allow for extremely fast and memory-efficient comparisons between datasets, enabling tasks like searching large databases for matches, calculating similarity between genomes, and identifying the microbial components of complex environmental samples.

## Core CLI Workflows

### 1. Creating Signatures (Sketching)
Before analysis, sequences must be converted into `.sig` files.
- **For Genomes:** Use `scaled=1000` (default) and `k=21,31,51`.
  ```bash
  sourmash sketch dna genome.fna.gz -p k=21,k=31,scaled=1000 --name-from-first
  ```
- **For Metagenomes:** Use a higher scaled value (e.g., 2000-5000) to save space if the sample is very large.
  ```bash
  sourmash sketch dna reads.fastq.gz -p k=31,scaled=2000 -o sample.sig
  ```

### 2. Comparing Signatures
Calculate the Jaccard similarity or containment between multiple signatures.
- **Compare and Plot:**
  ```bash
  sourmash compare *.sig -o cmp.dist
  sourmash plot cmp.dist --labels
  ```

### 3. Searching Databases
Find which known genomes are present in your signature.
- **Search:** Returns genomes with high Jaccard similarity.
  ```bash
  sourmash search query.sig genbank-k31.zip
  ```
- **Gather:** The preferred method for metagenomes. It performs a "greedy" decomposition to identify the minimum set of genomes that account for all k-mers in the sample.
  ```bash
  sourmash gather sample.sig genbank-k31.zip
  ```

### 4. Taxonomic Classification
Assign taxonomy to `gather` results using a Least Common Ancestor (LCA) database.
```bash
sourmash gather sample.sig genbank-k31.zip -o gather_results.csv
sourmash tax annotate -g gather_results.csv -t taxonomy_db.csv
```

## Expert Tips & Best Practices
- **Scaled Parameter:** The `scaled` value determines the compression (1/scaled k-mers are kept). A `scaled=1000` means 1 out of every 1000 k-mers is stored. Ensure all signatures being compared use the same `scaled` value.
- **K-mer Sizes:** 
  - `k=21`: Genus/Species level sensitivity.
  - `k=31`: Species/Strain level sensitivity (Standard).
  - `k=51`: High specificity for strain-level matching.
- **Abundance Tracking:** Use `--abundance` during sketching if you want to track the frequency of k-mers, which is essential for metagenomic differential abundance analysis.
- **Signature Manipulation:** Use `sourmash sig consume`, `sourmash sig merge`, and `sourmash sig extract` to manage large collections of signatures without re-sketching the original fasta files.
- **Zip Databases:** Always use the `.zip` format for large databases (like GTDB or GenBank) as it is optimized for fast internal lookups.



## Subcommands

| Command | Description |
|---------|-------------|
| compare | Compares one or more signatures (created with `sketch`) using estimated Jaccard index [1] or (if signatures are created with `-p abund`) the angular similarity [2]). |
| plot | Generate plots from sourmash compare output. |
| prefetch | Search for query signatures within specified databases. |
| search | Searches a collection of signatures or SBTs for matches to the query signature. It can search for matches with either high Jaccard similarity or containment; the default is to use Jaccard similarity, unless --containment is specified. -o/--output will create a CSV file containing the matches. |
| sig | Manipulate signature files |
| sig | Manipulate signature files |
| sourmash compute | Create MinHash sketches at k-mer sizes of 21, 31 and 51, for all FASTA and FASTQ files in the current directory, and save them in signature files ending in '.sig'. You can rapidly compare these files with `compare` and query them with `search`, among other operations; see the full documentation at http://sourmash.rtfd.io/. The key options for compute are: |
| sourmash gather | Selects the best reference genomes to use for a metagenome analysis, by finding the smallest set of non-overlapping matches to the query in a database. This is specifically meant for metagenome and genome bin analysis. |
| sourmash index | Create an on-disk database of signatures that can be searched quickly & in low memory. All signatures must be scaled, and must be the same k-mer size and molecule type; the standard signature selectors (-k/--ksize, --scaled, --dna/--protein) choose which signatures to be added. |
| sourmash sketch | Create signatures |
| sourmash_lca | Taxonomic utilities |
| sourmash_storage | Storage utilities |
| sourmash_tax | Integrate taxonomy information based on 'gather' results |

## Reference documentation
- [Sourmash Command Line Reference](./references/sourmash_readthedocs_io_en_latest_command-line.html.md)
- [Basic Tutorial](./references/sourmash_readthedocs_io_en_latest_tutorial-basic.html.md)
- [Metagenome Analysis (Gather)](./references/sourmash_readthedocs_io_en_latest_sourmash-examples.html.md)
- [Taxonomic Classification](./references/sourmash_readthedocs_io_en_latest_classifying-signatures.html.md)