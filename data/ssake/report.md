# ssake CWL Generation Report

## ssake

### Tool Description
SSAKE (A Short Read Sequence Assembly Program)

### Metadata
- **Docker Image**: biocontainers/ssake:v4.0-2-deb_cv1
- **Homepage**: https://github.com/warrenlr/SSAKE
- **Package**: https://anaconda.org/channels/bioconda/packages/ssake/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ssake/overview
- **Total Downloads**: 6.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/warrenlr/SSAKE
- **Stars**: N/A
### Original Help Text
```text
Usage: /usr/bin/ssake [v4.0]
-f  File containing all the [paired (-p 1)] reads (required)
	  With -p 1:
	! Target insert size must be indicated at the end of the header line (e.g. :400 for a 400bp fragment/insert size)
	! Paired reads must be separated by ":"
	  >header:400 (or >header_barcode:400)
	  ACGACACTATGCATAAGCAGACGAGCAGCGACGCAGCACG:GCGCACGACGCAGCACAGCAGCAGACGAC
-g  Fasta file containing unpaired sequence reads (optional)
-w  Minimum depth of coverage allowed for contigs (e.g. -w 1 = process all reads [v3.7 behavior], required, recommended -w 5)
    *The assembly will stop when 50+ contigs with coverage < -w have been seen.*
-s  Fasta file containing sequences to use as seeds exclusively (specify only if different from read set, optional)
	-i Independent (de novo) assembly  i.e Targets used to recruit reads for de novo assembly, not guide/seed reference-based assemblies (-i 1 = yes (default), 0 = no, optional)
	-j Target sequence word size to hash (default -j 15)
	-u Apply read space restriction to seeds while -s option in use (-u 1 = yes, default = no, optional)
-m  Minimum number of overlapping bases with the seed/contig during overhang consensus build up (default -m 20)
-o  Minimum number of reads needed to call a base during an extension (default -o 2)
-r  Minimum base ratio used to accept a overhang consensus base (default -r 0.7)
-t  Trim up to -t base(s) on the contig end when all possibilities have been exhausted for an extension (default -t 0, optional)
-c  Track base coverage and read position for each contig (default -c 0, optional)
-y  Ignore read mapping to consensus (-y 1 = yes, default = no, optional)
-h  Ignore read name/header *will use less RAM if set to -h 1* (-h 1 = yes, default = no, optional)
-b  Base name for your output files (optional)
-z  Minimum contig size to track base coverage and read position (default -z 100, optional)
-q  Break tie when no consensus base at position, pick random base (-q 1 = yes, default = no, optional)
-p  Paired-end reads used? (-p 1 = yes, default = no, optional)
-v  Runs in verbose mode (-v 1 = yes, default = no, optional)
============ scaffolding options below only considered with -p 1 ============
-e  Error (%) allowed on mean distance   e.g. -e 0.75  == distance +/- 75% (default -e 0.75, optional)
-l  Minimum number of links (read pairs) to compute scaffold (default -k 5, optional)
-a  Maximum link ratio between two best contig pairs *higher values lead to least accurate scaffolding* (default -a 0.3, optional)
```

