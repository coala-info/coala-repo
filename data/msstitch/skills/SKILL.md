---
name: msstitch
description: msstitch is a specialized toolkit for proteomics bioinformatics that streamlines the transition from raw search engine outputs to analysis-ready result files.
homepage: https://github.com/lehtiolab/msstitch
---

# msstitch

## Overview
msstitch is a specialized toolkit for proteomics bioinformatics that streamlines the transition from raw search engine outputs to analysis-ready result files. It functions by centralizing data into an SQLite-based lookup system, enabling the alignment of MS2 spectra with MS1 precursor quantification and isobaric labeling data. Use this skill to automate decoy database generation, integrate Percolator FDR filtering, and perform median-sweeping or log-normalization on peptide-level quantification.

## Core Workflows and CLI Patterns

### 1. Building the SQLite Lookup
The foundation of an msstitch workflow is the SQLite database which stores spectra and quantification metadata.

**Store Spectra:**
Initialize or update a database with mzML files.
```bash
msstitch storespectra --spectra file1.mzML file2.mzML --setnames sample1 sample2 -o lookup.sqlite
```

**Store Quantification:**
Align MS1 features (Dinosaur/Kronik) and isobaric data (OpenMS consensusXML) to the spectra in the database.
```bash
msstitch storequant --dbfile lookup.sqlite --spectra file1.mzML --mztol 10 --mztoltype ppm --rttol 10 --dinosaur file1.dinosaur --isobaric file1.consensusXML
```
*   **Tip:** Use `--apex` instead of the default peak sum if you prefer envelope apex quantification.

### 2. Database and Search Engine Preparation
**Generate Decoys:**
Create a decoy FASTA where peptides are reversed between tryptic residues.
```bash
msstitch makedecoy uniprot.fasta -o decoy.fasta --scramble tryp_rev --maxshuffle 10
```
*   **Best Practice:** Use `--ignore-target-hits` to speed up the process if you do not need to strictly ensure no overlap with the target database.

### 3. PSM Table Refinement
Integrate Percolator results and filter by False Discovery Rate (FDR).

**For MSGF+:**
Requires the PSM table, Percolator XML, and the original mzIdentML.
```bash
msstitch perco2psm -i psms.txt --perco percolator.xml --mzid psms.mzIdentML --filtpsm 0.01 --filtpep 0.01
```

**For Sage:**
mzIdentML is not required.
```bash
msstitch perco2psm -i psms.sage.txt -o psms.perco.txt --perco percolator.xml --filtpsm 0.01
```

**Annotate PSM Tables:**
Add protein groups, gene names, and quantification from the SQLite lookup to the filtered PSM table.
```bash
msstitch psmtable -i target.tsv -o refined_psms.txt --fasta uniprot.fasta --dbfile lookup.sqlite --addmiscleav --addbioset --ms1quant --isobaric --min-precursor-purity 0.3 --proteingroup --genes
```

### 4. Summarizing to Peptide Tables
Aggregate PSM data into peptide-level summaries with optional normalization.

**Standard Aggregation:**
```bash
msstitch peptides -i refined_psms.txt -o peptides.txt --scorecolpattern svm --modelqvals --ms1quant --isobquantcolpattern tmt10plex --denompatterns _126
```

**Normalization (Median Sweeping):**
Use median sweeping and log2 transformation for robust TMT/isobaric quantification.
```bash
msstitch peptides -i refined_psms.txt -o normalized_peptides.txt --isobquantcolpattern tmt10plex --mediansweep --logisoquant --median-normalize
```

## Expert Tips
*   **Memory Management:** For large datasets, ensure the SQLite database is stored on a fast SSD, as msstitch relies heavily on disk I/O for lookups.
*   **Sage vs. MSGF+:** When using Sage, do not use `--addmiscleav` in the `psmtable` command, as Sage includes missed cleavage counts in its native output.
*   **Column Detection:** msstitch attempts to autodetect spectra filenames for MSGF and Sage; if it fails, explicitly provide the column name using the appropriate flag.
*   **PTM Analysis:** If analyzing post-translational modifications, create a separate peptide table by filtering PSMs for the specific modification before running the `peptides` command.

## Reference documentation
- [msstitch GitHub Repository](./references/github_com_lehtiolab_msstitch.md)
- [msstitch Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_msstitch_overview.md)