# mimodd CWL Generation Report

## mimodd_info

### Tool Description
Show information about the input file

### Metadata
- **Docker Image**: quay.io/biocontainers/mimodd:0.1.9--py35_0
- **Homepage**: http://sourceforge.net/projects/mimodd
- **Package**: https://anaconda.org/channels/bioconda/packages/mimodd/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mimodd/overview
- **Total Downloads**: 21.2K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage:  info [-h] [-o OFILE] [-v] [--oformat html|txt] input file

positional arguments:
  input file            input file (supported formats: sam, bam, vcf, bcf,
                        fasta)

optional arguments:
  -h, --help            show this help message and exit
  -o OFILE, --ofile OFILE
                        redirect the output to the specified file (default:
                        stdout)
  -v, --verbose         verbose output
  --oformat html|txt    format for the output (default: txt)
```


## mimodd_header

### Tool Description
Add or modify header information in BAM/SAM/CRAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/mimodd:0.1.9--py35_0
- **Homepage**: http://sourceforge.net/projects/mimodd
- **Package**: https://anaconda.org/channels/bioconda/packages/mimodd/overview
- **Validation**: PASS

### Original Help Text
```text
usage:  header [-h] [--rg-id RG_ID [RG_ID ...]] [--rg-sm RG_SM [RG_SM ...]]
               [--rg-cn RG_CN [RG_CN ...]] [--rg-ds RG_DS [RG_DS ...]]
               [--rg-dt RG_DT [RG_DT ...]] [--rg-lb RG_LB [RG_LB ...]]
               [--rg-pl RG_PL [RG_PL ...]] [--rg-pi RG_PI [RG_PI ...]]
               [--rg-pu RG_PU [RG_PU ...]] [--co [COMMENT [COMMENT ...]]]
               [-o OFILE] [-x]

optional arguments:
  -h, --help            show this help message and exit
  -o OFILE, --ofile OFILE
                        redirect the output to the specified file (default:
                        stdout)
  -x, --relaxed         do not enforce a sample name to be specified for every
                        read group

read group description:
  --rg-id RG_ID [RG_ID ...]
                        one or more unique read group identifiers
  --rg-sm RG_SM [RG_SM ...]
                        one sample name per read group identifier
  --rg-cn RG_CN [RG_CN ...]
                        one sequencing center name per read group
  --rg-ds RG_DS [RG_DS ...]
                        one description line per read group
  --rg-dt RG_DT [RG_DT ...]
                        date runs were produced (YYYY-MM-DD); one date per
                        read group
  --rg-lb RG_LB [RG_LB ...]
                        library identifier for each read group
  --rg-pl RG_PL [RG_PL ...]
                        sequencing platform/technology used to produce each
                        read group
  --rg-pi RG_PI [RG_PI ...]
                        predicted median insert size for the reads of each
                        read group
  --rg-pu RG_PU [RG_PU ...]
                        platform unit, e.g., flowcell barcode or slide
                        identifier, for each read group

other information:
  --co [COMMENT [COMMENT ...]]
                        an arbitrary number of one-line comment strings
```


## mimodd_convert

### Tool Description
Convert between various sequence file formats.

### Metadata
- **Docker Image**: quay.io/biocontainers/mimodd:0.1.9--py35_0
- **Homepage**: http://sourceforge.net/projects/mimodd
- **Package**: https://anaconda.org/channels/bioconda/packages/mimodd/overview
- **Validation**: PASS

### Original Help Text
```text
usage:  convert [--help] [--iformat {fastq,fastq_pe,gz,gz_pe,sam,bam}]
                [-o OFILE] [--oformat {sam,bam,fastq,gz}] [-h HEADER] [-r]
                [-t THREADS]
                input_files) [input_file(s ...]

positional arguments:
  input_file(s)         a list of input files (alternating r1 and r2 files for
                        paired-end data

optional arguments:
  --help                show this help message and exit
  --iformat {fastq,fastq_pe,gz,gz_pe,sam,bam}
                        the format of the input file(s) (default: bam)
  -o OFILE, --ofile OFILE
                        redirect the output to the specified file (default:
                        stdout)
  --oformat {sam,bam,fastq,gz}
                        the output format (default: sam)
  -h HEADER, --header HEADER
                        optional SAM file, the header information of which
                        should be used in the output (will overwrite pre-
                        existing header information from the input file); not
                        allowed for input in SAM/BAM format
  -r, --split-on-rgs    if the input file has reads from different read
                        groups, write them to separate output files (using
                        --ofile OFILE as a file name template); implied for
                        conversions to fastq format
  -t THREADS, --threads THREADS
                        the number of threads to use (overrides config
                        setting; ignored if not applicable to the conversion)
```


## mimodd_reheader

### Tool Description
Reheader a BAM file using a template SAM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/mimodd:0.1.9--py35_0
- **Homepage**: http://sourceforge.net/projects/mimodd
- **Package**: https://anaconda.org/channels/bioconda/packages/mimodd/overview
- **Validation**: PASS

### Original Help Text
```text
usage:  reheader [-h] [--rg ignore|update|replace [RG_TEMPLATE]
                 [RG_MAPPING ...]] [--sq ignore|update|replace [SQ_TEMPLATE]
                 [SQ_MAPPING ...]]
                 [--co ignore|update|replace [CO_TEMPLATE ...]]
                 [--rgm RG_MAPPING [RG_MAPPING ...]]
                 [--sqm SQ_MAPPING [SQ_MAPPING ...]] [-o OFILE] [-H] [-v]
                 [template] input_file

positional arguments:
  template              template SAM file providing header information
  input_file            input BAM file to reheader

optional arguments:
  -h, --help            show this help message and exit
  --rg ignore|update|replace [RG_TEMPLATE] [RG_MAPPING ...]
                        how to compile the read group section of the new
                        header; ignore: do not use template information ->
                        keep original read groups, update: use template
                        information to update original header content,
                        replace: use only template read group information ->
                        discard original (default: replace if a general
                        template is specified, ignore if not); the optional
                        RG_TEMPLATE is used instead of the general template to
                        provide the template read group information; by
                        default, update mode uses template information about
                        read-groups to add to / overwrite the original
                        information of read-groups with the same ID, keeps all
                        read-groups found only in the original header and adds
                        read-groups found only in the template; replace
                        overwrites all original information about a read-group
                        if a read-group with the same ID is found in the
                        template, discards all read-groups found only in the
                        original header and adds read-groups found only in the
                        template; to update or replace the information of a
                        read group with that of a template read-group with a
                        different ID, a RG_MAPPING between old and new ID
                        values can be provided in the format old_id : new_id
                        [old_id : new_id, ..]
  --sq ignore|update|replace [SQ_TEMPLATE] [SQ_MAPPING ...]
                        how to compile the sequence dictionary of the new
                        header; ignore: do not use template information ->
                        keep original sequence dictionary, update: use
                        template information to update original header
                        content, replace: use only template sequence
                        information -> discard original (default: replace if a
                        general template is specified, ignore if not); the
                        optional SQ_TEMPLATE is used instead of the general
                        template to provide the template sequence dictionary;
                        by default, update mode uses template sequence
                        information to add to / overwrite the original
                        information of sequences with the same name (SN tag
                        value), keeps all sequences found only in the original
                        header and adds sequences found only in the template;
                        replace overwrites all original information about a
                        sequence if a sequence with the same name is found in
                        the template, discards all sequences found only in the
                        original header and adds sequences found only in the
                        template; to update or replace the information about a
                        sequence with that of a template sequence with a
                        different name, a SQ_MAPPING between old and new
                        sequence names (SN values) can be provided in the
                        format old_sn : new_sn [old_sn : new_sn, ..]; to
                        protect against file format corruption, the tool will
                        NEVER modify the recorded LENGTH (LN tag) nor the MD5
                        checksum (M5 tag) of any sequence
  --co ignore|update|replace [CO_TEMPLATE ...]
                        how to compile the comments (CO lines) of the new
                        header; ignore: do not use template comments -> keep
                        original comments, update: append template comment
                        lines to original comments, replace: use only template
                        comments -> discard original (default: replace if a
                        general template is specified, ignore if not); the
                        optional CO_TEMPLATE is used instead of the general
                        template to provide the template comments
  --rgm RG_MAPPING [RG_MAPPING ...]
                        optional mapping between read group ID values in the
                        format old_id : new_id [old_id : new_id, ..]; used to
                        rename read groups and applied AFTER any other
                        modifications to the read group section (i.e., every
                        old_id must exist in the modified header)
  --sqm SQ_MAPPING [SQ_MAPPING ...]
                        optional mapping between sequence names (SN field
                        values) in the format old_sn : new_sn [old_sn :
                        new_sn, ..]; used to rename sequences in the sequence
                        dictionary and applied AFTER any other modifications
                        to the sequence dictionary (i.e., every old_sn must
                        exist in the modified header)
  -o OFILE, --ofile OFILE
                        redirect the output to the specified file (default:
                        stdout)
  -H                    output only the resulting header
  -v, --verbose
```


## mimodd_sort

### Tool Description
Sorts SAM/BAM files by read name.

### Metadata
- **Docker Image**: quay.io/biocontainers/mimodd:0.1.9--py35_0
- **Homepage**: http://sourceforge.net/projects/mimodd
- **Package**: https://anaconda.org/channels/bioconda/packages/mimodd/overview
- **Validation**: PASS

### Original Help Text
```text
usage:  sort [-h] [-o OFILE] [--iformat bam|sam] [--oformat bam|sam] [-n]
             [-l COMPRESSION_LEVEL] [-m MEMORY] [-t THREADS]
             input_file

positional arguments:
  input_file            the unsorted input file in SAM/BAM format

optional arguments:
  -h, --help            show this help message and exit
  -o OFILE, --ofile OFILE
                        redirect the output to the specified file (default:
                        stdout)
  --iformat bam|sam     the format of the input file (default: assume bam)
  --oformat bam|sam     specify whether the output should be in sam or bam
                        format (default: bam)
  -n, --by-name         sort by read name
  -l COMPRESSION_LEVEL  compression level, from 0 to 9
  -m MEMORY, --memory MEMORY
                        maximal amount of memory to be used in GB (overrides
                        config setting)
  -t THREADS, --threads THREADS
                        the number of threads to use (overrides config
                        setting)
```


## mimodd_index

### Tool Description
Index generation tool for various formats.

### Metadata
- **Docker Image**: quay.io/biocontainers/mimodd:0.1.9--py35_0
- **Homepage**: http://sourceforge.net/projects/mimodd
- **Package**: https://anaconda.org/channels/bioconda/packages/mimodd/overview
- **Validation**: PASS

### Original Help Text
```text
usage:  index [--help] [-o PATH] [-t THREADS] [-q] [-v] [-s SEEDSIZE]
              [-h SLACK] [-O FACTOR]
              INDEX_TYPE FILE_TO_INDEX

positional arguments:
  INDEX_TYPE            the type of index to be generated; use "snap" to
                        create a reference genome index for the snap alignment
                        tool, "fai" to produce a samtools-style reference
                        index, "bai" for a bam file index that can be used,
                        e.g., with the varcall tool and is required by third-
                        party tools like IGV.
  FILE_TO_INDEX         the fasta (reference genome) or bam (aligned reads)
                        input file to index

optional arguments:
  --help                show this help message and exit
  -o PATH, --output PATH
                        specifies the location at which to save the index
                        (default: save the index alongside the input file as
                        <input file>.<INDEX_TYPE> for indices of type "fai"
                        and "bai", or in a directory <input file>.snap_index)
  -t THREADS, --threads THREADS
                        maximum number of threads to use (overrides config
                        setting)
  -q, --quiet           suppress original messages from underlying tools
  -v, --verbose         verbose output

snap-specific options:
  -s SEEDSIZE, --seedsize SEEDSIZE, --idx-seedsize SEEDSIZE
                        Seed size used in building the index (default: 20)
  -h SLACK, --slack SLACK, --idx-slack SLACK
                        Hash table slack for indexing (default: 0.3)
  -O FACTOR, --overflow FACTOR, --idx-overflow FACTOR
                        factor (between 1 and 1000) to set the size of the
                        index build overflow space (default: 40)
```


## mimodd_snap

### Tool Description
Sequencing mode reference genome or index directory input files

### Metadata
- **Docker Image**: quay.io/biocontainers/mimodd:0.1.9--py35_0
- **Homepage**: http://sourceforge.net/projects/mimodd
- **Package**: https://anaconda.org/channels/bioconda/packages/mimodd/overview
- **Validation**: PASS

### Original Help Text
```text
usage:  snap [--help] [-o OFILE] [--iformat IFORMAT] [--oformat OFORMAT]
             [--header HEADER] [-t THREADS] [-m MEMORY] [--no-sort] [-q] [-v]
             [-D [RF|FR|FF|RR|ALL [RF|FR|FF|RR|ALL ...]]] [-s MIN MAX]
             [-d EDIT DISTANCE] [-n SEEDS] [-h HITS] [-c THRESHOLD]
             [-a THRESHOLD] [-e] [-x] [-f] [-F FILTER] [-I] [-S SELECTIVITY]
             [-C ++|+x|x+|xx] [-G PENALTY] [-X | -M] [--sort]
             [--idx-seedsize SEED SIZE] [--idx-slack SLACK]
             [--idx-overflow FACTOR] [--idx-out INDEX DIR] [-P] [-b]
             sequencing mode reference genome or index directory input files)
             [input file(s ...]

positional arguments:
  sequencing mode       specify "single" or "paired" to indicate the
                        sequencing mode
  reference genome or index directory
                        an existing index directory generated by snap_index or
                        a fasta reference genome (will be used to create the
                        index)
  input file(s)         one or two (in "paired" mode with "fastq" input
                        format) input files

optional arguments:
  --help                show this help message and exit
  -o OFILE, --ofile OFILE
                        name of the output file (required)
  --iformat IFORMAT     input file format; must be fastq, gz, sam or bam
                        (default: bam)
  --oformat OFORMAT     output file format (sam or bam; default: bam)
  --header HEADER       a SAM file providing header information to be used for
                        the output (required for input in fastq format and
                        with unheadered SAM/BAM input, optional for headered
                        SAM/BAM input; replaces header information found in
                        the input file
  -t THREADS, --threads THREADS
                        number of threads to use (overrides config setting)
  -m MEMORY, --memory MEMORY
                        maximal amount of memory to be used in GB (overrides
                        config setting); will be respected during sorting only
  --no-sort             output reads in their original order, i.e., do not
                        sort by alignment location
  -q, --quiet           suppress original messages from SNAP
  -v, --verbose         verbose output (independent of SNAP)
  -X                    CIGAR strings in the output should use = and X to
                        indicate matches/mismatches rather than M (alignment
                        match); USE OF THIS OPTION IS DISCOURAGED as =/X CIGAR
                        strings are still not fully supported by useful third-
                        party tools like IGV
  -M, --mmatch-notation
                        legacy option retained for backwards compatibility;
                        indicates that CIGAR strings in the output should use
                        M (alignment match) rather than = and X (sequence
                        (mis-)match); -M is implied by default, use -X to turn
                        off
  --sort, --so          legacy option retained for backwards compatibility;
                        sort output file by alignment location; implied by
                        default, use --no-sort to turn off

optional arguments affecting paired-end reads alignment:
  -D [RF|FR|FF|RR|ALL [RF|FR|FF|RR|ALL ...]], --discard-overlapping-mates [RF|FR|FF|RR|ALL [RF|FR|FF|RR|ALL ...]]
                        consider overlapping mate pairs of the given
                        orientation type(s) anomalous and discard them;
                        default: keep all overlapping mate pairs
  -s MIN MAX, --spacing MIN MAX
                        min and max spacing to allow between paired ends
                        (default: 100 10000)

optional advanced arguments:
  -d EDIT DISTANCE, --maxdist EDIT DISTANCE
                        maximum edit distance allowed per read or pair
                        (default: 8)
  -n SEEDS, --maxseeds SEEDS
                        number of seeds to use per read (default: 25)
  -h HITS, --maxhits HITS
                        maximum hits to consider per seed (default: 250)
  -c THRESHOLD, --confdiff THRESHOLD
                        confidence threshold (default: 2)
  -a THRESHOLD, --confadapt THRESHOLD
                        confidence adaptation threshold (default: 7)
  -e, --error-rep       compute error rate assuming wgsim-generated reads
  -x, --explore         explore some hits of overly popular seeds (useful for
                        filtering)
  -f, --stop-on-first   stop on first match within edit distance limit
                        (filtering mode)
  -F FILTER, --filter-output FILTER
                        retain only certain read classes in output (a=aligned
                        only, s=single hit only, u=unaligned only)
  -I, --ignore          ignore non-matching IDs in the paired-end aligner
  -S SELECTIVITY, --selectivity SELECTIVITY
                        selectivity; randomly choose 1/selectivity of the
                        reads to score
  -C ++|+x|x+|xx, --clipping ++|+x|x+|xx
                        specify a combination of two + or x symbols to
                        indicate whether to clip low-quality bases from the
                        front and back of reads respectively; default: clip
                        from front and back (-C ++)
  -G PENALTY, --gap-penalty PENALTY
                        specify a gap penalty to use when generating CIGAR
                        strings

optional arguments affecting indexing:
  --idx-seedsize SEED SIZE
                        Seed size used in building the index (default: 20)
  --idx-slack SLACK     Hash table slack for indexing (default: 0.3)
  --idx-overflow FACTOR
                        factor (between 1 and 1000) to set the size of the
                        index build overflow space (default: 40)
  --idx-out INDEX DIR   name of the index directory to be created; if given,
                        the index directory will be permanent, otherwise a
                        temporary directory will be used

optional expert arguments for tweaking multithreaded performance:
  -P, --no-prefetch     disables cache prefetching in the genome; may be
                        helpful for machines with small caches or lots of
                        cores/cache
  -b, --bind-threads    bind each thread to its processor (off by default)
```


## mimodd_snap-batch

### Tool Description
Runs multiple snap commands

### Metadata
- **Docker Image**: quay.io/biocontainers/mimodd:0.1.9--py35_0
- **Homepage**: http://sourceforge.net/projects/mimodd
- **Package**: https://anaconda.org/channels/bioconda/packages/mimodd/overview
- **Validation**: PASS

### Original Help Text
```text
usage:  snap-batch [-h] (-s "COMMAND" ["COMMAND" ...] | -f FILE)

optional arguments:
  -h, --help            show this help message and exit
  -s "COMMAND" ["COMMAND" ...]
                        one or more completely specified command line calls to
                        the snap tool (use "" to enclose individual lines)
  -f FILE               an input file of completely specified command line
                        calls to the snap tool
```


## mimodd_varcall

### Tool Description
Call variants from aligned reads

### Metadata
- **Docker Image**: quay.io/biocontainers/mimodd:0.1.9--py35_0
- **Homepage**: http://sourceforge.net/projects/mimodd
- **Package**: https://anaconda.org/channels/bioconda/packages/mimodd/overview
- **Validation**: PASS

### Original Help Text
```text
usage:  varcall [-h] [--index-files INDEX FILE [INDEX FILE ...]] [-o OFILE]
                [-i] [-x] [-d MAX_DEPTH] [-q] [-v] [-t THREADS]
                reference_genome input_files) [input_file(s ...]

positional arguments:
  reference_genome      the reference genome (in fasta format)
  input_file(s)         one or more BAM input files of aligned reads from one
                        or more samples (will be indexed automatically)

optional arguments:
  -h, --help            show this help message and exit
  --index-files INDEX FILE [INDEX FILE ...]
                        pre-computed index files for all input files
  -o OFILE, --ofile OFILE
                        redirect the output (variant sites) to the specified
                        file (default: stdout)
  -i, --group-by-id     optional flag to control handling of multi-sample
                        input; if enabled, reads from different read groups
                        are analyzed as separate samples even if the sample
                        names associated with the read groups are identical;
                        otherwise, the samtools default is used (reads are
                        grouped based on the sample names of their read
                        groups)
  -x, --relaxed         turn off md5 checksum comparison between sequences in
                        the reference genome and those specified in the BAM
                        input file header(s)
  -d MAX_DEPTH, --max-depth MAX_DEPTH
                        average sample depth cap applied to input with
                        extraordinarily large numbers of samples sequenced at
                        high coverage to limit memory usage (default: 250)
  -q, --quiet           suppress original messages from samtools mpileup and
                        bcftools call
  -v, --verbose         verbose output independent of samtools/bcftools
  -t THREADS, --threads THREADS
                        the number of threads to use (overrides config
                        setting)
```


## mimodd_varextract

### Tool Description
Extracts variant sites from BCF files.

### Metadata
- **Docker Image**: quay.io/biocontainers/mimodd:0.1.9--py35_0
- **Homepage**: http://sourceforge.net/projects/mimodd
- **Package**: https://anaconda.org/channels/bioconda/packages/mimodd/overview
- **Validation**: PASS

### Original Help Text
```text
usage:  varextract [-h] [-p VCF_INPUT [VCF_INPUT ...]] [-a] [-v] [-o OFILE]
                   input file

positional arguments:
  input file            BCF output from varcall

optional arguments:
  -h, --help            show this help message and exit
  -p VCF_INPUT [VCF_INPUT ...], --pre-vcf VCF_INPUT [VCF_INPUT ...]
  -a, --keep-alts       keep all alternate allele candidates even if they do
                        not appear in any genotype
  -v, --verbose         verbose output
  -o OFILE, --ofile OFILE
                        redirect the output (variant sites) to the specified
                        file (default: stdout)
```


## mimodd_covstats

### Tool Description
Calculate coverage statistics from BCF files.

### Metadata
- **Docker Image**: quay.io/biocontainers/mimodd:0.1.9--py35_0
- **Homepage**: http://sourceforge.net/projects/mimodd
- **Package**: https://anaconda.org/channels/bioconda/packages/mimodd/overview
- **Validation**: PASS

### Original Help Text
```text
usage:  covstats [-h] [-o OFILE] input file

positional arguments:
  input file            BCF output from varcall

optional arguments:
  -h, --help            show this help message and exit
  -o OFILE, --ofile OFILE
                        redirect the output to the specified file (default:
                        stdout)
```


## mimodd_delcall

### Tool Description
delcall [-h] [--index-files INDEX FILE [INDEX FILE ...]] [-o OFILE] [--max-cov COVERAGE THRESHOLD] [--min-size SIZE THRESHOLD] [-u] [-i] [-v] BAM input files) [BAM input file(s ...] BCF file with coverage information

### Metadata
- **Docker Image**: quay.io/biocontainers/mimodd:0.1.9--py35_0
- **Homepage**: http://sourceforge.net/projects/mimodd
- **Package**: https://anaconda.org/channels/bioconda/packages/mimodd/overview
- **Validation**: PASS

### Original Help Text
```text
usage:  delcall [-h] [--index-files INDEX FILE [INDEX FILE ...]] [-o OFILE]
                [--max-cov COVERAGE THRESHOLD] [--min-size SIZE THRESHOLD]
                [-u] [-i] [-v]
                BAM input files) [BAM input file(s ...] BCF file with coverage
                information

positional arguments:
  BAM input file(s)     one or more BAM input files of aligned reads from one
                        or more samples
  BCF file with coverage information
                        coverage input file (as generated by the varcall tool)

optional arguments:
  -h, --help            show this help message and exit
  --index-files INDEX FILE [INDEX FILE ...]
                        pre-computed index files for all input files
  -o OFILE, --ofile OFILE
                        redirect the output to the specified file (default:
                        stdout)
  --max-cov COVERAGE THRESHOLD
                        maximal coverage allowed at any site within an
                        uncovered region (default: 0)
  --min-size SIZE THRESHOLD
                        minimal size in nts for an uncovered region to be
                        reported (default: 100)
  -u, --include-uncovered
                        include uncovered regions in the output that did not
                        get called as deletions
  -i, --group-by-id     optional flag to control handling of multi-sample
                        input; if enabled, reads from different read groups
                        will be treated strictly separate. If turned off, read
                        groups with identical sample names are used together
                        for identifying uncovered regions, but are still
                        treated separately for the prediction of deletions.
  -v, --verbose         verbose output
```


## mimodd_vcf-filter

### Tool Description
Filters VCF files based on various criteria.

### Metadata
- **Docker Image**: quay.io/biocontainers/mimodd:0.1.9--py35_0
- **Homepage**: http://sourceforge.net/projects/mimodd
- **Package**: https://anaconda.org/channels/bioconda/packages/mimodd/overview
- **Validation**: PASS

### Original Help Text
```text
usage:  vcf-filter [-h] [-o OFILE] [-s SAMPLE_NAME [SAMPLE_NAME ...]]
                   [--gt GT_PATTERN [GT_PATTERN ...]]
                   [--dp DP_THRESHOLD [DP_THRESHOLD ...]]
                   [--gq GQ_THRESHOLD [GQ_THRESHOLD ...]]
                   [--af ALLELE#:MIN_FRACTION:MAX_FRACTION [ALLELE#:MIN_FRACTION:MAX_FRACTION ...]]
                   [-r [REGION_FILTER [REGION_FILTER ...]]] [-I | -i]
                   [--vfilter V_FILTER [V_FILTER ...]]
                   [input_file]

positional arguments:
  input_file            a vcf input file (default: stdin)

optional arguments:
  -h, --help            show this help message and exit
  -o OFILE, --ofile OFILE
                        redirect the output to the specified file (default:
                        stdout)
  -s SAMPLE_NAME [SAMPLE_NAME ...], --samples SAMPLE_NAME [SAMPLE_NAME ...]
                        one or more sample names that the sample-specific
                        filters --gt, --dp, and --gq should work on.
  --gt GT_PATTERN [GT_PATTERN ...]
                        genotype patterns (one per sample, use ANY to skip the
                        requirement for a given sample) to be included in the
                        output; format: x/x where x = 0 and x = 1 stand for
                        the reference and the variant allele, respectively;
                        multiple allowed genotypes for a sample can be
                        specified as a comma-separated list
  --dp DP_THRESHOLD [DP_THRESHOLD ...]
                        minimal coverage (one per sample, use 0 to skip the
                        requirement for a given sample) required to include a
                        site in the output
  --gq GQ_THRESHOLD [GQ_THRESHOLD ...]
                        minimal genotype quality (one per sample, use 0 to
                        skip the requirement for a given sample) required to
                        include a site in the output
  --af ALLELE#:MIN_FRACTION:MAX_FRACTION [ALLELE#:MIN_FRACTION:MAX_FRACTION ...]
                        the fraction of reads supporting a specific ALLELE#
                        must be between MIN_FRACTION and MAX_FRACTION to
                        include the site in the output
  -r [REGION_FILTER [REGION_FILTER ...]], --region [REGION_FILTER [REGION_FILTER ...]]
                        keep only variants that fall in one of the given
                        chromsomal regions (specified in the format
                        CHROM:START-STOP or CHROM: for a whole chromosome)
  -I, --no-indels       skip indels in the output
  -i, --indels-only     keep only indels in the output
  --vfilter V_FILTER [V_FILTER ...]
                        vertical sample names filter; if given, only sample
                        columns specified by name will be retained in the
                        output

Example filters:
-s sample1 --gt 0/1,1/1
		retain all entries of the vcf input file for which
		sample1's genotype is 0/1 (heterozygous) or
		1/1 (homozygous variant)
-s sample1 sample2 --gt 0/1,1/1 0/0
		retain all entries for which sample1's genotype is 0/1 or 1/1
		AND for which sample2's genotype is 0/0
-s sample1 sample2 --gt 0/1,1/1 ANY --dp 3 3
		retain all entries for which sample1's genotype is 0/1 or 1/1
		AND for which sample1 and sample2 show at least 3-fold coverage
		(sample2's genotype doesn't matter)
```


## mimodd_rebase

### Tool Description
Remaps variants from one genome assembly to another using a UCSC chain file.

### Metadata
- **Docker Image**: quay.io/biocontainers/mimodd:0.1.9--py35_0
- **Homepage**: http://sourceforge.net/projects/mimodd
- **Package**: https://anaconda.org/channels/bioconda/packages/mimodd/overview
- **Validation**: PASS

### Original Help Text
```text
usage:  rebase [-h] [-o OFILE] [-r] [-f FILTER] [-v] input_file chain_file

positional arguments:
  input_file            the VCF file to rebase
  chain_file            the UCSC chain file to calculate new coordinates from
                        (the file may be gzipped or uncompressed)

optional arguments:
  -h, --help            show this help message and exit
  -o OFILE, --ofile OFILE
                        redirect the output to the specified file (default:
                        stdout)
  -r, --reverse         swap the genome versions specified in the chain file,
                        i.e., assume the coordinates in the input file are
                        based on the chain file target genome version and
                        should be mapped to the source genome version
  -f FILTER, --filter FILTER
                        define which mapped variants to report: "unique":
                        report only unambiguously mapped variants, "best": for
                        ambiguously mapping variants, report the mapping with
                        the highest score, "all": for ambiguously mapping
                        variants, report all mappings (default: unique)
  -v, --verbose         report remap statistics
```


## mimodd_annotate

### Tool Description
Annotates a VCF file using a specified SnpEff genome annotation.

### Metadata
- **Docker Image**: quay.io/biocontainers/mimodd:0.1.9--py35_0
- **Homepage**: http://sourceforge.net/projects/mimodd
- **Package**: https://anaconda.org/channels/bioconda/packages/mimodd/overview
- **Validation**: PASS

### Original Help Text
```text
usage:  annotate [-h] [-o OFILE] [--codon-tables TABLE_SPEC [TABLE_SPEC ...]]
                 [--stats SUMMARY_FILE] [--no-downstream] [--no-upstream]
                 [--no-intron] [--no-intergenic] [--no-utr] [--ud DISTANCE]
                 [-c PATH] [-m MEMORY] [-q] [-v]
                 input_file annotation_source

positional arguments:
  input_file            a vcf input file
  annotation_source     the name of an installed SnpEff genome annotation file
                        (the snpeff-genomes tool can be used to get a list of
                        all such names)

optional arguments:
  -h, --help            show this help message and exit
  -o OFILE, --ofile OFILE
                        redirect the output to the specified file (default:
                        stdout)
  --codon-tables TABLE_SPEC [TABLE_SPEC ...]
                        specify custom codon tables to be used in assessing
                        variant effects at the protein level; if a codon table
                        should be used for only a specific chromosome, use the
                        format CHROM:TABLE_NAME. Use TABLE_NAME alone to
                        specify a codon table to be used for all chromosomes,
                        for which no chromosome-specific table is provided.
                        Valid TABLE_NAMEs are those defined in the Codon
                        tables section of the SnpEff config file. NOTE: It is
                        also possible to associate chromosomes with a codon
                        table permanently by editing the SnpEff config file.
  --stats SUMMARY_FILE  generate a results summary file of the specified name
  --no-downstream       do not include downstream effects in the output
  --no-upstream         do not include upstream effects in the output
  --no-intron           do not include intron effects in the output
  --no-intergenic       do not include intergenic effects in the output
  --no-utr              do not include UTR effects in the output
  --ud DISTANCE         specify the upstream/downstream interval length, i.e.,
                        variants more than DISTANCE nts from the next
                        annotated gene are considered to be intergenic
  -c PATH, --config PATH
                        location of the SnpEff installation directory. Will
                        override MiModD SNPEFF_PATH config setting if
                        provided.
  -m MEMORY, --memory MEMORY
                        maximal memory to use in GB (overrides config setting)
  -q, --quiet           suppress original messages from SnpEff
  -v, --verbose         verbose output (independent of SnpEff)
```


## mimodd_snpeff-genomes

### Tool Description
Configure MiModD to specify the location of an existing SnpEff installation for use by MiModD.

### Metadata
- **Docker Image**: quay.io/biocontainers/mimodd:0.1.9--py35_0
- **Homepage**: http://sourceforge.net/projects/mimodd
- **Package**: https://anaconda.org/channels/bioconda/packages/mimodd/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/mimodd", line 7, in <module>
    __main__.parse()
  File "/usr/local/lib/python3.5/site-packages/MiModD/__main__.py", line 1197, in parse
    result = funcs[-1](**args)
  File "/usr/local/lib/python3.5/site-packages/MiModD/variant_annotation.py", line 1103, in get_installed_snpeff_genomes
    snpeff_data_dir = get_snpeff_data_dir (snpeff_path)
  File "/usr/local/lib/python3.5/site-packages/MiModD/variant_annotation.py", line 1045, in get_snpeff_data_dir
    snpeff_path = config.snpeff_dir    
  File "/usr/local/lib/python3.5/site-packages/MiModD/config.py", line 100, in snpeff_dir
    Use the --snpeff option of the config tool to specify the location of an existing SnpEff installation for use by MiModD."""
MiModD.DependencyError: You are trying to use SnpEff-dependent functionality, but haven't configured MiModD accordingly.

Use the --snpeff option of the config tool to specify the location of an existing SnpEff installation for use by MiModD.
```


## mimodd_varreport

### Tool Description
Generates a report from a VCF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/mimodd:0.1.9--py35_0
- **Homepage**: http://sourceforge.net/projects/mimodd
- **Package**: https://anaconda.org/channels/bioconda/packages/mimodd/overview
- **Validation**: PASS

### Original Help Text
```text
usage:  varreport [-h] [-o OFILE] [-f html|text] [-s SPECIES]
                  [-l link_formatter_file]
                  input_file

positional arguments:
  input_file            a vcf input file

optional arguments:
  -h, --help            show this help message and exit
  -o OFILE, --ofile OFILE
                        redirect the output to the specified file (default:
                        stdout)
  -f html|text, --oformat html|text
                        the format of the output file (default: html)
  -s SPECIES, --species SPECIES
                        the name of the species to be assumed when generating
                        annotations
  -l link_formatter_file, --link link_formatter_file
                        file to read species-specific hyperlink formatting
                        instructions from
```


## mimodd_map

### Tool Description
MiModD mapping tool for variant analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/mimodd:0.1.9--py35_0
- **Homepage**: http://sourceforge.net/projects/mimodd
- **Package**: https://anaconda.org/channels/bioconda/packages/mimodd/overview
- **Validation**: PASS

### Original Help Text
```text
usage:  map [-h] [-o OFILE] [-q] [-b SIZE [SIZE ...]] [-m sample_name]
            [-r parent_name] [-u parent_name] [-i] [-c sample_name]
            [-t TEXT_FILE] [-s SEQINFO_FILE] [--cloudmap] [-p FILE]
            [--fit-width] [--no-scatter] [-l FLOAT] [--ylim-scatter FLOAT]
            [-z COLOR [COLOR ...]] [-k COLOR [COLOR ...]] [--no-hist]
            [--no-kde] [--ylim-hist FLOAT] [--hist-colors COLOR [COLOR ...]]
            analysis_mode input_file

positional arguments:
  analysis_mode         specify "SVD" for Simple Variant Density analysis,
                        "VAF" for Variant Allele Frequency analysis or "VAC"
                        for Variant Allele Contrast analysis.
  input_file            valid input files are VCF files or per-variant report
                        files (as generated by this tool with the "-t" option
                        or by the CloudMap Hawaiian Variant Density Mapping
                        tool).

optional arguments:
  -h, --help            show this help message and exit
  -o OFILE, --ofile OFILE
                        redirect the binned variant counts to this file
                        (default: stdout).
  -q, --quiet           suppress warning messages about plotting problems.

analysis control:
  -b SIZE [SIZE ...], --bin-sizes SIZE [SIZE ...]
                        list of bin sizes to be used for histogram plots and
                        linkage reports (default: 1Mb and 500Kb)
  -m sample_name, --mapping-sample sample_name
                        name of the sample (as appearing in the input vcf
                        file) for which variants should be mapped (cannot be
                        used in SVD mode)

VAF mode-specific options:
  -r parent_name, --related-parent parent_name
                        name of the sample to provide related parent strain
                        (mutagenesis strain) variants for the analysis in
                        Variant Allele Frequency (VAF) mode.
  -u parent_name, --unrelated-parent parent_name
                        name of the sample to provide unrelated parent strain
                        (mapping strain) variants for the analysis in Variant
                        Allele Frequency (VAF) mode.
  -i, --infer, --infer-missing
                        if variant data for either the related or the
                        unrelated parent strain is not provided, the tool can
                        try to infer the alleles present in that parent from
                        the allele spectrum found in the mapping sample. Use
                        with caution on carefully filtered variant lists only!

VAC mode-specific options:
  -c sample_name, --contrast-sample sample_name
                        name of the sample (as appearing in the input vcf
                        file) that provides the contrast for the mapping
                        sample

file format and compatibility options:
  -t TEXT_FILE, --text-file TEXT_FILE
                        generate text-based output for every variant position
                        and save it to the specified file. This file can be
                        used as input during later runs of the tool, which
                        will speed up replotting.
  -s SEQINFO_FILE, --seqinfo SEQINFO_FILE
                        if an input file does not specify required contig
                        information (chromosome names and sizes), extract this
                        information from SEQINFO_FILE. This file can be a
                        reference genome file in fasta format or a CloudMap-
                        style sequence dictionary file. This option is never
                        necessary with MiModD-generated input, but can be
                        useful with input files generated by third-party tools
                        that do not record contig information in their output.
  --cloudmap            generate valid input for the original CloudMap Mapping
                        tools and save it to the text output file specified by
                        the "-t" option. This option can only be used in "SVD"
                        or "VAF" mode, which have an equivalent in CloudMap.

general plotting options:
  -p FILE, --plot-file FILE
                        generate graphical output and store it in the given
                        file (default: no graphical output)
  --fit-width           do not autoscale x-axes to size of largest contig

scatter plot parameters:
  --no-scatter          do not produce scatter plots of observed segregation
                        rates; just plot histograms
  -l FLOAT, --loess-span FLOAT
                        span parameter for the Loess regression line through
                        the linkage data (default: 0.1, specify 0 to skip
                        calculation)
  --ylim-scatter FLOAT  upper limit for scatter plot y-axis (default: 1)
  -z COLOR [COLOR ...], --points-colors COLOR [COLOR ...]
                        color(s) for scatter plot data points
  -k COLOR [COLOR ...], --loess-colors COLOR [COLOR ...]
                        color(s) for regression line(s) through scatter plot
                        data

histogram plot parameters:
  --no-hist             do not produce linkage histogram plots; only generate
                        scatter plots
  --no-kde              do not add kernel density estimate lines to histogram
                        plots
  --ylim-hist FLOAT     upper limit for histogram plot y-axis (default: auto)
  --hist-colors COLOR [COLOR ...]
                        list of colors to be used for plotting histogram bars
                        of different width (default: darkgrey and red)
```


## Metadata
- **Skill**: generated
