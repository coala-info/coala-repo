# irma CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| irma_IRMA | PASS |  |
| irma_LABEL | Failed | image problem: hmmscore segfaults as a non-root user without a passwd entry (works only with cwltool --no-match-user) |

## irma_IRMA

### Tool Description
Iterative Refinement Meta-Assembler (IRMA)

### Metadata
- **Docker Image**: quay.io/biocontainers/irma:1.2.0--pl5321hdfd78af_0
- **Homepage**: https://wonder.cdc.gov/amd/flu/irma/
- **Package**: https://anaconda.org/channels/bioconda/packages/irma/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/irma/overview
- **Total Downloads**: 5.6K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Iterative Refinement Meta-Assembler (IRMA), v1.2.0 (23 Aug 2024)
Samuel S. Shepard (CDC/DDID/NCIRD/ID), vfn4@cdc.gov

GPL version 3. This program comes with ABSOLUTELY NO WARRANTY. This is free software.
You are welcome to redistribute it under certain conditions. See:  <http://www.gnu.org/licenses/>.
Components of this pipeline have non-commercial restrictions. See: IRMA_RES/scripts/packaged-citations-licenses

Usage:
(PAIRED-END):	IRMA <MODULE|MODULE-CONFIG> <R1.fastq.gz|R1.fastq> <R2.fastq.gz|R2.fastq> [path/to/]<sample_name> [options]
(SINGLE-END):	IRMA <MODULE|MODULE-CONFIG> <fastq|fastq.gz> [path/to/]<sample_name> [options]

Options:
	--external-config|-c <VALID_CONFIG_PATH>
```

## irma_LABEL

### Tool Description
Classify nucleotide sequences of influenza and other viruses into clades or subtypes with the LABEL hidden Markov model classifier.

### Metadata
- **Docker Image**: quay.io/biocontainers/irma:1.2.0--pl5321hdfd78af_0
- **Homepage**: https://wonder.cdc.gov/amd/flu/irma/
- **Package**: https://anaconda.org/channels/bioconda/packages/irma/overview
- **Validation**: PASS

### Original Help Text
```text
[help] LABEL: ok via LABEL -h (--help=ok, -h=ok, -help=ok, (no args)=ok)
LABEL v0.6.5, updated 2024
Samuel S. Shepard (vfn4@cdc.gov), Centers for Disease Control & Prevention
GPL version 3. This program comes with ABSOLUTELY NO WARRANTY. This is free software.
You are welcome to redistribute it under certain conditions. See:  <http://www.gnu.org/licenses/>.


Usage:
	LABEL [-P MAX_PROC] [-E C_OPT] [-W WRK_PATH|-O OUT_PATH] [-G|-TACRD|-S] [-L LIN_PATH] <nts.fasta> <project> <Module:H5,H9,etc.>
		-T	Do TRAINING again instead of using classifier files.
		-A	Do ALIGNMENT of re-annotated fasta file (sorted by clade) & build its ML tree.
		-C	Do CONTROL alignment & ML tree construction.
		-E	SGE clustering option. Use 1 or 2 for SGE with array jobs, else local.
		-R	No RECURSIVE prediction. Limits scope, useful with -L option.
		-D	No DELETION of extra intermediary files.
		-S	Show available protein modules.
		-W	Web-server mode: requires ABSOLUTE path to WRITABLE working directory.
		-O	Output directory path, do not use with web mode.
Example: /usr/local/bin/LABEL -C gisaid_H5N1.fa Bird_Flu H5
```
