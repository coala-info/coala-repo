# metaxa CWL Generation Report

## metaxa_metaxa2

### Tool Description
Metaxa2 is a tool for identification and taxonomic classification of small and large subunit rRNA sequences in metagenomes and other sequence data sets.

### Metadata
- **Docker Image**: quay.io/biocontainers/metaxa:2.2.3--pl5321hdfd78af_2
- **Homepage**: http://microbiology.se/software/metaxa2/
- **Package**: https://anaconda.org/channels/bioconda/packages/metaxa/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/metaxa/overview
- **Total Downloads**: 9.8K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Usage: metaxa2 -i <input file> -o <output file>
Options:
-i {file} : DNA FASTA or FASTQ input file to investigate
-o {file} : Base for the names of output file(s)
-1 {file} : DNA FASTQ input file containing the first reads in the read pairs to investigate
-2 {file} : DNA FASTQ input file containing the second reads in the pairs to investigate
-f {a, auto, f, fasta, q, fastq, p, paired-end, pa, paired-fasta} : Specifies the format of the input file, default = auto
-z {f, a, auto, gzip, bzip, zip, dsrc} : Specifies the format of the input file, default = f (off)
-g {ssu, lsu, string} : Specifies the barcoding gene Metaxa should look for, default is ssu
--pairfile {file} : DNA FASTQ file containing the pairs to the sequences in the input file
--format {a, auto, f, fasta, q, fastq, p, paired-end} : Specifies the format of the input file, default = auto
--mode {m, metagenome, g, genome, a, auto} : Controls the Metaxa2 operating mode, default = metagenome
-x {T or F} : Run only the extraction part of Metaxa2, without classification, off (F) by default
-c {T or F} : Run only the classification part of Metaxa2, without prior extraction, off (F) by default
-p {directory} : A path to a directory of HMM-profile collections representing rRNA conserved regions, default is in the same directory as metaxa itself
-d {database} : The BLAST databased used for classification, default is in the same directory as metaxa itself
--hmmscan {file} : If the hmmscan has already been performed, this option can be used as the base for the hmmscan output files, and the hmmscan step will be skipped. Overrides the -o option, while a DNA FASTA file must still be supplied!
--date {T or F} : Adds a date and time stamp to the output directory, off (F) by default
--plus {T or F} : Runs blast search through blast+ instead of the legacy blastall engine, off (F) by default
--usearch {version} : Runs usearch instead of blast, specify version, off (0) by default
--usearch_bin {path} : Specifies the location of the Usearch binary to be used, default is 'usearch' only
--ublast {T or F} : Runs the Ublast algorithm instead of Usearch algorithm, default is on (T)
--reset {T or F} : Rebuilds the HMM database. Useful if HMMER has been updated or searches seem to fail mysteriously, off (F) by default
--temp {directory} : Custom directory to put the temporary files in

FASTQ and Paired-end options:
-q {value} : Minimum quality value for basecalling, default = 20
--quality_filter {T or F} : Filter out low-quality reads (below specified -q value), off (F) by default
--quality_trim {T or F} : Trim away ends of low quality (below -q value), off (F) by default
--quality_percent {value} : Percentage of low-quality (below -q value) accepted before filtering/trimming, default=10
--ignore_paired_read {T or F} : Do not discard the entire pair if only one of the reads is of bad quality, on (T) by default
--distance {value} : Specifies the distance between the sequence pairs, default = 150

Sequence selection options:
-t {b, bacteria, a, archaea, e, eukaryota, m, mitochondrial, c, chloroplast, A, all, o, other} : Profile set to use for the search (comma-separated), default is all
-E {value} : Domain E-value cutoff for a sequence to be included in the output, default = 1
-S {value} : Domain score cutoff for a sequence to be included in the output, default = 12
-N {value} : The minimal number of domains that must match a sequence before it is included, default = 2
-M {value} : Number of sequence matches to consider for classification, default = 5
-R {value} : Reliability cutoff for taxonomic classification, default = 75
-T {comma-separated values} : Sets the percent identity cutoff to be classified at a certain taxonomic level
                              By default, these values are specified by the database used.
                              Order of the values is:         Kingdom/Domain,Phylum,Class,Order,Family,Genus,Species
                              Default values for the SSU are: 0,60,70,75,85,90,97
-H {value} : The number of points that the Metaxa Extractor prediction is given, default is the same as the number of sequences (-M option)
--selection_priority {score, domains, eval, sum} : Selects what will be of highest priority when determining the origin of the sequence, default is score
--scoring_model {new, old} : Selects the scoring model to be used for classification, select 'old' to use the pre 2.2 scoring model, default = new
--search_eval {value} : The E-value cutoff used in the HMMER search, high numbers may slow down the process, cannot be used with the --search_score option, default is to use score cutoff, not E-value
--search_score {value} : The score cutoff used in the HMMER search, low numbers may slow down the process, cannot be used with the --search_eval option, default = 0
--blast_eval {value} : The E-value cutoff used in the BLAST search, high numbers may slow down the process, cannot be used with the --blast_score option, default is 1e-5
--blast_score {value} : The score cutoff used in the BLAST search, low numbers may slow down the process, cannot be used with the --blast_eval option, default is to used E-value cutoff, not score
--blast_wordsize {value} : The word-size used for the BLAST-based classification, default is 14
--allow_single_domain {e-value,score or F} : Allow inclusion of sequences that only find a single domain, given that they satisfy the given E-value and score thresholds, on with parameters 1e-10,0 by default
--allow_reorder {T or F} : Allows profiles to be in the wrong order on extracted sequences, on (T) by default
--complement {T or F} : Checks both DNA strands against the database, creating reverse complements, on (T) by default
--cpu {value} : The number of CPU threads to use, default is 1
--multi_thread {T or F} : Multi-thread the HMMER-search, on (T) if number of CPUs (--cpu option > 1), else off (F) by default
--heuristics {T or F} : Selects whether to use HMMER's heuristic filtering, on (T) by default
--megablast {T or F} : Uses megablast for classification for better speed but less accuracy, off (F) by default
--reference {file} : A file in FASTA format containing reference sequences to be sent to a separate file in the analysis, default is blank (unused)
--ref_identity {value} : The sequence identity cutoff to be considered a sequence to be derived from a reference entry, default = 99

Output options:
--summary {T or F} : Summary of results output, on (T) by default
--graphical {T or F} : 'Graphical' output, on (T) by default
--fasta {T or F} : FASTA-format output of extracted rRNA sequences, on (T) by default
--split_pairs {T or F} : Outputs the two read pairs separately instead of as a joint rRNA sequence, off (F) by default
--table {T or F} : Table format output of sequences containing probable rRNAs, off (F) by default
--taxonomy {T or F} : Table format output of probable taxonomic origin for sequences, on (T) by default
--reltax {T or F} : Output of probable taxonomic origin for sequences with reliability scores at each rank, off (F) by default
--taxlevel {integer} : Force Metaxa to classify sequences at a certain taxonomy level, regardless of reliability score, off (0) by default
--not_found {T or F} : Saves a list of non-found entries, off (F) by default
--align {a, all, u, uncertain, n, none} : Outputs alignments of BLAST matches to query in all, uncertain or no cases, requires MAFFT to be installed, default is 'none'
--truncate {T or F} : Truncates the FASTA output to only contain the putative rRNA sequence found, on (T) by default
--guess_species {T or F} : Writes a species guess (which can be pretty far off) to the FASTA definition line, off (F) by default (depreciated option, use --taxonomy instead)
--silent {T or F} : Supresses printing progress info to stderr, off (F) by default
--graph_scale {value} : Sets the scale of the graph output, if value is zero, a percentage view is shown, default = 0
--save_raw {T or F} : saves all raw data for searches etc. instead of removing it on finish, off (F) by default

-h : displays short usage information
--help : displays this help message
--bugs : displays the bug fixes and known bugs in this version of Metaxa
--license : displays licensing information
-----------------------------------------------------------------
```


## metaxa_metaxa2_dbb

### Tool Description
Metaxa2 Database Builder - builds a classification database for Metaxa2 from reference sequences and taxonomic information.

### Metadata
- **Docker Image**: quay.io/biocontainers/metaxa:2.2.3--pl5321hdfd78af_2
- **Homepage**: http://microbiology.se/software/metaxa2/
- **Package**: https://anaconda.org/channels/bioconda/packages/metaxa/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: metaxa2_dbb -i <input file> -o <output file>
Options:
-i {file} : DNA FASTA file containing the reference sequences of a single gene to be used for classification (overrides specific input options below)
-o {directory} : Directory name for the output files
-g {string} : Gene name for the database
-p {directory} : Use HMMs from the specified directory instead of computing new ones (i.e. only build a new classification database), not used by default
-t {file} : Taxonomy file containing taxonomic information to be parsed in any of the following formats:
            Metaxa2, FASTA, ASN1, NCBI XML, INSD XML
-r {sequence_ID} : ID of the sequence that should be used as the representative sequence of the gene
                   if blank, the first sequence in the input file is used
--auto_rep {T or F} : Choose a reference sequence automatically (requires Usearch to be installed), on (T) by default
--cpu {integer} : Number of CPUs to use (will be passed on to other programs), default = 1
--save_raw {T or F} : Keep intermediate files after the program finishes, off (F) by default
--plus {T or F} : Use BLAST+ instead of legacy BLAST, off (F) by default


-a {file} : DNA FASTA file containing archaeal reference sequences to be used for classification (cannot be combined with the -i option)
-b {file} : DNA FASTA file containing bacterial reference sequences to be used for classification (cannot be combined with the -i option)
-c {file} : DNA FASTA file containing chloroplast reference sequences to be used for classification (cannot be combined with the -i option)
-e {file} : DNA FASTA file containing eukaryote reference sequences to be used for classification (cannot be combined with the -i option)
-m {file} : DNA FASTA file containing mitochondrial reference sequences to be used for classification (cannot be combined with the -i option)
-n {file} : DNA FASTA file containing metazoan mitochondrial reference sequences to be used for classification (cannot be combined with the -i option)
--other {file} : DNA FASTA file containing reference sequences of other origins to be used for classification (cannot be combined with the -i option)

--full_length {integer} : number of basepairs to use for full-length definition (set to zero to disable full-length extraction), default = 100
-C {integer} : Conservation score cutoff, 4 by default, not used unless -A is set to false (F)
-N {ratio} : Noise cutoff (minimal proportion of sequences required to be considered at each position). A number between 0 and 1, 0.1 by default
-A {T or F} : Auto-detect conservation score cutoff, on (T) by default
-P {ratio} : Minimal conserved proportion of the alignment (until a lower conservation cutoff is considered), 0.6 by default
-L {integer} : Look-ahead length (the number of residues to consider when determining the start and end of conserved regions), 5 by default
-M {integer} : Minimal conserved region length, 20 by default
--single_profile {T or F} : Build only one single HMM for the entire alignment from the input sequences, off (F) by default
--mode {divergent, conserved, hybrid} : Selects the mode in which the profile database is built, default is divergent
--dereplicate {ratio or F} : Will dereplicate the input data using Usearch before building the database, using the specified idenity threshold, off (F) by default

--filter_uncultured {T or F} : Will try to filter out sequences that are derived from uncultured species, off (F) by default
--filter_level {integer} : Will filter out sequences with taxonomic information lower than the specified level, 0 by default
--correct_taxonomy {T or F} : Will try to correct the taxonomic information at order, family, genus and species level, off (F) by default
--cutoffs {string} : A string of number defining the cutoffs at different taxonomic levels. Will turn off automatic calculation of cutoffs. If blank, cutoffs are determined automatically, default is blank (off)
--sample {integer} : The number of sequences to aim to investigate when determining taxonomic cutoffs, 1000 by default

--evaluate {T or F} : Statistically evaluate the performance of the database built. This increases the time requirement for the process dramatically, off (F) by default
--iterations {integer} : Number of iterations for the statistical evaluation, 10 by default
--test_sets {ratio} : Proportion of sequences to leave out for testing. Several values can be specified, separated by commas, 0.1 by default
--db {directory} : Skips building the database, and only runs the evaluation on the specified database, not used by default

-h : displays this help message
--help : displays this help message
--bugs : displays the bug fixes and known bugs in this version of Metaxa
--license : displays licensing information
-----------------------------------------------------------------
```


## metaxa_metaxa2_dc

### Tool Description
Metaxa2 tool for combining multiple Metaxa2 results into a single data matrix.

### Metadata
- **Docker Image**: quay.io/biocontainers/metaxa:2.2.3--pl5321hdfd78af_2
- **Homepage**: http://microbiology.se/software/metaxa2/
- **Package**: https://anaconda.org/channels/bioconda/packages/metaxa/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: metaxa2_dc -o <output file> <input files>
Options:
Arguments not associated with an option flag will be interpreted as file names
-o {file} : Output file
-t {integer} : Column containing taxon data, default = 0
-c {integer} : Column containing count data, default = 1

-r {string} : String to be removed from the file name for use as sample name. Regular expressions can be used. Default = '.level_[0-9].txt'
-p {string} : Regular expression pattern for selecting the sample name from the file name. Default = '.*' (will cover full file name)

-h : displays short usage information
--help : displays this help message
--bugs : displays the bug fixes and known bugs in this version of Metaxa
--license : displays licensing information
-----------------------------------------------------------------
```


## Metadata
- **Skill**: generated
