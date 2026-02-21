---
name: tesorter
description: TEsorter is a specialized bioinformatics tool designed to classify transposable elements at the lineage level.
homepage: https://github.com/NBISweden/TEsorter
---

# tesorter

## Overview
TEsorter is a specialized bioinformatics tool designed to classify transposable elements at the lineage level. It works by identifying conserved protein domains within TE sequences using HMMER/HMMScan. It is particularly effective for classifying Long Terminal Repeat (LTR) retrotransposons but supports a wide range of Class I and Class II elements. Use this skill to automate the classification of repeat libraries, annotate domains in GFF3 format, or prepare TE sequences for downstream phylogenetic analysis.

## Installation
The recommended way to install TEsorter is via Bioconda:
```bash
conda install -c bioconda tesorter
```

## Common CLI Patterns

### Basic Classification
Classify DNA sequences using the default REXdb database (combined plant and metazoa):
```bash
TEsorter input.fasta
```

### Domain-Specific Databases
For plant-specific or animal-specific genomes, using a subset database can improve accuracy:
```bash
# For plant TEs
TEsorter input.fasta -db rexdb-plant

# For metazoan TEs
TEsorter input.fasta -db rexdb-metazoa

# For classical GyDB classification
TEsorter input.fasta -db gydb
```

### Processing Protein Sequences
If the input consists of TE polyproteins or gene protein sequences rather than genomic DNA:
```bash
TEsorter RepeatPeps.lib -st prot
```

### Performance and Sensitivity Tuning
Optimize the run for speed or discovery depth:
```bash
# Use more processors (default is 4)
TEsorter input.fasta -p 20

# Increase sensitivity (lower coverage and higher E-value threshold)
TEsorter input.fasta -cov 10 -eval 1e-2

# Increase specificity (higher coverage and disable pass-2 similarity search)
TEsorter input.fasta -cov 30 -eval 1e-5 -dp2
```

## Expert Tips and Best Practices

### Understanding Pass-2 Classification
TEsorter uses a two-pass approach for DNA sequences. Pass-1 identifies domains via HMMScan. Pass-2 (enabled by default for `nucl`) attempts to classify remaining sequences based on similarity to Pass-1 results.
- If you require high-confidence domain-based evidence only, use `-dp2` to disable the second pass.
- You can tune the Pass-2 similarity rule using `-rule identity-coverage-length` (default is `80-80-80`).

### Preparing for Phylogenetics
TEsorter generates several files useful for evolutionary studies. The `.dom.faa` file contains extracted protein sequences of identified domains.
- To extract a specific domain (e.g., Reverse Transcriptase) for alignment:
  ```bash
  grep "\-RT" your_output.rexdb.dom.tsv | cut -f1 > rt_ids.txt
  # Then use a tool like seqtk or the provided get_record.py to extract sequences from .dom.faa
  ```

### Output File Reference
- `.cls.tsv`: The primary classification table (Order, Superfamily, Clade, and Strand).
- `.dom.gff3`: Domain annotations for visualization in genome browsers.
- `.cls.lib`: A FASTA library formatted for use with RepeatMasker.
- `.dom.tsv`: Detailed domain scores and coverages, useful for manual filtering.

### Limitations
- **Frame Shifts**: TEsorter identifies the best hit per domain. If a sequence has multiple frame shifts, only the highest-scoring fragment is typically annotated.
- **Non-autonomous Elements**: Elements lacking protein domains (like MITEs or SINEs) will generally remain unclassified by this tool.

## Reference documentation
- [TEsorter GitHub README](./references/github_com_NBISweden_TEsorter.md)
- [Bioconda TEsorter Overview](./references/anaconda_org_channels_bioconda_packages_tesorter_overview.md)