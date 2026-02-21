# arcs CWL Generation Report

## arcs

### Tool Description
ARCS/ARKS utilizes linked read alignments or kmers for scaffolding draft genomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/arcs:1.2.8--hdcf5f25_0
- **Homepage**: https://github.com/bcgsc/arcs
- **Package**: https://anaconda.org/channels/bioconda/packages/arcs/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/arcs/overview
- **Total Downloads**: 35.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bcgsc/arcs
- **Stars**: N/A
### Original Help Text
```text
Reading user inputs...
arcs 1.2.8

Usage: arcs [Options] <list of alignment files>  or
       arcs [Options] --arks -f <contig sequence file> <list of linked read files>

Requirements for ARCS (default method):
       ARCS utilizes linked read alignments for scaffolding (https://doi.org/10.1093/bioinformatics/btx675)       Alignment files are REQUIRED either as positional arguments or in a supplied file of BAM paths (with -a).

       Alignments may be in SAM or BAM file.
       The output of the aligner may be piped directly into ARCS by setting
       alignments to /dev/stdin, in which case it must be in SAM format.

       Paired reads must occur consecutively (interleaved) in the SAM/BAM file.
       The output of the aligner may either not be sorted,
       or may be sorted by read name using samtools sort -n.
       The SAM/BAM file must not be sorted by coordinate position.

       The barcode may be found in either the BX:Z:BARCODE SAM tag,
       or in the read (query) name following an underscore, READNAME_BARCODE.
       In the latter case the barcode must be composed entirely of nucleotides.

Requirements for ARKS method:
       ARKS scaffolds draft genomes using linked read kmers (https://doi.org/10.1186/s12859-018-2243-x).
       Contig sequences are REQUIRED by the -f option.
       linked read files are REQUIRED either as positional arguments or in a supplied file of linked read file paths. Pay attention to have only linked read files in the file of file names.

       The barcode multiplicity file is optional and can be provided by -u option in either .tsv or .csv format.

Common Options:
   -a, --fofName=FILE    text file listing input filenames
   -u, --multfile        tsv or csv file listing barcode multiplicities [optional]
   -f, --file=FILE       FASTA file of contig sequences to scaffold
   -c, --min_reads=N     min aligned read pairs per barcode mapping [5]
   -l, --min_links=N     min shared barcodes between contigs [0]
   -z, --min_size=N      min contig length [500]
   -b, --base_name=STR   output file prefix
   -g, --graph=FILE      write the ABySS dist.gv to FILE
       --gap=N           fixed gap size for ABySS dist.gv file [100]
       --tsv=FILE        write graph in TSV format to FILE
       --barcode-counts=FILE       write number of reads per barcode to FILE
   -m, --index_multiplicity=RANGE  barcode multiplicity range [50-10000]
   -d, --max_degree=N    max node degree in scaffold graph [0]
   -e, --end_length=N    contig head/tail length for masking alignments [30000]
   -r, --error_percent=N p-value for head/tail assignment and link orientation (lower is more stringent) [0.05]
   -v, --run_verbose     verbose logging
Options specific to ARCS:
   -s, --seq_id=N        min sequence identity for read alignments [98]
Options specific to ARKS:
   -k  --k_value         size of a k-mer [30]
   -j  --j_index         minimum fraction of read kmers matching a contigId [0.55]
   -t  --threads         number of threads [1]

 Distance Estimation Options (Common):
   -B, --bin_size=N        estimate distance using N closest Jaccard scores [20]
   -D, --dist_est          enable distance estimation
       --no_dist_est       disable distance estimation [default]
       --dist_median       use median distance in ABySS dist.gv [default]
       --dist_upper        use upper bound distance in ABySS dist.gv
       --dist_tsv=FILE     write min/max distance estimates to FILE
       --samples_tsv=FILE  write intra-contig distance/barcode samples to FILE
   -P, --pair              output scaffolds pairing TSV with number of barcode links (no p-value threshold)supporting each of the 4 possible orientation
```


## Metadata
- **Skill**: generated

## arcs_arcs-make

### Tool Description
A pipeline to run ARCS/ARKS with or without Tigmint for scaffolding genomic drafts using linked or long reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/arcs:1.2.8--hdcf5f25_0
- **Homepage**: https://github.com/bcgsc/arcs
- **Package**: https://anaconda.org/channels/bioconda/packages/arcs/overview
- **Validation**: PASS
### Original Help Text
```text
Usage: ./arcs-make [COMMAND] [OPTION=VALUE]...
    Commands:

	arcs		run arcs in default mode only, skipping tigmint
	arcs-tigmint	run tigmint, and run arcs in default mode with the output of tigmint
	arcs-long	run arcs in default mode only, using long instead of linked reads, skipping tigmint
	arks		run arcs in kmer mode only, skipping tigmint
	arks-tigmint	run tigmint, and run arcs in kmer mode with the output of tigmint
	arks-long   	run arcs in kmer mode only, using long instead of linked reads, skipping tigmint
	help            display this help page
	version         display the software version
	clean           remove intermediate files

    General Options:

	draft           draft name [draft]. File must have .fasta or .fa extension
	reads           read name [reads]. File must have .fastq.gz or .fq.gz extension.
 			File can be uncompressed (.fastq, .fq) when using arcs-long or arks-long modes.
	time		logs time and memory usage to file for main steps (Set to 1 to enable logging)
	prefix		prefix for soft-link to final output scaffolds - optional

    bwa Options:

	t		number of threads used [8]

    Tigmint Options:

	minsize         minimum molecule size [2000]
	as              minimum AS/read length ratio [0.65]
	nm              maximum number of mismatches [5]
	dist            max dist between reads to be considered the same molecule [50000]
	mapq            mapping quality threshold [0]
	trim            bp of contigs to trim after cutting at error [0]
	span            min number of spanning molecules to be considered assembled [20]
	window          window size for checking spanning molecules [1000]

    Common Options:

	c               minimum aligned read pairs per barcode mapping [5]
	m               barcode multiplicity range [50-10000]
	z               minimum contig length [500]
	r               p-value for head/tail assigment and link orientation [0.05]
	e               contig head/tail length for masking aligments [30000]
	D               enable distance estimation [false]
	dist_upper      use upper bound distance over median distance [false]
	B               estimate distance using N closest Jaccard scores [20]
	d               max node degree in scaffold graph [0]
	gap             fixed gap size for dist.gv file [100]
	barcode_counts	name of output barcode multiplicity TSV file [barcodeMultiplicityArcs]
	cut		cut length for long reads (for arcs-long and arks-long only) [250]

	ARCS Specific Options:
	s		minimum sequence identity [98]

	ARKS Specific Options:
	j		minimum fraction of read kmers matching a contigId [0.55]
	k 		size of a k-mer [30]
	t		number of threads [8]

    LINKS Options:

	l               minimum number of links to compute scaffold [5]
	a               maximum link ratio between two best contig pairs [0.3]

Example: To run tigmint and arcs with myDraft.fa, myReads.fq.gz, and a custom multiplicty range, run:
	./arcs-make arcs-tigmint draft=myDraft reads=myReads m=[User defined multiplicty range]
To ensure that the pipeline runs correctly, make sure that the following tools are in your PATH: bwa, tigmint, samtools, arcs (>= v1.1.0), LINKS (>= v1.8.6)
When running targets including Tigmint, please ensure that all input files are in your current working directory.
```

