---
name: plncpro
description: PLncPRO is a bioinformatics tool that uses a Random Forest algorithm to distinguish between protein-coding transcripts and long non-coding RNAs in plant species. Use when user asks to annotate novel lncRNAs, filter non-coding sequences from transcriptomes, build custom species-specific machine learning models, or extract specific RNA sequence subsets from prediction outputs.
homepage: https://github.com/urmi-21/PLncPRO
metadata:
  docker_image: "quay.io/biocontainers/plncpro:1.2.2--py37hc9558a2_0"
---

# plncpro

## Overview

PLncPRO (Plant Long Non-Coding RNA Prediction by Random Forests) is a bioinformatics tool designed to distinguish between protein-coding transcripts and lncRNAs in plant species. It utilizes a Random Forest algorithm trained on 71 features, including 3-mer frequencies, sequence-based characteristics, and protein homology search results. 

You should use this skill when you need to:
1. Annotate novel lncRNAs from RNA-seq assemblies or transcriptomes.
2. Filter out non-coding sequences from a set of predicted transcripts.
3. Build custom species-specific machine learning models for RNA classification.
4. Extract specific sequence subsets (mRNA or lncRNA) from prediction outputs.

## Command Line Usage

### Predicting lncRNAs
The `predict` command is the primary workflow for classifying unknown sequences.

```bash
plncpro predict -i <input.fasta> -o <output_dir> -p <output_prefix> -m <model_file> -d <blast_db> -t <threads>
```

**Key Arguments:**
- `-i, --infile`: The FASTA file containing the transcripts to be classified.
- `-m, --model`: The pre-trained model file (e.g., plant-specific models provided by PLncPRO).
- `-d, --db`: Path to the BLAST database (e.g., UniRef or Swiss-Prot) used for homology features.
- `-o, --outdir`: Directory where results and intermediate files will be stored.
- `-t, --threads`: Number of CPU cores to use (default is 4).

### Building Custom Models
If the provided models are not suitable for your specific organism, use the `build` command to train a new one.

```bash
plncpro build -p <mrna.fasta> -n <lncrna.fasta> -o <out_dir> -m <model_name> -d <blast_db>
```

**Key Arguments:**
- `-p, --pos`: FASTA file containing known coding sequences (mRNAs).
- `-n, --neg`: FASTA file containing known non-coding sequences (lncRNAs).
- `-k, --num_trees`: Number of trees in the Random Forest (default: 1000).

### Extracting Sequences
After prediction, use `predtoseq` to isolate specific classes of RNA.

```bash
plncpro predtoseq -i <prediction_output> -s <original_fasta> -c <class_label> -o <output_fasta>
```

## Expert Tips and Best Practices

- **BLAST Requirement**: For maximum accuracy, always provide a BLAST database. If you must run without it (e.g., for speed or lack of resources), use the `--noblast` flag, but be aware that prediction performance may decrease.
- **Pre-computed BLAST**: If you have already run BLAST, you can provide the results directly using `--blastres` to save time. The BLAST output must strictly follow this format:
  `-outfmt '6 qseqid sseqid pident evalue qcovs qcovhsp score bitscore qframe sframe'`
- **Sequence Length**: By default, lncRNAs are defined as being at least 200 bp. Use the `--min_len` parameter to filter out shorter sequences before processing.
- **Memory Management**: For very large transcriptomes, use the `-r` or `--remove_temp` flag to clean up intermediate files and save disk space.
- **Framefinder**: PLncPRO uses Framefinder for ORF prediction. If you encounter issues with this dependency, you can disable it using `--no_ff`, though this is generally not recommended for final annotations.



## Subcommands

| Command | Description |
|---------|-------------|
| plncpro_build | This script generates classification model from codin and non coding transcripts |
| plncpro_predict | This script classifies transcripts as coding or non coding transcripts |
| predstoseq.py | Use this to extract lncRNA or mRNA sequences, as predicted by PLNCPRO, from the input fasta file |

## Reference documentation
- [PLncPRO GitHub README](./references/github_com_urmi-21_PLncPRO_blob_master_README.md)
- [PLncPRO Web Documentation](./references/ccbb_jnu_ac_in_plncpro.md)