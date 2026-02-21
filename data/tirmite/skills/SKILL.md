---
name: tirmite
description: TIRmite is a specialized tool for the discovery and annotation of transposable elements that share conserved terminal sequences but may have highly variable internal regions.
homepage: https://github.com/Adamtaranto/TIRmite
---

# tirmite

## Overview
TIRmite is a specialized tool for the discovery and annotation of transposable elements that share conserved terminal sequences but may have highly variable internal regions. While standard tools like BLAST often miss degraded or non-autonomous variants (like MITEs), TIRmite uses profile HMMs to capture the natural variation in transposon boundaries. It is particularly effective for elements with symmetrical termini (TIRs/LTRs) or asymmetrical features (Helitrons/Starships), producing both sequence files and GFF3 genomic annotations.

## Core Workflow

### 1. Building a Seed Model
Before searching a genome, you must create a profile HMM from a known terminal sequence.

```bash
# Build a pHMM from a seed sequence
tirmite seed \
  --left-seed seed_sequence.fasta \
  --model-name MY_ELEMENT \
  --genome reference_genome.fasta \
  --outdir model_output \
  --threads 8
```
*   **Pro Tip**: Use `--flank-size 10` to include flanking bases. If these bases show high conservation across hits, your initial seed may be truncated and should be adjusted.

### 2. Searching the Genome
TIRmite relies on external search results. `nhmmer` (from HMMER3) is the default for HMM-based sensitivity, but BLAST+ can be used for speed on large genomes.

**Using nhmmer (Recommended):**
```bash
nhmmer --dna --cpu 8 --tblout hits.tab model_output/MY_ELEMENT.hmm reference_genome.fasta
```

**Using BLAST (Alternative):**
```bash
blastn -query seed_sequence.fasta -db genome_db -outfmt 6 -out hits.tab -evalue 0.001
```

### 3. Pairing Termini
The `pair` command identifies valid transposon candidates by finding pairs of hits that satisfy orientation and distance constraints.

```bash
tirmite pair \
  --genome reference_genome.fasta \
  --nhmmerFile hits.tab \
  --hmmFile model_output/MY_ELEMENT.hmm \
  --orientation F,R \
  --mincov 0.4 \
  --maxdist 20000 \
  --gffOut \
  --outdir pairing_results
```

## Common CLI Patterns

### Handling Multiple Models
If searching for multiple TE families simultaneously, use a pairing map to define which HMM hits should be paired together.
```bash
tirmite pair --genome ref.fa --nhmmerFile all_hits.tab --pairmap models.map --outdir multi_results
```

### Extracting from BLAST Databases
If you have a large genome and a pre-indexed BLAST database (created with `-parse_seqids`), you can extract sequences directly without the original FASTA:
```bash
tirmite pair --blastdb genome_db --blastFile hits.tab --queryLen 100 --orientation F,R --outdir results
```

## Best Practices
*   **Orientation**: For TIR-based elements, use `--orientation F,R`. For elements with different conserved features at each end (like Helitrons), ensure your HMMs or seeds are correctly labeled as left/right.
*   **Distance Constraints**: Adjust `--maxdist` based on the known biology of the target superfamily. Setting this too high increases false positives from unrelated insertions.
*   **Sensitivity**: If hits are fragmented, use `--stableReps` to control how many iterations of hit-merging the algorithm performs.
*   **Preprocessing**: Use `tSplit` (a companion tool) to extract clean terminal repeats from full-length TE models before starting the TIRmite workflow.

## Reference documentation
- [TIRmite GitHub Repository](./references/github_com_Adamtaranto_TIRmite.md)
- [TIRmite Wiki and Tutorials](./references/github_com_Adamtaranto_TIRmite_wiki.md)