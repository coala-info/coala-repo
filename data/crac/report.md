# crac CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| crac | PASS |  |
| crac_crac-index_get | PASS |  |
| crac_crac-index_index | PASS |  |

## crac

### Tool Description
CRAC: a tool for analyzing RNA-seq data, detecting and classifying biological events (splice, snv, indel, chimera)

### Metadata
- **Docker Image**: biocontainers/crac:v2.5.0dfsg-3-deb_cv1
- **Homepage**: https://github.com/brannondorsey/wifi-cracking
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/crac/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/brannondorsey/wifi-cracking
- **Stars**: N/A
### Original Help Text
```text
crac 2.5.0	Compiled on Sep 13 2018.

   -h, --help           <none>          print this help and exit
   -f, --full-help      <none>          print a complete help and exit
   -v                   <none>          print version and exit

Mandatory arguments
   -i                   <FILE>          set genome index file (without the extension filename)
   -r                   <FILE> [FILE2]  set read file. Specify FILE2 in case of paired-end reads
   -k                   <INT>           set k-mer length
   -o, --sam            <FILE>          set SAM output filename or print on STDOUT with "-o -" argument

Optional arguments
  * Protocol
   --fr/--rf/--ff       <none>          set the mates alignement orientation (DEFAULT --fr)
   --stranded           <none>          set the read mapping with for a strand specific library (DEFAULT non-strand specific)

  * Efficiency
   --nb-threads         <INT>           set the number of worker threads (DEFAULT 1)
   --reads-length, -m   <INT>           set read length in case of all reads have the same length to optimize
                                        CPU and memory times
   --treat-multiple     <INT>           write alignments with multiple locations (with a fixed limit) in the SAM file rather than only one occurrence
   --max-locs           <INT>           set the maximum number of locations on the reference index (DEFAULT 300)

  * Output
   --bam                <none>          sam output is encode in binary format(BAM)
   --summary            <FILE>          set output summary file with some statistics about mapping and classification

  * Accuracy
   --no-ambiguity       <none>          discard biological events (splice, snv, indel, chimera) which have several matches on the reference index
```


## crac_crac-index_index

### Tool Description
Create an index on the specified FASTA or MultiFASTA file(s) (writes <name>.ssa and <name>.conf)

### Metadata
- **Docker Image**: biocontainers/crac:v2.5.0dfsg-3-deb_cv1
- **Homepage**: http://crac.gforge.inria.fr/
- **Package**: https://anaconda.org/channels/bioconda/packages/crac/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/crac/overview
### Original Help Text
```text
crac-index version 2.5.0	Compiled on Sep 13 2018

Usage : crac-index [options] <command> <output file> <input file>+

  command must be one of:
    index: create an index on the specified input file(s).

    get:   get a (multi)FASTA file containing the original sequences.

  options can be (for the index command only):

  -b <bucket_size>	 the size of the bucket for the index construction
                  	 (default 100000000)
  -d <diff-cover> 	 parameter for the index construction (default 1024)
  -s <sample dist>	 sample distance (default 64)
  -v              	 verbose mode

  Examples: 
	Indexing:
		crac-index index myIndex sequence1.fa sequence2.fa sequence3.fa
			You can specify FASTA or MultiFASTA file(s).
			In this example, two files will be created:
			- myIndex.ssa (index storing the compressed sequences)
			- myIndex.conf (information on sequence names and length)
	Extracting:
		crac-index get sequences.fa myIndex
			Sequences indexed in myIndex will be extracted
			to the sequences.fa file
```

## crac_crac-index_get

### Tool Description
Get a (multi)FASTA file containing the original sequences from a CRAC index

### Metadata
- **Docker Image**: biocontainers/crac:v2.5.0dfsg-3-deb_cv1
- **Homepage**: http://crac.gforge.inria.fr/
- **Package**: https://anaconda.org/channels/bioconda/packages/crac/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/crac/overview
### Original Help Text
```text
crac-index version 2.5.0	Compiled on Sep 13 2018

Usage : crac-index [options] <command> <output file> <input file>+

  command must be one of:
    index: create an index on the specified input file(s).

    get:   get a (multi)FASTA file containing the original sequences.

  options can be (for the index command only):

  -b <bucket_size>	 the size of the bucket for the index construction
                  	 (default 100000000)
  -d <diff-cover> 	 parameter for the index construction (default 1024)
  -s <sample dist>	 sample distance (default 64)
  -v              	 verbose mode

  Examples: 
	Indexing:
		crac-index index myIndex sequence1.fa sequence2.fa sequence3.fa
			You can specify FASTA or MultiFASTA file(s).
			In this example, two files will be created:
			- myIndex.ssa (index storing the compressed sequences)
			- myIndex.conf (information on sequence names and length)
	Extracting:
		crac-index get sequences.fa myIndex
			Sequences indexed in myIndex will be extracted
			to the sequences.fa file
```

## Metadata
- **Skill**: generated
