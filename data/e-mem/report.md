# e-mem CWL Generation Report

## e-mem

### Tool Description
E-MEM finds and outputs the position and length of all maximal exact matches (MEMs) between <query-file> and <reference-file>

### Metadata
- **Docker Image**: biocontainers/e-mem:v1.0.1-2-deb_cv1
- **Homepage**: https://github.com/EverMind-AI/EverMemOS
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/e-mem/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/EverMind-AI/EverMemOS
- **Stars**: N/A
### Original Help Text
```text
E-MEM Version 1.0.1, Dec. 12, 2017
© 2014 Nilesh Khiste, Lucian Ilie

E-MEM finds and outputs the position and length of all maximal
exact matches (MEMs) between <query-file> and <reference-file>

Usage: ../e-mem [options]  <reference-file>  <query-file>

Options:
-n	match only the characters a, c, g, or t
  	they can be in upper or in lower case
-l	set the minimum length of a match. The default length
  	is 50
-b	compute forward and reverse complement matches
-r	only compute reverse complement matches
-c	report the query-position of a reverse complement match
  	relative to the original query sequence
-F	force 4 column output format regardless of the number of
  	reference sequence input
-L	show the length of the query sequences on the header line
-d	set the split size. The default value is 1
-t	number of threads. The default is 1 thread
-h	show possible options
```

