# bamm CWL Generation Report

## bamm_make

### Tool Description
make a BAM/TAM file (sorted + indexed)

### Metadata
- **Docker Image**: quay.io/biocontainers/bamm:1.7.3--py312hdcc493e_15
- **Homepage**: https://github.com/Ecogenomics/BamM
- **Package**: https://anaconda.org/channels/bioconda/packages/bamm/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bamm/overview
- **Total Downloads**: 14.0K
- **Last updated**: 2025-09-16
- **GitHub**: https://github.com/Ecogenomics/BamM
- **Stars**: N/A
### Original Help Text
```text
usage: bamm make -d DATABASE [-i INTERLEAVED [INTERLEAVED ...]]
                 [-c COUPLED [COUPLED ...]] [-s SINGLE [SINGLE ...]]
                 [-p PREFIX] [-o OUT_FOLDER]
                 [--index_algorithm INDEX_ALGORITHM]
                 [--alignment_algorithm ALIGNMENT_ALGORITHM] [--extras EXTRAS]
                 [-k] [-K] [-f] [--output_tam] [-u] [-t THREADS] [-m MEMORY]
                 [--temporary_directory TEMPORARY_DIRECTORY] [-h]
                 [--show_commands] [--quiet] [--silent]

make a BAM/TAM file (sorted + indexed)

required argument:
  -d DATABASE, --database DATABASE
                        contigs to map onto (in fasta format)

reads to map (specify one or more arguments):
  -i INTERLEAVED [INTERLEAVED ...], --interleaved INTERLEAVED [INTERLEAVED ...]
                        map interleaved sequence files (as many as you like) EX: -i reads1_interleaved.fq.gz reads2_interleaved.fna
  -c COUPLED [COUPLED ...], --coupled COUPLED [COUPLED ...]
                        map paired sequence files (as many sets as you like) EX: -c reads1_1.fq.gz reads1_2.fq.gz reads2_1.fna reads2_2.fna
  -s SINGLE [SINGLE ...], --single SINGLE [SINGLE ...]
                        map Single ended sequence files (as many as you like) EX: -s reads1_singles.fq.gz reads2_singles.fna

optional arguments:
  -p PREFIX, --prefix PREFIX
                        prefix to apply to BAM/TAM files (None for reference name)
  -o OUT_FOLDER, --out_folder OUT_FOLDER
                        write to this folder (default: .)
  --index_algorithm INDEX_ALGORITHM
                        algorithm bwa uses for indexing 'bwtsw' or 'is' [None for auto]
  --alignment_algorithm ALIGNMENT_ALGORITHM
                        algorithm bwa uses for alignment 'mem', 'bwasw' or 'aln' (default: mem)
  --extras EXTRAS       extra arguments to use during mapping. Format is "<BWA_MODE1>:'<ARGS>',<BWA_MODE2>:'<ARGS>'"
  -k, --keep            keep all generated database index files (see also --kept)
  -K, --kept            assume database indices already exist (e.g. previously this script was run with -k/--keep)
  -f, --force           force overwriting of index files if they are present
  --output_tam          output TAM file instead of BAM file
  -u, --keep_unmapped   Keep unmapped reads in BAM output
  -t THREADS, --threads THREADS
                        maximum number of threads to use (default: 1)
  -m MEMORY, --memory MEMORY
                        maximum amount of memory to use per samtools sort thread (default 2GB). Suffix K/M/G recognized
  --temporary_directory TEMPORARY_DIRECTORY
                        temporary directory for working with BAM files (default do not use)
  -h, --help            show this help message and exit
  --show_commands       show all commands being run
  --quiet               suppress output from the mapper
  --silent              suppress all output

Example usage:

 Produce a sorted, indexed BAM file with reads mapped onto contigs.fa using 40 threads
   bamm make -d contigs.fa -i reads1_interleaved.fq.gz reads2_interleaved.fq.gz -c reads3_1.fq.gz reads3_2.fq.gz -t 40

 Produce a 3 sorted, indexed BAM files with reads mapped onto contigs.fa.gz
   bamm make -d contigs.fa.gz -i reads1_interleaved.fq.gz reads2_interleaved.fq.gz -s reads4_singles.fq.gz

Extra arguments are passed on a "per-mode" basis using the format:

    <BWA_MODE>:'<ARGS>'

For example, the argument:

    --extras "mem:-k 25"

tells bwa mem to use a minimum seed length of 25bp.
Multiple modes are separated by commas. For example:

    --extras "aln:-O 12 -E 3,sampe:-n 15"

Passes the arguments "-O 12 -E 3" to bwa aln and the arguments "-n 15" to bwa sampe.

********************************************************************************
*** WARNING ***
********************************************************************************

Values passed using --extras are not checked by BamM. This represents a
significant security risk if BamM is being run with elevated privileges.
Thus you should NEVER run 'bamm make' as root or some other powerful user,
ESPECIALLY if you are providing access to multiple / unknown users.

********************************************************************************
```


## bamm_parse

### Tool Description
get bamfile type and/or coverage profiles and/or linking reads

### Metadata
- **Docker Image**: quay.io/biocontainers/bamm:1.7.3--py312hdcc493e_15
- **Homepage**: https://github.com/Ecogenomics/BamM
- **Package**: https://anaconda.org/channels/bioconda/packages/bamm/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bamm parse -b BAMFILES [BAMFILES ...] [-c COVERAGES] [-l LINKS]
                  [-i INSERTS] [-n NUM_TYPES [NUM_TYPES ...]]
                  [-m {pmean,opmean,tpmean,counts,cmean,pmedian,pvariance,ppc,tppc}]
                  [-r CUTOFF_RANGE [CUTOFF_RANGE ...]] [--length LENGTH]
                  [--base_quality BASE_QUALITY]
                  [--mapping_quality MAPPING_QUALITY]
                  [--max_distance MAX_DISTANCE] [--use_secondary]
                  [--use_supplementary] [-v] [-t THREADS] [-h]

get bamfile type and/or coverage profiles and/or linking reads

required argument:
  -b BAMFILES [BAMFILES ...], --bamfiles BAMFILES [BAMFILES ...]
                        bam files to parse

optional arguments:
  -c COVERAGES, --coverages COVERAGES
                        filename to write coverage profiles to [default: don't calculate coverage]
  -l LINKS, --links LINKS
                        filename to write pairing links to [default: don't calculate links]
  -i INSERTS, --inserts INSERTS
                        filename to write bamfile insert distributions to [default: print to STDOUT]
  -n NUM_TYPES [NUM_TYPES ...], --num_types NUM_TYPES [NUM_TYPES ...]
                        number of insert/orientation types per BAM
  -m {pmean,opmean,tpmean,counts,cmean,pmedian,pvariance,ppc,tppc}, --coverage_mode {pmean,opmean,tpmean,counts,cmean,pmedian,pvariance,ppc,tppc}
                        how to calculate coverage (requires --coverages) (default: pmean)
  -r CUTOFF_RANGE [CUTOFF_RANGE ...], --cutoff_range CUTOFF_RANGE [CUTOFF_RANGE ...]
                        range used to calculate upper and lower bounds when calculating coverage
  --length LENGTH       minimum Q length (default: 50)
  --base_quality BASE_QUALITY
                        base quality threshold (Qscore) (default: 20)
  --mapping_quality MAPPING_QUALITY
                        mapping quality threshold
  --max_distance MAX_DISTANCE
                        maximum allowable edit distance from query to reference (default: 1000)
  --use_secondary       use reads marked with the secondary flag
  --use_supplementary   use reads marked with the supplementary flag
  -v, --verbose         be verbose
  -t THREADS, --threads THREADS
                        maximum number of threads to use (default: 1)
  -h, --help            show this help message and exit

Example usage:

 Calculate insert distribution, print to STDOUT
   bamm parse -b my.bam

 Calculate contig-wise coverage
   bamm parse -b my.bam -c output_coverage.tsv

 Calculate linking information on 2 bam files
   bamm parse -b first.bam second.bam -l output_links.tsv

Coverage calculation modes:
* opmean:    outlier pileup coverage: average of reads overlapping each base,
             after bases with coverage outside mean +/- 1 standard deviation
             have been excluded. The number of standard deviation used for the
             cutoff can be changed with --cutoff_range.
* pmean:     pileup coverage: average of number of reads overlapping each base
* tpmean:    trimmed pileup coverage: average of reads overlapping each base,
             after bases with in the top and bottom 10% have been excluded. The
             10% range can be changed using --cutoff_range and should be
             specified as a percentage (e.g., 15 for 15%).
* counts:    absolute number of reads mapping
* cmean:     like 'counts' except divided by the length of the contig
* pmedian:   median pileup coverage: median of number of reads overlapping each
             base
* pvariance: variance of pileup coverage: variance of number of reads
             overlapping each base
* ppc:       percentage of bases covered by pileup
* tppc:      percentage of trimmed bases coverged by pileup (see tpmean)

The 'cutoff_range' variable is used for trimmed mean and outlier mean. This
parameter takes at most two values. The first is the lower cutoff and the
second is the upper. If only one value is supplied then lower == upper.
```


## bamm_extract

### Tool Description
Extract reads which hit the given references

### Metadata
- **Docker Image**: quay.io/biocontainers/bamm:1.7.3--py312hdcc493e_15
- **Homepage**: https://github.com/Ecogenomics/BamM
- **Package**: https://anaconda.org/channels/bioconda/packages/bamm/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bamm extract -b BAMFILES [BAMFILES ...] -g GROUPS [GROUPS ...]
                    [-p PREFIX] [-o OUT_FOLDER] [--mix_bams] [--mix_groups]
                    [--mix_reads] [--interleave]
                    [--mapping_quality MAPPING_QUALITY] [--use_secondary]
                    [--use_supplementary] [--max_distance MAX_DISTANCE]
                    [--no_gzip] [--headers_only] [-v] [-t THREADS] [-h]

Extract reads which hit the given references

required arguments:
  -b BAMFILES [BAMFILES ...], --bamfiles BAMFILES [BAMFILES ...]
                        bam files to parse
  -g GROUPS [GROUPS ...], --groups GROUPS [GROUPS ...]
                        files containing reference names (1 per line) or contigs file in fasta format

optional arguments:
  -p PREFIX, --prefix PREFIX
                        prefix to apply to output files
  -o OUT_FOLDER, --out_folder OUT_FOLDER
                        write to this folder (default: .)
  --mix_bams            use the same file for multiple bam files
  --mix_groups          use the same files for multiple groups
  --mix_reads           use the same files for paired/unpaired reads
  --interleave          interleave paired reads in ouput files
  --mapping_quality MAPPING_QUALITY
                        mapping quality threshold
  --use_secondary       use reads marked with the secondary flag
  --use_supplementary   use reads marked with the supplementary flag
  --max_distance MAX_DISTANCE
                        maximum allowable edit distance from query to reference (default: 1000)
  --no_gzip             do not gzip output files
  --headers_only        extract only (unique) headers
  -v, --verbose         be verbose
  -t THREADS, --threads THREADS
                        maximum number of threads to use (default: 1)
  -h, --help            show this help message and exit
```


## bamm_filter

### Tool Description
Apply stringency filter to Bam file reads

### Metadata
- **Docker Image**: quay.io/biocontainers/bamm:1.7.3--py312hdcc493e_15
- **Homepage**: https://github.com/Ecogenomics/BamM
- **Package**: https://anaconda.org/channels/bioconda/packages/bamm/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bamm filter -b BAMFILE [-o OUT_FOLDER]
                   [--mapping_quality MAPPING_QUALITY]
                   [--max_distance MAX_DISTANCE] [--length LENGTH]
                   [--percentage_id PERCENTAGE_ID]
                   [--percentage_aln PERCENTAGE_ALN] [--use_secondary]
                   [--use_supplementary] [-v] [-h]

Apply stringency filter to Bam file reads

required arguments:
  -b BAMFILE, --bamfile BAMFILE
                        bam file to filter

optional arguments:
  -o OUT_FOLDER, --out_folder OUT_FOLDER
                        write to this folder (output file has '_filtered.bam' suffix) (default: .)
  --mapping_quality MAPPING_QUALITY
                        mapping quality threshold
  --max_distance MAX_DISTANCE
                        maximum allowable edit distance from query to reference (default: 1000)
  --length LENGTH       minimum allowable query length
  --percentage_id PERCENTAGE_ID
                        minimum base identity of mapped region (between 0 and 1)
  --percentage_aln PERCENTAGE_ALN
                        minimum fraction of read mapped (between 0 and 1)
  --use_secondary       use reads marked with the secondary flag
  --use_supplementary   use reads marked with the supplementary flag
  -v, --invert_match    select unmapped reads
  -h, --help            show this help message and exit
```

