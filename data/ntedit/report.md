# ntedit CWL Generation Report

## ntedit

### Tool Description
Fast, lightweight, scalable genome sequence polishing and SNV detection & annotation

### Metadata
- **Docker Image**: quay.io/biocontainers/ntedit:2.1.1--pl5321h077b44d_0
- **Homepage**: https://github.com/bcgsc/ntEdit
- **Package**: https://anaconda.org/channels/bioconda/packages/ntedit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ntedit/overview
- **Total Downloads**: 29.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bcgsc/ntEdit
- **Stars**: N/A
### Original Help Text
```text
ntEdit v2.1.1

 Fast, lightweight, scalable genome sequence polishing and SNV detection & annotation

 Options:
	-t,	number of threads [default=4]
	-f,	draft genome assembly (FASTA, Multi-FASTA, and/or gzipped compatible), REQUIRED
	-r,	Bloom filter (BF) or counting BF (CBF) file (generated from ntStat v1.0.0+), REQUIRED
	-e,	secondary BF with k-mers to reject (generated from ntStat v1.0.0+), OPTIONAL - NOT NEEDED with CBF
	-b,	output file prefix, OPTIONAL
	-z,	minimum contig length [default=100]
	-i,	maximum number of insertion bases to try, range 0-5, [default=5]
	-d,	maximum number of deletions bases to try, range 0-10, [default=5]
	-x,	k/x ratio for the number of k-mers that should be missing, [default=5.000]
	-y, 	k/y ratio for the number of edited k-mers that should be present, [default=9.000]
	-X, 	ratio of number of k-mers in the k subset that should be missing in order to attempt fix (higher=stringent), [default=0.5]
	-Y, 	ratio of number of k-mers in the k subset that should be present to accept an edit (higher=stringent), [default=0.5]
	-c,	cap for the number of base insertions that can be made at one position, [default=k*1.5]
	-j, 	controls size of k-mer subset. When checking subset of k-mers, check every jth k-mer, [default=3]
	-m,	mode of editing, range 0-2, [default=0]
			0: best substitution, or first good indel
			1: best substitution, or best indel
			2: best edit overall (suggestion that you reduce i and d for performance)
	-s,     SNV mode. Overrides draft k-mer checks, forcing reassessment at each position (-s 1 = yes, default = 0, no)
	-l,	input VCF file with annotated variants (e.g., clinvar.vcf), OPTIONAL
	-a,	soft masks missing k-mer positions having no fix (-v 1 = yes, default = 0, no)
	-v,	verbose mode (-v 1 = yes, default = 0, no)

	-p, minimum k-mer coverage threshold (CBF only) [default=minimum of counting Bloom filter
counts, cannot be larger than 255]
	-q, maximum k-mer coverage threshold (CBF only) [default=255, largest possible value]
	--help,		display this message and exit 
	--version,	output version information and exit

	If one of X/Y is set, ntEdit will use those parameters instead. Otherwise, it uses x/y by default.
```

