---
name: lighter
description: "Lighter corrects sequencing errors in genomic reads using a memory-efficient k-mer sampling approach. Use when user asks to correct sequencing errors, improve read quality before assembly, or perform k-mer based error correction on genomic data."
homepage: https://github.com/mourisl/Lighter
---


# lighter

## Overview
Lighter is a specialized tool for correcting sequencing errors in genomic reads. It distinguishes itself from other k-mer based correctors by using a sampling-based approach rather than a counting-based one. By identifying k-mers that are likely to be part of the actual genome through sampling, it can correct errors with significantly lower memory overhead and higher speed. This skill provides the necessary command-line patterns and parameter logic to optimize read quality before assembly or downstream analysis.

## Command Line Usage

### Basic Syntax
The core command requires input files and k-mer parameters. Lighter supports both manual sampling rate specification (`-k`) and automatic coverage estimation (`-K`).

**Manual Alpha (Sampling Rate):**
```bash
lighter -r input.fastq -k <kmer_length> <genome_size> <alpha> -t <threads>
```

**Automatic Alpha Calculation:**
```bash
lighter -r input.fastq -K <kmer_length> <genome_size> -t <threads>
```

### Parameter Selection
*   **K-mer Length (`-k`/`-K`):** Typically 17–23 for most genomes. If using very long k-mers, ensure the tool was compiled with a sufficient `MAX_KMER_LENGTH`.
*   **Genome Size:** 
    *   With `-k`: Does not need to be exact, but must be at least as large as the actual genome.
    *   With `-K`: Should be relatively accurate as it is used to estimate coverage.
*   **Alpha (`alpha`):** A rule of thumb is `alpha = 7 / C`, where `C` is the average coverage of the dataset.
*   **Threads (`-t`):** Increase this to utilize multiple CPU cores for faster processing.

### Common CLI Patterns

**Paired-End Reads:**
Specify multiple `-r` flags. Lighter processes them together.
```bash
lighter -r forward.fq.gz -r reverse.fq.gz -K 21 5000000 -t 8 -od corrected_reads/
```

**Handling High Error Rates:**
If the dataset has a high error rate, Lighter may automatically adjust the maximum corrections allowed. To override this or set a strict limit:
```bash
lighter -r reads.fq -K 17 4700000 -maxcor 4
```

**Trimming and Discarding:**
*   Use `-trim` to allow the tool to trim unfixable bases.
*   Use `-discard` to remove reads that cannot be fixed. **Warning:** Using `-discard` will break paired-end matching if only one read of a pair is discarded.

**Quality Score Management:**
*   `-noQual`: Ignore quality scores during correction (useful if scores are unreliable).
*   `-newQual <ascii_char>`: Assign a specific quality score to bases that have been corrected.

## Output Interpretation
Lighter creates output files in the directory specified by `-od` (default is current directory). Output files follow the naming convention `[input_name].cor.[ext]`.

The tool appends metadata to the header line of each read:
*   `cor`: Indicates bases were corrected.
*   `bad_suffix` / `bad_prefix`: Errors at the ends could not be fixed.
*   `unfixable_error`: General failure to correct.
*   `lc`: Low coverage (reason for failure).
*   `ak`: Ambiguous candidate k-mer (reason for failure).

## Expert Tips
*   **Memory Efficiency:** Lighter is one of the most memory-efficient correctors available. If you are running out of RAM on other tools (like SGA or SOAPec), Lighter is the recommended alternative.
*   **Gzip Support:** Input files can be `.gz`. Lighter will automatically produce gzipped output if the input is compressed, saving disk space.
*   **Trusted K-mers:** For large-scale projects, you can save the identified "solid" k-mers using `-saveTrustedKmers <file>` and reload them in subsequent runs using `-loadTrustedKmers <file>` to save time.

## Reference documentation
- [Lighter GitHub Repository](./references/github_com_mourisl_Lighter.md)
- [Bioconda Lighter Overview](./references/anaconda_org_channels_bioconda_packages_lighter_overview.md)