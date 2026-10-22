# sshash CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| sshash_build | PASS | Rewrote CWL from help (-i, -k, -m, -o flags); built index of Salmonella unitigs and the built-in check printed EVERYTHING OK |
| sshash_permute | PASS | Rewrote CWL from help (-i, -k, -o); weighted Salmonella unitigs permuted to 651 sequences with fewer weight runs |
| sshash_query | PASS | New CWL for sshash query; the index answered FASTQ reads and a multi-line FASTA with 97 percent positive k-mers for the same species |

## sshash_build

### Tool Description
Build a shash index from a FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/sshash:5.0.0--haf24da9_0
- **Homepage**: https://github.com/jermp/sshash
- **Package**: https://anaconda.org/channels/bioconda/packages/sshash/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sshash/overview
- **Total Downloads**: 722
- **Last updated**: 2026-01-24
- **GitHub**: https://github.com/jermp/sshash
- **Stars**: N/A
### Original Help Text
```text
sshash build --help
```

## sshash_permute

### Tool Description
Permute the order of sequences in a FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/sshash:5.0.0--haf24da9_0
- **Homepage**: https://github.com/jermp/sshash
- **Package**: https://anaconda.org/channels/bioconda/packages/sshash/overview
- **Validation**: PASS

### Original Help Text
```text
sshash permute --help
```

## sshash_query

### Tool Description
Query a SSHash dictionary with the k-mers of reads or sequences from a FASTA or FASTQ file.

### Metadata
- **Docker Image**: quay.io/biocontainers/sshash:5.0.0--haf24da9_0
- **Homepage**: https://github.com/jermp/sshash
- **Package**: https://anaconda.org/channels/bioconda/packages/sshash/overview
- **Validation**: PASS

### Original Help Text
```text
sshash query 
Usage: query [-h,--help] [-i index_filename] [-q query_filename] [--multiline] [--verbose]

 [-i index_filename]
	REQUIRED: Must be a file generated with the tool 'build'.

 [-q query_filename]
	REQUIRED: Must be a FASTA/FASTQ file (.fa/fasta or .fq/fastq extension) compressed with gzip or not.

 [--multiline]
	Use this option if more the one DNA line must be parsed after each header. Only valid for FASTA files (not FASTQ).

 [--verbose]
	Verbose output.

 [-h,--help]
	Print this help text and silently exits.
```

## Metadata
- **Skill**: generated
