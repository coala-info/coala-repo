---
name: sierrapy
description: sierrapy is a Python-based command-line interface for the Stanford HIVDB and CoVDB databases that performs automated viral sequence analysis and drug resistance interpretation. Use when user asks to analyze FASTA sequences for resistance, check mutation patterns, or process deep sequencing codon frequency data for HIV-1 and SARS-CoV-2.
homepage: https://github.com/hivdb/sierra-client/tree/master/python
---

# sierrapy

## Overview

sierrapy is the official Python-based command-line interface and client for the Stanford HIV Drug Resistance Database (HIVDB) and Coronavirus Antiviral & Resistance Database (CoVDB). It enables researchers to interact with the Sierra GraphQL webservice to perform automated sequence analysis. The tool is primarily used to submit viral genomic data and receive structured reports on drug resistance interpretations, mutations, and viral lineages (including PANGO lineages for SARS-CoV-2).

## Common CLI Patterns

### Analyzing FASTA Sequences
The most common use case is submitting consensus sequences for resistance analysis.
```bash
sierrapy fasta input.fasta
```
*   **Sharding**: For large FASTA files, the tool may shard results. Use `--no-sharding` to force a single output stream if your downstream pipeline requires it.
*   **Resuming**: Use `--skip N` to skip the first N sequences in a file, which is useful for resuming interrupted batch jobs.

### Analyzing Mutation Patterns
To check resistance for a specific set of mutations without a full sequence:
```bash
sierrapy patterns "PR: K20T, M46I, I54V, V82A, L90M"
```

### Deep Sequencing (Codon Frequencies)
For NGS data, use the `seqreads` commands. These require "codfreq" formatted files.
*   **HIV-1**: `sierrapy hiv1-seqreads sample.codfreq`
*   **SARS-CoV-2**: `sierrapy sars2-seqreads sample.codfreq`
*   **Note**: When pre-processing codfreq files, ensure deletion-frameshifts (del-fs) are preserved as the Sierra service uses them for quality control.

### Virus-Specific Support
While HIV-1 is the default, the client supports multiple pathogens:
*   **HIV-1**: Default analysis.
*   **SARS-CoV-2**: Includes PANGO lineage and read depth statistics.
*   **HBV/HCV**: Supported in recent versions (0.4.3+) for genotype and resistance analysis.

## Expert Tips

*   **GraphQL Flexibility**: sierrapy uses GraphQL. If the default output is missing specific fields (like `readDepthStats` or `pangoLineage`), ensure you are using the latest version (0.4.3+) which updated the default queries.
*   **Performance**: When processing thousands of sequences, avoid sharding if you are piping the output to a local file or database to reduce file handle overhead.
*   **Subtyping**: The `seqreads` method for HIV-1 is optimized to upload codon frequencies specifically for the `pol` gene to ensure accurate subtyping.



## Subcommands

| Command | Description |
|---------|-------------|
| sierrapy fasta | Run alignment, drug resistance and other analysis for one or more FASTA-format files contained DNA sequences. |
| sierrapy mutations | Run drug resistance and other analysis for PR, RT and/or IN mutations. |
| sierrapy recipe | Post process Sierra web service output. |
| sierrapy seqreads | Run alignment, drug resistance and other analysis for one or more tab-delimited text files contained codon reads of HIV-1 pol DNA sequences. |
| sierrapy_patterns | Run drug resistance and other analysis for one or more files contains lines of PR, RT and/or IN mutations based on HIV-1 type B consensus. Each line is treated as a unique pattern. |

## Reference documentation

- [sierra-client README](./references/github_com_hivdb_sierra-client_blob_master_README.md)
- [sierra-client Commit History](./references/github_com_hivdb_sierra-client_commits_master.md)