---
name: msstitch
description: msstitch is a suite of command-line utilities for post-processing shotgun proteomics data and integrating identification and quantification results. Use when user asks to store spectra and quantification data in SQLite, refine PSM tables with metadata, create decoy databases, or summarize peptide-level data with normalization.
homepage: https://github.com/lehtiolab/msstitch
---


# msstitch

## Overview

msstitch is a specialized suite of command-line utilities designed for the post-processing of shotgun proteomics data. It acts as an integration layer that connects various identification and quantification tools to generate analysis-ready result files. By utilizing an SQLite backend to store spectra and quantification metadata, msstitch allows for complex operations like mapping MS1 precursor intensities to PSMs, calculating protein groups, and performing median-sweep normalization across isobaric multiplexes.

## Core Workflows and CLI Patterns

### 1. Data Storage and Lookup Initialization
Before refining PSM tables, you must store spectra and quantification data in an SQLite database to enable cross-referencing.

**Store mzML spectra:**
```bash
msstitch storespectra --spectra file1.mzML file2.mzML --setnames sample1 sample2 -o lookup.sqlite
```

**Store quantification (MS1 and Isobaric):**
Use `--dinosaur` or `--kronik` for MS1, and `--isobaric` (OpenMS consensusXML) for TMT/iTRAQ.
```bash
msstitch storequant --dbfile lookup.sqlite --spectra file1.mzML --mztol 10 --mztoltype ppm --rttol 10 --dinosaur file1.dinosaur --isobaric file1.consensusXML
```
*Tip: Use `--apex` if you prefer the envelope apex over the peak sum for MS1 quantification.*

### 2. Database and Search Engine Preparation
**Create a decoy database:**
Generates reversed peptides between tryptic residues.
```bash
msstitch makedecoy uniprot.fasta -o decoy.fasta --scramble tryp_rev --maxshuffle 10
```

**Integrate Percolator results into PSM tables:**
```bash
msstitch perco2psm -i psms.txt --perco percolator.xml --mzid psms.mzIdentML --filtpsm 0.01 --filtpep 0.01
```
*Note: If using Sage results, the `--mzid` parameter is not required.*

### 3. PSM Table Refinement
This step adds metadata (sample names, miscleavages, protein groups) and quantification values from the SQLite lookup to your PSM table.

```bash
msstitch psmtable -i target.tsv -o refined_psms.txt --fasta uniprot.fasta --dbfile lookup.sqlite --addmiscleav --addbioset --ms1quant --isobaric --proteingroup --genes
```
*   **Sage Users**: Omit `--addmiscleav` as Sage provides this natively.
*   **Purity Filtering**: Use `--min-precursor-purity 0.3` to exclude low-quality isobaric quantitation.

### 4. Peptide Table Summarization
Summarize PSM-level data into peptide-level tables with normalization.

**Standard Median Sweeping and Normalization:**
```bash
msstitch peptides -i refined_psms.txt -o peptides.txt --scorecolpattern svm --modelqvals --ms1quant --isobquantcolpattern tmt10plex --mediansweep --logisoquant --median-normalize
```

**Handling PTMs:**
If analyzing modified peptides, you can use `--medianintensity` to summarize specific subsets or use protein-level data to normalize PTM abundance.

## Expert Tips and Best Practices

*   **Memory Management**: For very large datasets, ensure you have sufficient disk space for the SQLite lookup file, as it acts as the central hub for all join operations.
*   **Column Patterns**: msstitch uses pattern matching for columns (e.g., `--isobquantcolpattern`). Ensure your input headers are consistent (e.g., containing "tmt10plex" or "set1").
*   **FDR Filtering**: Always perform `perco2psm` filtering before concatenating files to ensure consistent FDR thresholds across different runs.
*   **Target/Decoy Splitting**: Use `msstitch split -i allpsms.txt --splitcol TD` to separate target and decoy hits based on the designated column after concatenation.



## Subcommands

| Command | Description |
|---------|-------------|
| dedupperco | When running dedupperco also remove "duplicate" PSMs (by PSM ID plus sequence). Keeps first PSM encountered of each PSM ID / sequence combination |
| filterperco | Filter peptides based on their properties and a lookup database. |
| merge | Merge results from multiple msstitch runs. |
| msstitch conffilt | Applies confidence filtering to PSM data. |
| msstitch deduppsms | Deduplicate spectra based on peptide sequences. |
| msstitch ensg | Stitches together isobaric quantification data from PSMs and other sources. |
| msstitch perco2psm | Converts Percolator output to PSM table format. |
| msstitch proteins | Processes protein quantification data, including isobaric labeling and FDR calculation. |
| msstitch seqfilt | Filter sequences based on a database lookup. |
| msstitch split | Split an input file based on a specified column or identifier. |
| msstitch splitperco | Split peptides based on protein headers. |
| msstitch storeseq | Store sequence information |
| msstitch storespectra | Stores spectra from mzML files into a database. |
| msstitch trypsinize | Trypsinizes proteins in a file. |
| msstitch_concat | Concatenates multiple msstitch files. |
| msstitch_deletesets | Deletes sets from a multispecies stitch file. |
| msstitch_genes | Processes gene-related data, likely from mass spectrometry experiments, for quantification and analysis. |
| msstitch_isosummarize | Summarize isobaric quantification data. |
| msstitch_makedecoy | Create decoy sequences for MS/MS analysis. |
| msstitch_peptides | Stitches together peptide-level quantification data. |
| psmtable | Processes PSM tables with various options for analysis and output. |
| seqmatch | Performs sequence matching against a database. |
| storequant | Store quantitative data from various MS1 quantitation tools. |

## Reference documentation
- [msstitch GitHub Repository](./references/github_com_lehtiolab_msstitch.md)