---
name: tirmite
description: "tirmite models natural variation in transposon termini to identify and annotate cryptic structural variants like MITEs. Use when user asks to generate profile HMMs for terminal sequences, search genomes for transposon hits, or pair termini to define element boundaries."
homepage: https://github.com/Adamtaranto/TIRmite
---

# tirmite

## Overview

tirmite is a bioinformatics pipeline designed to model natural variation in transposon termini to identify cryptic structural variants. It is particularly effective for annotating non-autonomous elements—such as MITEs—which may lack functional transposition machinery but retain conserved boundary features. The tool works by building profile HMMs of terminal sequences and using an iterative pairing algorithm to define element boundaries across a genome, even when internal sequences are highly variable or captured from other sources.

## Core Workflow

### 1. Generating a Seed Model
Before searching a genome, you must create a profile HMM (pHMM) from a known or draft terminal sequence.

```bash
tirmite seed --left-seed seed_sequence.fasta \
             --model-name MY_ELEMENT \
             --genome target_genome.fasta \
             --outdir output_dir \
             --threads 8
```

*   **Expert Tip**: Set `--flank-size 10` during seeding. If you see high conservation in the flanking bases across multiple hits, your initial seed sequence was likely truncated and should be adjusted.

### 2. Searching the Genome
tirmite typically uses `nhmmer` (from the HMMER3 suite) to locate hits for the pHMM.

```bash
nhmmer --dna --cpu 8 --tblout hits.tab output_dir/MY_ELEMENT.hmm target_genome.fasta
```

*   **Alternative**: For very large genomes where `nhmmer` is too slow, use `blastn` with `-outfmt 6` and provide the results to the pairing command using `--blastFile`.

### 3. Pairing Termini
The final step identifies valid pairs of terminal hits to annotate complete or partial elements.

```bash
tirmite pair --genome target_genome.fasta \
             --nhmmerFile hits.tab \
             --hmmFile output_dir/MY_ELEMENT.hmm \
             --orientation F,R \
             --mincov 0.4 \
             --maxdist 20000 \
             --gffOut \
             --outdir final_annotations
```

## Common CLI Patterns & Parameters

| Parameter | Usage |
| :--- | :--- |
| `--orientation` | Use `F,R` for Terminal Inverted Repeats (TIRs) and `F,F` for Long Terminal Repeats (LTRs). |
| `--maxdist` | Maximum distance (bp) between paired termini. Default is often 20kb; adjust based on expected TE size. |
| `--mincov` | Minimum coverage of the HMM model required for a hit to be considered (0.0 to 1.0). |
| `--pairin` | Required when processing multiple HMM models simultaneously to map which termini belong together. |
| `--stableReps` | Used in iterative updates to define how many rounds a model must remain stable before stopping. |

## Best Practices

*   **Terminal Extraction**: If starting from a full TE model (e.g., from RepeatModeler), use the companion tool `tsplit` to isolate the TIRs or LTRs before running `tirmite seed`.
*   **Handling Asymmetry**: For elements with different conserved features at either end (like Helitrons or Starships), provide both `--left-seed` and `--right-seed` to the `seed` command.
*   **Output Formats**: Always use `--gffOut` to generate a standard genomic annotation file (GFF3) compatible with genome browsers like JBrowse or IGV.
*   **Database Extraction**: If using BLAST, create your database with `makeblastdb -parse_seqids`. This allows `tirmite pair` to extract sequences directly from the BLAST database using `--blastdb` instead of re-parsing the entire FASTA file.



## Subcommands

| Command | Description |
|---------|-------------|
| tirmite legacy | Map HMM models of transposon termini to genomic sequences |
| tirmite_pair | Pair precomputed nhmmer hits for transposon detection |
| tirmite_seed | Build HMM models from seed sequences for TIRmite |

## Reference documentation
- [TIRmite Main Documentation](./references/github_com_Adamtaranto_TIRmite.md)
- [TIRmite Wiki and Tutorials](./references/github_com_Adamtaranto_TIRmite_wiki.md)