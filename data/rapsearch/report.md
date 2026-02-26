# rapsearch CWL Generation Report

## rapsearch

### Tool Description
Fast protein similarity search tool for short reads

### Metadata
- **Docker Image**: quay.io/biocontainers/rapsearch:2.24--1
- **Homepage**: https://github.com/zhaoyanswill/RAPSearch2
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rapsearch/overview
- **Total Downloads**: 14.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/zhaoyanswill/RAPSearch2
- **Stars**: N/A
### Original Help Text
```text
Error: No query
rapsearch v2.24: Fast protein similarity search tool for short reads
-------------------------------------------------------------------------
 Options: 
	-q string : query file or stdin (FASTA or FASTQ format)
	-d string : database file (**base name only**, with full path)
	-o string : output file name
	-u int    : stream one result through stdout [1: m8 result, 2: aln result, default: don't stream any result through stdout]
	-z int    : number of threads [default: 1]
	-s char   : report log10(E-value) or E-value for each hit [t/T: log10(E-value), the default; f/F: E-value]
	-e double : E-value threshold, given in the format of log10(E-value), or E-value (when -s is set to f) [default: 1.0/10.0]. 
	-i double : threshold of bit score [default: 0.0]. It is the alternative option to limit the hits to report.
	-l int    : threshold of minimal alignment length [default: 0]
	-v int    : number of database sequences to show one-line descriptions [default: 500]. If it's -1, all results will be shown.
	-b int    : number of database sequence to show alignments [default: 100]. If it's -1, all results will be shown.
	-t char   : type of query sequences [u/U:unknown, n/N:nucleotide, a/A:amino acid, q/Q:fastq, default: u]
	-p char   : output ALL/MATCHED query reads into the alignment file [t/T: output all query reads, f/F: output matched reads, default: f]
	-g char   : apply gap extension [t/T: yes, f/F: no, default: t]
	-a char   : use fast mode (10~30 fold) [t/T: yes, f/F: no, default: f]
	-w char   : apply HSSP criterion instead of E-value criterion [t/T: HSSP, f/F: E-value criteria, default: f]
	-x char   : print hits in xml format [t/T: yes, f/F: no, default: f]
-------------------------------------------------------------------------
example 1> rapsearch -q query.fa -d nr -o output_file
example 2> rapsearch -q query.fa -d nr -o output_file -i 40 -l 25
   this setting only reports the hits with bit score >= 40 and alignment length >= 25
example 3> rapsearch -q query.fa -d nr -o output_file -e -5
   this setting only reports hits with log(E-value) <= -5 (i.e., E-value <= 1e-5)
example 4> rapsearch -q query.fa -d nr -o output_file -e 1e-5 -s f
   this setting only reports the hits with E-value <= 1e-5
the difference between example 3 & 4 is that the former lists log(E-value) while the latter lists E-value for each hit in the output file
```

