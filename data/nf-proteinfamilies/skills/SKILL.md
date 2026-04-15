---
name: proteinfamilies
description: This pipeline generates protein families from amino acid FASTA sequences or updates existing families using provided HMM and MSA tarballs, delivering multiple sequence alignments, Hidden Markov Models, and optional phylogenetic trees. Use when clustering novel sequences into families, refining existing protein family models with new sequence data, or generating input samplesheets for downstream structural prediction and annotation workflows.
homepage: https://github.com/nf-core/proteinfamilies
---

# proteinfamilies

## Overview
nf-core/proteinfamilies is designed to organize protein sequences into functional groups by generating or updating protein family models. It handles the transition from raw amino acid sequences to high-quality Multiple Sequence Alignments (MSAs) and Hidden Markov Models (HMMs), which are essential for homology searching and functional characterization.

The pipeline supports both the creation of entirely new families via clustering and the "fishing" of new sequences into existing families to update their models. It includes optional steps for MSA trimming, redundancy removal, and phylogenetic inference to ensure the resulting models are robust and representative of the input protein diversity.

## Data preparation
The pipeline requires a CSV samplesheet specified with the `--input` parameter. Amino acid sequences must be in FASTA format (can be gzipped). If updating existing families, you must provide tarball archives containing the HMM and MSA files, ensuring that filenames match one-to-one between the two archives.

**Samplesheet columns:**
- `sample`: Unique identifier for the sample.
- `fasta`: Path to the amino acid FASTA file (`.fa`, `.fasta`, `.faa`, `.fas`, or `.gz`).
- `existing_hmms_to_update`: Optional path to a `.tar.gz` file containing existing HMMs.
- `existing_msas_to_update`: Optional path to a `.tar.gz` file containing existing MSAs.

**Example `samplesheet.csv`:**
```csv
sample,fasta,existing_hmms_to_update,existing_msas_to_update
CONTROL_REP1,input/sequences.faa,,
UPDATE_RUN,input/new_data.faa,old_hmms.tar.gz,old_msas.tar.gz
```

## How to run
The pipeline is executed using Nextflow. It is recommended to use a specific version with `-r` and a container profile for reproducibility.

```bash
nextflow run nf-core/proteinfamilies \
    -profile <docker/singularity/conda> \
    --input samplesheet.csv \
    --outdir ./results \
    -r 1.0.0
```

Key parameters include:
- `--alignment_tool`: Choose between `famsa` (default) or `mafft`.
- `--clustering_tool`: Choose `cluster` for medium datasets or `linclust` for larger datasets.
- `--skip_phylogenetic_inference`: Set to `false` to generate trees (default is `true`).
- `-resume`: Use this to restart a run from the last successful step.

## Outputs
Results are saved in the directory specified by `--outdir`.

- `multiqc/`: Contains the MultiQC report, which should be the first file inspected for sequence statistics and family size distributions.
- `hmm/`: The final Hidden Markov Models for each protein family.
- `msa/`: Multiple sequence alignments in various formats (e.g., `.fas`, `.sto`).
- `phylogeny/`: Maximum parsimonious likelihood trees (if enabled).
- `samplesheets/`: Automatically generated samplesheets for downstream use in `nf-core/proteinfold` or `nf-core/proteinannotator`.

For more details about the output files and reports, please refer to the [official output documentation](https://nf-co.re/proteinfamilies/output).

## References

Local copies of pipeline documentation used to generate this skill (paths relative to this skill folder):

- [`references/README.md`](references/README.md)
- [`references/nextflow_schema.json`](references/nextflow_schema.json)
- [`references/assets/schema_input.json`](references/assets/schema_input.json)
- [`references/docs/README.md`](references/docs/README.md)
- [`references/docs/output.md`](references/docs/output.md)
- [`references/docs/usage.md`](references/docs/usage.md)