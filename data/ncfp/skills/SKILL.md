---
name: ncfp
description: The ncfp tool automates the retrieval of nucleotide coding sequences from NCBI based on a provided set of protein sequences. Use when user asks to recover DNA sequences for specific proteins, download CDS from NCBI accessions, or synchronize protein and nucleotide datasets for phylogenetic analysis.
homepage: http://widdowquinn.github.io/ncfp/
---


# ncfp

## Overview
The `ncfp` (NCBI CDS From Protein) tool automates the recovery of DNA sequences that encode specific proteins. By providing a FASTA file of amino acid sequences, the tool uses NCBI accessions or UniProt gene names to locate, download, and format the matching nucleotide sequences. This eliminates the manual effort of searching NCBI databases for individual gene sequences corresponding to a large protein dataset.

## Command Line Usage

The basic syntax for `ncfp` requires an input file, an output directory, and a valid email address (required by NCBI for Entrez queries).

```bash
ncfp <INPUT_FASTA> <OUTPUT_DIR> <EMAIL_ADDRESS>
```

### Input Requirements
- **Format**: Standard FASTA file containing protein sequences.
- **Headers**: Sequence headers should contain valid NCBI accessions (e.g., NP_XXXXXX.X) or UniProt gene names to ensure successful retrieval.

### Output Files
The tool generates three primary files in the specified output directory:
- `ncfp_aa.fasta`: The protein sequences for which nucleotide matches were successfully found.
- `ncfp_nt.fasta`: The corresponding nucleotide coding sequences (CDS).
- `skipped.fas`: Any input protein sequences where a matching nucleotide sequence could not be recovered.

## Best Practices and Tips

- **NCBI Rate Limiting**: Always provide a real email address. This allows NCBI to contact you if your requests are causing issues and helps avoid IP blocks during large batch downloads.
- **Data Integrity**: Use the `ncfp_aa.fasta` file for your downstream alignments rather than your original input file. This ensures that your protein and nucleotide files are perfectly synchronized (containing the same number of sequences in the same order).
- **Phylogenetics Workflow**: A common expert workflow involves:
    1. Aligning the protein sequences (e.g., using MAFFT).
    2. Using `ncfp` to get the CDS.
    3. Using a tool like `pal2nal` to thread the `ncfp_nt.fasta` sequences onto the protein alignment.
- **Troubleshooting Skips**: If many sequences end up in `skipped.fas`, verify that the FASTA headers in your input file haven't been truncated or modified by other software, as `ncfp` relies on precise accession strings.

## Reference documentation
- [ncfp Project Homepage](./references/widdowquinn_github_io_ncfp.md)
- [Bioconda ncfp Package Overview](./references/anaconda_org_channels_bioconda_packages_ncfp_overview.md)