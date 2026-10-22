# scramble CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| scramble_cluster_identifier | PASS |  |
| scramble_scramble.sh | PASS |  |

## scramble_cluster_identifier

### Tool Description
Identify clusters in BAM/CRAM files based on soft-clipped bases and reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/scramble:1.0.2--h031d066_1
- **Homepage**: https://github.com/GeneDx/scramble
- **Package**: https://anaconda.org/channels/bioconda/packages/scramble/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/scramble/overview
- **Total Downloads**: 7.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/GeneDx/scramble
- **Stars**: N/A
### Original Help Text
```text
Usage: cluster_identifier [-m min soft clipped bases] [-s min soft clipped reads] [-r region] cram/bam
```

## scramble_scramble.sh

### Tool Description
Call mobile element insertions and deletions from the soft-clipped read clusters made by cluster_identifier (wrapper script for SCRAMble.R)

### Metadata
- **Docker Image**: quay.io/biocontainers/scramble:1.0.2--h031d066_1
- **Homepage**: https://github.com/GeneDx/scramble
- **Package**: https://anaconda.org/channels/bioconda/packages/scramble/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/share/scramble/bin/SCRAMble.R [options]


Options:
	-h, --help
		Show this help message and exit

	-o OUT-NAME, --out-name=OUT-NAME
		full path to output file including prefix

	-c CLUSTER-FILE, --cluster-file=CLUSTER-FILE
		full path to cluster file

	-n NCLUSTER, --nCluster=NCLUSTER
		min cluster size to analyze [default 5]

	--indel-score=INDEL-SCORE
		min indel alignment score to call [default 80]

	-m MEI-SCORE, --mei-score=MEI-SCORE
		min mei alignment score to call [default 50]

	--min-del-len=MIN-DEL-LEN
		minimum deletion length to call [default 50]

	--poly-a-frac=POLY-A-FRAC
		fraction of clipped length for calling polyA tail in MEIs [default 0.75]

	--pct-align=PCT-ALIGN
		percent alignment of clipped read for calling deletionss [default 90]

	--poly-a-dist=POLY-A-DIST
		how far from MEI to look for polyA tail [default 100]

	-i INSTALL-DIR, --install-dir=INSTALL-DIR
		resource directory [default ~/scramble/cluster_analysis/bin/]

	--mei-refs=MEI-REFS
		full path to MEI reference file (fasta format) [default ~/scramble/cluster_analysis/resources/MEI_consensus_seqs.fa]

	-r REF, --ref=REF
		reference file (fasta format) [default NULL]

	--no-vcf
		evaluate meis

	--eval-meis
		evaluate meis

	--eval-dels
		evaluate deletions
```

