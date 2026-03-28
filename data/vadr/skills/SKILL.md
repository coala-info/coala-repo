---
name: vadr
description: VADR classifies and annotates viral sequences by comparing them against a library of covariance models to identify features and quality alerts. Use when user asks to classify viral sequences, annotate features like CDS or genes, or screen submissions for viruses such as SARS-CoV-2, Influenza, and Mpox.
homepage: https://github.com/ncbi/vadr
---


# vadr

## Overview
VADR (Viral Annotation DefineR) provides a standardized pipeline for the classification and feature annotation of viral sequences. It is primarily used by GenBank to screen incoming submissions for viruses like SARS-CoV-2 and Norovirus. The tool compares input FASTA sequences against a library of covariance models and BLAST databases to map features (CDS, genes, etc.) and identify "alerts"—divergent attributes that may cause a sequence to fail quality standards.

## Core Workflows

### 1. Pre-processing Sequences
Before running VADR, always trim terminal ambiguous nucleotides (N's) to ensure consistency with GenBank results.
```bash
$VADRSCRIPTSDIR/miniscripts/fasta-trim-terminal-ambigs.pl --minlen 50 --maxlen 30000 input.fa > trimmed.fa
```

### 2. Automated Classification and Annotation
Use `v-scan.pl` for a "hands-off" approach. It automatically identifies the correct model library and runs the annotation.
```bash
v-scan.pl -m trimmed.fa output_dir
```

### 3. Targeted Annotation (v-annotate.pl)
For specific viruses, use `v-annotate.pl` with recommended flags for performance and accuracy.

**SARS-CoV-2 Recommended Pattern:**
```bash
v-annotate.pl --split --cpu 8 --glsearch -s -r --nomisc --mkey sarscov2 \
  --lowsim5seq 6 --lowsim3seq 6 \
  --alt_fail lowscore,insertnn,deletinn \
  --mdir /path/to/sarscov2-models trimmed.fa output_dir
```

**Influenza Recommended Pattern:**
```bash
v-annotate.pl --split --cpu 8 -r --atgonly --xnocomp --nomisc \
  --alt_fail extrant5,extrant3 --mkey flu \
  --mdir /path/to/flu-models trimmed.fa output_dir
```

**Mpox Recommended Pattern:**
```bash
v-annotate.pl --split --cpu 4 --glsearch --minimap2 -s -r --nomisc --mkey mpxv \
  --r_lowsimok --r_lowsimxd 100 --r_lowsimxl 2000 \
  --alt_pass discontn,dupregin --s_overhang 150 \
  --mdir /path/to/mpxv-models trimmed.fa output_dir
```

## Expert Tips & Best Practices
- **Parallelization**: Always use `--split --cpu <n>` for large datasets or long genomes (like Mpox) to significantly reduce runtime.
- **Model Selection**: Use `--mkey` to specify the library (e.g., `flavi`, `calici`, `corona`, `flu`) and `--mdir` if your models are not in the default `$VADRMODELDIR`.
- **Handling Alerts**: 
  - A sequence "Passes" if it has zero fatal alerts.
  - Use `--alt_fail <codes>` to promote specific alerts to fatal status.
  - Use `--alt_pass <codes>` to ignore specific alerts that would otherwise cause failure.
- **Memory Management**: For long sequences like Mpox, ensure at least 16GB of RAM is available when using multiple CPUs.
- **Misc Features**: In SARS-CoV-2, common alerts in accessory ORFs (like ORF8) often trigger a `misc_feature` annotation instead of a hard failure. Use `--nomisc` if you want to prevent this behavior and force standard CDS evaluation.



## Subcommands

| Command | Description |
|---------|-------------|
| v-annotate.pl | classify and annotate sequences using a model library |
| v-test.pl | test VADR scripts |

## Reference documentation
- [Available VADR model files](./references/github_com_NLM-DIR_vadr_wiki_Available-VADR-model-files.md)
- [SARS-CoV-2 annotation](./references/github_com_NLM-DIR_vadr_wiki_Coronavirus-annotation.md)
- [Influenza annotation](./references/github_com_NLM-DIR_vadr_wiki_Influenza-annotation.md)
- [Mpox virus annotation](./references/github_com_NLM-DIR_vadr_wiki_Mpox-virus-annotation.md)