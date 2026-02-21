# pass CWL Generation Report

## pass

### Tool Description
FAIL to generate CWL: pass not found in Singularity image. The image may not provide this executable.

### Metadata
- **Docker Image**: quay.io/biocontainers/pass:0.3.1--hdfd78af_0
- **Homepage**: https://github.com/bcgsc/PASS
- **Package**: https://anaconda.org/channels/bioconda/packages/pass/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/pass/overview
- **Total Downloads**: 956
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bcgsc/PASS
- **Stars**: N/A
### Generation Failed

FAIL to generate CWL: pass not found in Singularity image. The image may not provide this executable.


### Validation Errors

- FAIL to generate CWL: pass not found in Singularity image. The image may not provide this executable.



### Original Help Text
```text

```


## Metadata
- **Skill**: generated

## pass_PASS

### Tool Description
v0.3.1 peptide assembly

### Metadata
- **Docker Image**: quay.io/biocontainers/pass:0.3.1--hdfd78af_0
- **Homepage**: https://github.com/bcgsc/PASS
- **Package**: https://anaconda.org/channels/bioconda/packages/pass/overview
- **Validation**: PASS
### Original Help Text
```text
Usage: /usr/local/bin/PASS [v0.3.1 peptide assembly]
-f  File containing all the peptide reads (required)
-w  Minimum depth of coverage allowed for contigs (e.g. -w 1 = process all reads, required)
    *The assembly will stop when 50+ contigs with coverage < -w have been seen.*
-s  Fasta file containing sequences to use as seeds exclusively (specify only if different from read set, optional)
	-i Independent (de novo) assembly  i.e Targets used to recruit reads for de novo assembly, not guide/seed reference-based assemblies (-i 1 = yes (default), 0 = no, optional)
	-j Target sequence word size to hash (default -j 5)
	-u Apply read space restriction to seeds while -s option in use (-u 1 = yes, default = no, optional)
-m  Minimum number of overlapping amino acids with the seed/contig during overhang consensus build up (default -m 10)
-o  Minimum number of peptide reads needed to call a amino acid during an extension (default -o 2)
-r  Minimum ratio used to accept a overhang consensus amino acid (default -r 0.7)
-t  Trim up to -t amino acid(s) on the contig end when all possibilities have been exhausted for an extension (default -t 0, optional)
-c  Track amino acid coverage and read position for each contig (default -c 0, optional)
-y  Ignore read mapping to consensus (-y 1 = yes, default = no, optional)
-h  Ignore read name/header *will use less RAM if set to -h 1* (-h 1 = yes, default = no, optional)
-b  Basename for your output files (optional)
-z  Minimum contig size to track amino acid coverage and read position (default -z 20, optional)
-q  Break tie when no consensus amino acid at position, pick random amino acid (-q 1 = yes, default = no, optional)
-v  Runs in verbose mode (-v 1 = yes, default = no, optional)
```

