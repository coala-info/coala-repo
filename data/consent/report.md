# consent CWL Generation Report

## consent_CONSENT-correct

### Tool Description
Indicate whether the long reads are from PacBio (--type PB) or Oxford Nanopore (--type ONT)

### Metadata
- **Docker Image**: quay.io/biocontainers/consent:2.2.2--h3452944_6
- **Homepage**: https://github.com/morispi/CONSENT
- **Package**: https://anaconda.org/channels/bioconda/packages/consent/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/consent/overview
- **Total Downloads**: 16.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/morispi/CONSENT
- **Stars**: N/A
### Original Help Text
```text
Usage: /usr/local/bin/CONSENT-correct [options] --in longReads.fast[a|q] --out result.fasta --type readsTechnology

	Input:
	longReads.fast[a|q]:           fasta or fastq file of long reads to correct.
	result.fasta:                  fasta file where to output the corrected long reads.
	readsTechnology:               Indicate whether the long reads are from PacBio (--type PB) or Oxford Nanopore (--type ONT)

	Options:
	--windowSize INT, -l INT:      Size of the windows to process. (default: 500)
	--minSupport INT, -s INT:      Minimum support to consider a window for correction. (default: 3)
	--maxSupport INT, -S INT:      Maximum number of overlaps to include in a pile. (default: 150)
	--merSize INT, -k INT:         k-mer size for chaining and polishing. (default: 9)
	--solid INT, -f INT:           Minimum number of occurrences to consider a k-mer as solid during polishing. (default: 4)
	--anchorSupport INT, -c INT:   Minimum number of sequences supporting (Ai) - (Ai+1) to keep the two anchors in the chaining. (default: 8)
	--minAnchors INT, -a INT:      Minimum number of anchors in a window to allow consensus computation. (default: 10)
	--windowOverlap INT, -o INT:   Overlap size between consecutive windows. (default: 50)
	--nproc INT, -j INT:           Number of processes to run in parallel (default: number of cores).
	--minimapIndex INT, -m INT:    Split minimap2 index every INT input bases (default: 500M).
	--tmpdir STRING, -t STRING:    Path where to store the temporary files (default: working directory).
	--help, -h:                    Print this help message.
	--version, -v: 	               Print version information.
```


## consent_CONSENT-polish

### Tool Description
Polishes contigs using long reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/consent:2.2.2--h3452944_6
- **Homepage**: https://github.com/morispi/CONSENT
- **Package**: https://anaconda.org/channels/bioconda/packages/consent/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/CONSENT-polish [options] --contigs contigs.fast[a|q] --reads longReads.fast[a|q] --out result.fasta

	Input:
	contigs.fast[a|q]:             fasta or fastq file of contigs to polish.
	longReads.fast[a|q]:           fasta or fastq file of long reads to use for polishing.
	result.fasta:                  fasta file where to output the polished contigs.

	Options:
	--windowSize INT, -l INT:      Size of the windows to process. (default: 500)
	--minSupport INT, -s INT:      Minimum support to consider a window for correction. (default: 1)
	--maxSupport INT, -S INT:      Maximum number of overlaps to include in a pile. (default: 20,000)
	--merSize INT, -k INT:         k-mer size for chaining and polishing. (default: 9)
	--solid INT, -f INT:           Minimum number of occurrences to consider a k-mer as solid during polishing. (default: 4)
	--anchorSupport INT, -c INT:   Minimum number of sequences supporting (Ai) - (Ai+1) to keep the two anchors in the chaining. (default: 8)
	--minAnchors INT, -a INT:      Minimum number of anchors in a window to allow consensus computation. (default: 10)
	--windowOverlap INT, -o INT:   Overlap size between consecutive windows. (default: 50)
	--nproc INT, -j INT:           Number of processes to run in parallel (default: number of cores).
	--minimapIndex INT, -m INT:    Split minimap2 index every INT input bases (default: 500M).
	--tmpdir STRING, -t STRING:    Path where to store the temporary files (default: working directory).
	--help, -h:                    Print this help message.
	--version, -v: 	               Print version information.
```

