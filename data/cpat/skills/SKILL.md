---
name: cpat
description: CPAT is a bioinformatics tool designed to evaluate the coding probability of RNA transcripts.
homepage: https://cpat.readthedocs.io/en/latest/
---

# cpat

## Overview
CPAT is a bioinformatics tool designed to evaluate the coding probability of RNA transcripts. It utilizes a logistic regression model built on four primary sequence features: ORF size, ORF coverage, Fickett TESTCODE score, and Hexamer usage bias. This skill provides the necessary command-line patterns to run predictions using pre-built models or to generate custom species-specific models.

## Core Workflows

### Running Coding Potential Prediction
The primary command is `cpat`. You must provide a gene file, a logit model, and a hexamer frequency table.

```bash
# Basic prediction using FASTA input
cpat -g input.fasta \
     -d Human_logitModel.RData \
     -x Human_Hexamer.tsv \
     -o output_prefix

# Prediction using BED input (requires reference genome)
cpat -g input.bed \
     -r hg19.fa \
     -d Human_logitModel.RData \
     -x Human_Hexamer.tsv \
     -o output_prefix
```

### Advanced ORF Configuration
By default, CPAT searches the sense strand and uses standard start/stop codons. You can customize the search parameters for specific biological contexts:

- **Antisense Search**: Use `--antisense` to search for ORFs on the reverse complement strand.
- **Custom Codons**: Use `--start=ATG,GTG` or `--stop=TAG,TAA,TGA`.
- **Filtering**: Set `--min-orf=100` to ignore small putative peptides or `--top-orf=10` to increase the number of candidates evaluated per transcript.
- **Selection Logic**: Use `--best-orf=p` to select the "best" ORF based on coding probability (default) or `--best-orf=l` to select based on length.

### Building Custom Species Models
If working with a species other than Human, Mouse, Fly, or Zebrafish, you must generate a species-specific hexamer table and logit model.

1.  **Generate Hexamer Table**:
    Requires a known coding (CDS only, no UTRs) FASTA and a known non-coding FASTA.
    ```bash
    make_hexamer_tab -c coding_cds.fa -n noncoding_rna.fa > species_Hexamer.tsv
    ```

2.  **Generate Logit Model**:
    Use the `make_logitModel` command (refer to documentation for specific R-dependency requirements) to build the `.RData` file needed for the main `cpat` command.

## Output Files
CPAT generates several files based on the `-o` prefix:
- `.ORF_prob.tsv`: Comprehensive list of all ORF candidates and their scores.
- `.ORF_prob.best.tsv`: The single best ORF per transcript.
- `.ORF_seqs.fa`: FASTA sequences of the predicted ORFs.
- `.no_ORF.txt`: List of IDs where no ORF met the minimum length requirement (likely non-coding).

## Expert Tips
- **Sequence IDs**: Ensure FASTA headers are short and unique. Long headers can sometimes cause issues in the tabular output formatting.
- **Remote Files**: CPAT supports HTTP, HTTPS, and FTP URLs for the `-g` argument, allowing you to stream data directly from public repositories.
- **Cutoff Selection**: Coding probability is a continuous score from 0 to 1. While 0.5 is a common threshold, refer to the performance curves in the documentation to choose a species-specific cutoff that balances sensitivity and specificity.

## Reference documentation
- [CPAT ReadTheDocs Documentation](./references/cpat_readthedocs_io_en_latest.md)
- [Bioconda CPAT Package Overview](./references/anaconda_org_channels_bioconda_packages_cpat_overview.md)