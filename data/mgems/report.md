# mgems CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| mgems_bin | PASS | synthetic data: same mixed reads and mSWEEP 2.2.1 probabilities; wrote per-group .bin files and assignment table; new CWL |
| mgems_extract | PASS | synthetic data: extracted Bacteroides and Portiera reads from the .bin files; identical to the full mGEMS run; new CWL |
| mgems_mGEMS | PASS | synthetic data: real B. fragilis and Portiera reads with real genomes plus planted SNP strains; bins hold the right reads (Portiera bin 9545 of its reads, Bacteroides bin 5163 of its reads); fixed -o/-a flags, comma lists and output folder |

## mgems_mGEMS

### Tool Description
mGEMS is a tool for extracting sequencing reads belonging to specific taxonomic groups from metagenomic datasets using pseudoalignments and posterior probabilities.

### Metadata
- **Docker Image**: quay.io/biocontainers/mgems:1.3.3--h13024bc_2
- **Homepage**: https://github.com/PROBIC/mGEMS
- **Package**: https://anaconda.org/channels/bioconda/packages/mgems/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mgems/overview
- **Total Downloads**: 4.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/PROBIC/mGEMS
- **Stars**: N/A
### Original Help Text
```text
Usage: mGEMS -r <input-reads_1>,<input-reads_2> -i <group-indicators> --themisto-alns <input-reads_1 pseudoalignments>,<input-reads_2 pseudoalignments> -o <output directory> --probs <posterior probabilities> -a <abundance estimates> --index <Themisto index> --groups <group names to extract (optional)>
```

## mgems_bin

### Tool Description
Bin pseudoaligned reads into groups using mSWEEP posterior probabilities (mGEMS bin).

### Metadata
- **Docker Image**: quay.io/biocontainers/mgems:1.3.3--h13024bc_2
- **Homepage**: https://github.com/PROBIC/mGEMS
- **Package**: https://anaconda.org/channels/bioconda/packages/mgems/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mGEMS bin --themisto-alns <aln_1>,<aln_2> -a <abundances> -i <group-indicators> -o <output directory> --probs <probs> --index <Themisto index> [--groups ...] [-t <threads>] [-q <tuning>] [--merge-mode <mode>] [--min-abundance <x>] [--write-unassigned] [--write-assignment-table] [--unique-only] [--compress]

(options of mGEMS bin, from the mGEMS source and README; the program prints no option list)
	-i                       Group identifiers file used with the mSWEEP call.
	--themisto-alns          Comma-separated list of pseudoalignment file(s) 
	                         for the reads from themisto.
	-o                       Output directory (must exist before running!).
	--probs                  Comma-separated Posterior probability matrix (output from mSWEEP with
	                         the --write-probs flag).
	-a                       Relative abundance estimates from mSWEEP (tab-separated, 1st
	                         column has the group names and 2nd column the estimates).
	--index                  Themisto pseudoalignment index directory.
	--groups                 (Optional) Which groups to extract from the input reads.
	--min-abundance          (Optional) Extract only groups that have a relative abundance higher than this value.
	--compress               (Optional) Toggle compressing the output files (default: compress)
	--write-unassigned       (Optional) Extract reads that pseudoaligned to a reference sequence but were not assigned to any group. (default: off)
	--write-assignment-table (Optional) Write the read to group assignments table to `reads_to_groups.tsv` in the output directory. (default: off).
	--unique-only            (Optional) Write only the reads that are assigned to a single group.
```

## mgems_extract

### Tool Description
Extract binned reads from the original mixed samples (mGEMS extract).

### Metadata
- **Docker Image**: quay.io/biocontainers/mgems:1.3.3--h13024bc_2
- **Homepage**: https://github.com/PROBIC/mGEMS
- **Package**: https://anaconda.org/channels/bioconda/packages/mgems/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mGEMS extract -r <input-reads_1>,<input-reads_2> --bins <bin1>,<bin2> -o <output directory> [--compress]

(options of mGEMS extract, from the mGEMS source and README)
```
