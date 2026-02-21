---
name: ucsc-blat
description: BLAT (Blast-Like Alignment Tool) is designed for rapid searching and alignment of DNA or protein sequences.
homepage: http://hgdownload.cse.ucsc.edu/admin/exe/
---

# ucsc-blat

## Overview
BLAT (Blast-Like Alignment Tool) is designed for rapid searching and alignment of DNA or protein sequences. Unlike BLAST, which builds an index of the query, BLAT maintains an index of the entire target genome in memory, making it significantly faster for finding highly similar sequences. It is particularly effective for mapping mRNA/ESTs to genomic DNA because it is splice-aware, and for identifying homologous regions across species. It is best suited for sequences with high identity (typically 95% or greater for DNA and 80% or greater for proteins).

## Common CLI Patterns

### Basic DNA Alignment
Align a query file against a reference genome.
```bash
blat reference.2bit query.fa output.psl
```

### Protein/Translated Searches
BLAT supports several types of translated alignments:
- **Protein to Protein**: `blat protein_ref.fa protein_query.fa -prot output.psl`
- **Translated DNA to Protein**: `blat protein_ref.fa dna_query.fa -t=dnax -q=prot output.psl`
- **Translated DNA to Translated DNA**: `blat dna_ref.fa dna_query.fa -t=dnax -q=dnax output.psl`

### Working with 2bit Files
For large genomes (like Human or Mouse), use `.2bit` files instead of FASTA to save memory and improve speed.
```bash
# Create a 2bit file from FASTA
faToTwoBit genome.fa genome.2bit

# Align using the 2bit file
blat genome.2bit query.fa output.psl
```

### Common Output Formats
Use the `-out` flag to specify formats other than the default PSL:
- **Blast8 (Tab-separated)**: `-out=blast8` (Compatible with many downstream tools)
- **Blast (Human-readable)**: `-out=blast`
- **Axt**: `-out=axt` (Common for genomic alignments)

## Expert Tips and Best Practices

### Handling Introns and Splice Sites
When aligning mRNA to genomic DNA, BLAT is splice-aware by default. To fine-tune this:
- Use `-fine` for high-quality mRNA/EST alignments to search for small initial and terminal exons.
- Use `-maxIntron=N` to set the maximum allowed intron size (default is 750,000).

### Sensitivity vs. Speed
- **Step Size**: The `-stepSize` parameter determines how far the "tile" (k-mer) slides. Default is `tileSize`. Reducing `stepSize` increases sensitivity but slows down the search.
- **Tile Size**: Default is 11 for DNA. Increasing `-tileSize` (up to 18) speeds up the search but reduces sensitivity.
- **Min Score**: Use `-minScore=N` to filter out low-quality matches early (default is 30).

### Memory Management
BLAT loads the entire index into RAM. For the human genome, this requires approximately 3GB of memory. If you are running multiple queries against the same genome, consider using `gfServer` and `gfClient` to keep the genome in memory once and query it repeatedly.

### Filtering Results
The default PSL output contains many columns. To extract the most relevant information (like identity and coverage), use the `pslScore` or `pslCDnaFilter` utilities often bundled with the UCSC Kent tools.

## Reference documentation
- [UCSC Admin Exe Overview](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Linux x86_64 Binary List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)
- [Bioconda ucsc-blat Package](./references/anaconda_org_channels_bioconda_packages_ucsc-blat_overview.md)