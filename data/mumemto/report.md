# mumemto CWL Generation Report

## mumemto

### Tool Description
find maximal [unique | exact] matches using PFP.

### Metadata
- **Docker Image**: quay.io/biocontainers/mumemto:1.3.4--py310h275bdba_0
- **Homepage**: https://github.com/vikshiv/mumemto
- **Package**: https://anaconda.org/channels/bioconda/packages/mumemto/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mumemto/overview
- **Total Downloads**: 15.8K
- **Last updated**: 2025-10-29
- **GitHub**: https://github.com/vikshiv/mumemto
- **Stars**: N/A
### Original Help Text
```text
[1m[31m
mumemto version: 1.3.4[m[0m

mumemto - find maximal [unique | exact] matches using PFP.
Usage: mumemto [options] [input_fasta [...]]

*** for all options, N = # of sequences ***
I/O options:
	-h, --help                      prints this usage message
	-i, --input           [FILE]    path to a file-list of genomes to use (overrides positional args)
	-o, --output          [PREFIX]  output prefix path
	-r, --no-revcomp                include the reverse complement of the sequences (default: true)

	-b, --binary                    output binary format (multi-MUMs only)

	-A, --arrays-out                write LCP, BWT, and SA to file
	-a, --arrays-in       [PREFIX]  compute matches from precomputed LCP, BWT, SA (with shared PREFIX.bwt/sa/lcp)

	-M, --merge                     output extra metadata to enable merging multi-MUMs
	-n, --anchor                    Use anchor-based merging (requires -M, uses first sequence as anchor)
Exact match parameters:
	-l, --min-match-len   [INT]     minimum MUM or MEM length (default: 20)

	-k, --minimum-genomes [INT]     find matches in at least k sequences (k < 0 sets the sequences relative to N, i.e. matches must occur in at least N - |k| sequences)
	                                (default: match occurs in all sequences, i.e. strict multi-MUM/MEM)

	-f, --per-seq-freq    [INT]     maximum number of occurences per sequence (set to 0 for no upper limit)
	                                (default: 1 [unique])

	-F, --max-total-freq  [INT]     maximum number of total occurences of match (if negative, then relative to N) 
	                                (default: no upper limit)

PFP options:
	-w, --window          [INT]     window size used for pfp (default: 10)
	-m, --modulus         [INT]     hash-modulus used for pfp (default: 100)
	-p, --from-parse                use pre-computed pf-parse (with shared PREFIX.parse and PREFIX.dict)
	-K, --keep-temp-files           keep PFP files
	-g, --use-gsacak                skip PFP and use gsacak directly to compute LCP, BWT, SA
	-P, --only-parse                only compute PFP over the input files and do not compute matches

Overview:
	By default, Mumemto computes multi-MUMs. Exact match parameters can be additionally tuned in three main ways:
	1) Choosing the number of sequences a match must appear in [-k]
	2) Choosing the maximum number of occurences in each genome [-f]
	3) Choosing the total maximum number of occurences [-F]
Examples:
	 - Find all strict multi-MUMs across a collection: mumemto [OPTIONS] [input_fasta [...]] (equivalently -k 0 -f 1 -F 0)
	 - Find partial multi-MUMs in all sequences but one: mumemto -k -1 [OPTIONS] [input_fasta [...]]
	 - Find multi-MEMs that appear at most 3 times in each sequence: mumemto -f 3 [OPTIONS] [input_fasta [...]]
	 - Find all MEMs that appear at most 100 times within a collection: mumemto -f 0 -k 2 -F 100 [OPTIONS] [input_fasta [...]]
```

