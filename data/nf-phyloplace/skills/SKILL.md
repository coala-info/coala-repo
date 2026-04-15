---
name: phyloplace
description: This pipeline performs phylogenetic placement of query sequences onto a reference phylogeny using EPA-NG, supporting inputs such as FASTA files, HMM profiles, and Newick trees with alignment methods like HMMER, Clustal Omega, or MAFFT. Use when you need to assign unknown sequences to an existing evolutionary tree or classify them based on reference taxonomy without performing full de novo tree reconstruction.
homepage: https://github.com/nf-core/phyloplace
---

# phyloplace

## Overview
nf-core/phyloplace is a bioinformatics pipeline designed for the efficient placement of sequence reads into a fixed reference phylogenetic tree. It solves the problem of integrating new sequence data into large, established phylogenies by using EPA-NG for placement and GAPPA for downstream processing such as tree grafting and taxonomic classification.

The pipeline accepts query sequences in FASTA format and requires a reference package consisting of an alignment, a Newick tree, and a specified evolutionary model. It produces JPLACE files containing placement information, updated Newick trees with query sequences grafted onto the reference, and optional taxonomic assignments if a reference taxonomy is provided.

## Data preparation
The pipeline supports two primary input modes defined via CSV samplesheets.

**Direct Placement (`--phyloplace_input`)**
Use this CSV when you have specific query sequences to place. The file must contain:
- `sample`: Unique sample identifier.
- `queryseqfile`: FASTA file with query sequences.
- `refseqfile`: File with reference sequences.
- `refphylogeny`: Newick file with the reference tree.
- `model`: Evolutionary model to use (e.g., `LG`, `GTR`).

**Search and Place (`--phylosearch_input`)**
Use this CSV to first search a large FASTA file (`--search_fasta`) using HMM profiles before placement. The file must contain:
- `target`: Identifier for the search target.
- `hmm`: HMM profile for the search.
- `refseqfile`, `refphylogeny`, `model`: Reference data as described above.

**Optional Taxonomy**
If providing a taxonomy file via `--taxonomy`, it should be a TSV with two columns:
1. Reference sequence name.
2. Taxonomy string (e.g., `Bacteria;Proteobacteria;...`).

## How to run
Run the pipeline using the direct placement input:
```bash
nextflow run nf-core/phyloplace \
   -profile <docker/singularity/conda> \
   --phyloplace_input samplesheet.csv \
   --outdir ./results
```

Run the pipeline using the HMM search mode:
```bash
nextflow run nf-core/phyloplace \
   -profile <docker/singularity/conda> \
   --phylosearch_input search_params.csv \
   --search_fasta sequences.faa \
   --outdir ./results
```

Key parameters:
- `-r`: Specify a pipeline version (e.g., `-r 1.0.0`).
- `-resume`: Restart a pipeline from the last cached step.
- `--alignmethod`: Choose between `hmmer` (default), `clustalo`, or `mafft`.

## Outputs
Results are saved in the directory specified by `--outdir`.
- `epa-ng/`: Contains `.jplace` files with the phylogenetic placement results.
- `gappa/`: Contains grafted Newick trees and taxonomic classification reports (if `--taxonomy` was provided).
- `multiqc/`: Summary reports of the pipeline run and tool statistics.

For a complete description of output files, refer to the [official output documentation](https://nf-co.re/phyloplace/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)