---
name: codan
description: CodAn (Coding sequence Annotator) is a specialized tool for characterizing the structure of eukaryotic transcripts by predicting CDS and UTR regions.
homepage: https://github.com/pedronachtigall/CodAn
---

# codan

## Overview

CodAn (Coding sequence Annotator) is a specialized tool for characterizing the structure of eukaryotic transcripts by predicting CDS and UTR regions. It is particularly effective for researchers working with transcriptome assemblies who need to distinguish between coding and non-coding segments or identify open reading frames (ORFs). The tool relies on pre-trained models specific to taxonomic groups and the completeness of the input sequences (full-length vs. partial).

## Usage Patterns

### Basic CDS Prediction
The most common use case is predicting coding regions from a FASTA file of transcripts. You must specify the appropriate model path.

```bash
codan.py -t transcripts.fa -m /path/to/models/VERT_full -o output_folder
```

### Model Selection Guide
Choosing the correct model is critical for accuracy. Models are categorized by taxonomic group and transcript type:
- **Taxonomic Groups**: `VERT` (Vertebrates), `INV` (Invertebrates), `PLANTS`, `FUNGI`.
- **Transcript Type**: 
  - `_full`: Use for full-length transcripts (containing start and stop codons).
  - `_partial`: Use for fragmented transcripts or ESTs.

### Advanced Annotation with BLAST
To annotate predicted genes based on similarity to known proteins, provide a pre-formatted BLAST database.

```bash
codan.py -t transcripts.fa -m /path/to/model -b /path/to/blast_db/protein_db
```

### Performance Optimization
For large datasets, utilize multiple CPU cores to speed up the prediction process.

```bash
codan.py -t transcripts.fa -m /path/to/model -c 8
```

## Expert Tips

- **Model Acquisition**: If installed via Conda, the predictive models are often not included in the package. You must download them separately from the GitHub repository or the official download links and point to their directory using the `-m` flag.
- **Strand Specificity**: By default, CodAn checks both strands (`-s both`). If your library preparation was strand-specific, you can limit the search to `plus` or `minus` to reduce false positives and processing time.
- **macOS Compatibility**: If running on macOS, ensure you have the `tops-viterbi_decoding` binary compiled for macOS in your `bin` folder, as the standard Linux binary will not execute.
- **BLAST Integration**: When using the `-b` option, ensure your database was created using `makeblastdb`. You can adjust the High-scoring Segment Pair (HSP) threshold using `-H` (default is 80) to control the stringency of the similarity search.

## Reference documentation
- [CodAn GitHub Repository](./references/github_com_pedronachtigall_CodAn.md)
- [Bioconda CodAn Overview](./references/anaconda_org_channels_bioconda_packages_codan_overview.md)