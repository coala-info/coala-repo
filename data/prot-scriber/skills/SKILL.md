---
name: prot-scriber
description: prot-scriber generates consensus functional annotations for proteins by performing lexical analysis on sequence similarity search results. Use when user asks to annotate individual proteins, assign descriptions to gene families, or generate human-readable descriptions from Blast or Diamond hits.
homepage: https://github.com/usadellab/prot-scriber
---


# prot-scriber

## Overview
`prot-scriber` automates the process of functional annotation by extracting and scoring informative phrases from sequence similarity search results. It moves beyond simple "best-hit" annotation by performing lexical analysis on hit descriptions (stitle) to generate a consensus Human Readable Description (HRD). Use this tool to annotate individual proteins or entire gene families, especially when working with non-model organisms where reference hits may be inconsistent, redundant, or overly verbose.

## Usage Patterns

### 1. Prepare Input Data
Before using `prot-scriber`, perform a sequence similarity search (Blastp or Diamond) against reference databases like UniProt Swissprot or trEMBL.
- **Blast Command**: Ensure `-outfmt` includes `qacc`, `sacc`, and `stitle`.
  `blastp -db uniprot_sprot.fasta -query my_prots.fasta -outfmt "6 qacc sacc stitle" -out results_sprot.txt`
- **Diamond Command**: Use format `6` with `qseqid`, `sseqid`, and `stitle`.
  `diamond blastp -d uniprot_sprot.dmnd -q my_prots.fasta -f 6 qseqid sseqid stitle -o results_sprot.txt`

### 2. Annotate Individual Sequences
Combine results from multiple databases to improve annotation quality. The tool will prioritize informative terms found across different hits.
`prot-scriber -s results_sprot.txt -s results_trembl.txt -o protein_annotations.txt`

### 3. Annotate Gene Families
To assign a single description to a group of related sequences (gene family):
1. Create a `families.txt` file mapping family IDs to protein IDs (one mapping per line, tab-separated).
2. Run `prot-scriber` using the `-f` flag to provide the family definitions.
`prot-scriber -f families.txt -s results_sprot.txt -o family_annotations.txt`

## Best Practices and Expert Tips
- **Database Selection**: Always include a high-quality curated database (like Swissprot) alongside larger, uncurated databases (like trEMBL). `prot-scriber` excels at finding the most informative phrase common to these sources.
- **Tab Delimiters**: Ensure input files are strictly tab-delimited. When running Blast, ensure the output format string uses actual tab characters.
- **Lexical Filtering**: The tool automatically handles the removal of species names and uninformative headers (e.g., "LOW QUALITY PROTEIN" or "Blast:"). You do not need to pre-process the `stitle` field.
- **Scoring Logic**: If multiple phrases have the same information score, `prot-scriber` selects the longest one to ensure maximum descriptive context.
- **Installation**: For the most stable environment, install via Bioconda: `conda install bioconda::prot-scriber`.

## Reference documentation
- [Main Repository and Usage](./references/github_com_usadellab_prot-scriber.md)
- [Terminology and Algorithm Details](./references/github_com_usadellab_prot-scriber_wiki.md)