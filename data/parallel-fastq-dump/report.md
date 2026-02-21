# parallel-fastq-dump CWL Generation Report

## parallel-fastq-dump

### Tool Description
parallel fastq-dump wrapper, extra args will be passed through

### Metadata
- **Docker Image**: quay.io/biocontainers/parallel-fastq-dump:0.6.7--pyhdfd78af_0
- **Homepage**: https://github.com/rvalieris/parallel-fastq-dump
- **Package**: https://anaconda.org/channels/bioconda/packages/parallel-fastq-dump/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/parallel-fastq-dump/overview
- **Total Downloads**: 81.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/rvalieris/parallel-fastq-dump
- **Stars**: N/A
### Original Help Text
```text
usage: parallel-fastq-dump [-h] [-s SRA_ID] [-t THREADS] [-O OUTDIR]
                           [-T TMPDIR] [-N MINSPOTID] [-X MAXSPOTID] [-V]

parallel fastq-dump wrapper, extra args will be passed through

optional arguments:
  -h, --help            show this help message and exit
  -s SRA_ID, --sra-id SRA_ID
                        SRA id (default: None)
  -t THREADS, --threads THREADS
                        number of threads (default: 1)
  -O OUTDIR, --outdir OUTDIR
                        output directory (default: .)
  -T TMPDIR, --tmpdir TMPDIR
                        temporary directory (default: None)
  -N MINSPOTID, --minSpotId MINSPOTID
                        Minimum spot id (default: 1)
  -X MAXSPOTID, --maxSpotId MAXSPOTID
                        Maximum spot id (default: None)
  -V, --version         shows version (default: False)

DESCRIPTION:
Example: parallel-fastq-dump --sra-id SRR2244401 --threads 4 --outdir out/ --split-files --gzip
```


## Metadata
- **Skill**: generated

## parallel-fastq-dump_fastq-dump

### Tool Description
Dump SRA data into FASTQ format

### Metadata
- **Docker Image**: quay.io/biocontainers/parallel-fastq-dump:0.6.7--pyhdfd78af_0
- **Homepage**: https://github.com/rvalieris/parallel-fastq-dump
- **Package**: https://anaconda.org/channels/bioconda/packages/parallel-fastq-dump/overview
- **Validation**: PASS
### Original Help Text
```text
Usage: fastq-dump [ options ] [ accessions(s)... ]

Parameters:

  accessions(s)                    list of accessions to process


Options:

  -A|--accession <accession>       Replaces accession derived from <path> in
                                     filename(s) and deflines (only for
                                     single table dump)
     --table <table-name>          Table name within cSRA object, default is
                                     "SEQUENCE"
     --split-spot                  Split spots into individual reads
  -N|--minSpotId <rowid>           Minimum spot id
  -X|--maxSpotId <rowid>           Maximum spot id
     --spot-groups <[list]>[,...]  Filter by SPOT_GROUP (member): name[,...]
  -W|--clip                        Remove adapter sequences from reads
  -M|--minReadLen <len>            Filter by sequence length >= <len>
  -R|--read-filter <filter>        Split into files by READ_FILTER value
                                     [split], optionally filter by value:
                                     [pass|reject|criteria|redacted]
  -E|--qual-filter                 Filter used in early 1000 Genomes data: no
                                     sequences starting or ending with >= 10N
     --qual-filter-1               Filter used in current 1000 Genomes data
     --aligned                     Dump only aligned sequences
     --unaligned                   Dump only unaligned sequences
     --aligned-region <name[:from-to]>
                                   Filter by position on genome. Name can
                                     eiter by accession.version (ex:
                                     NC_000001.10) or file specific name (ex:
                                     "chr1" or "1". "from" and "to" are
                                     1-based coordinates
     --matepair_distance <from-to|unknown>
                                   Filter by distance between matepairs. Use
                                     "unknown" to find matepairs split
                                     between the references. Use from-to to
                                     limit matepair distance on the same
                                     reference
     --skip-technical              Dump only biological reads
  -O|--outdir <path>               Output directory, default is working
                                     directory '.'
  -Z|--stdout                      Output to stdout, all split data become
                                     joined into single stream
     --gzip                        Compress output using gzip: deprecated,
                                     not recommended
     --bzip2                       Compress output using bzip2: deprecated,
                                     not recommended
     --split-files                 Write reads into separate files. Read
                                     number will be suffixed to the file
                                     name. NOTE! The `--split-3` option is
                                     recommended. In cases where not all
                                     spots have the same number of reads,
                                     this option will produce files that WILL
                                     CAUSE ERRORS in most programs which
                                     process split pair fastq files.
     --split-3                     3-way splitting for mate-pairs. For each
                                     spot, if there are two biological reads
                                     satisfying filter conditions, the first
                                     is placed in the `*_1.fastq` file, and
                                     the second is placed in the `*_2.fastq`
                                     file. If there is only one biological
                                     read satisfying the filter conditions,
                                     it is placed in the `*.fastq` file.All
                                     other reads in the spot are ignored.
  -G|--spot-group                  Split into files by SPOT_GROUP (member
                                     name)
  -T|--group-in-dirs               Split into subdirectories instead of files
  -K|--keep-empty-files            Do not delete empty files
  -C|--dumpcs <cskey>              Formats sequence using color space
                                     (default for SOLiD), "cskey" may be
                                     specified for translation or else
                                     specify "dflt" to use the default value
  -B|--dumpbase                    Formats sequence using base space (default
                                     for other than SOLiD).
  -Q|--offset <integer             Offset to use for quality conversion,
                                     default is 33
     --fasta <line-width>          FASTA only, no qualities, with can be
                                     "default" or "0" for no wrapping
     --suppress-qual-for-cskey     suppress quality-value for cskey
  -F|--origfmt                     Defline contains only original sequence
                                     name
  -I|--readids                     Append read id after spot id as
                                     'accession.spot.readid' on defline
     --helicos                     Helicos style defline
     --defline-seq <fmt>           Defline format specification for sequence.
     --defline-qual <fmt>          Defline format specification for quality.
                                     <fmt> is string of characters and/or
                                     variables. The variables can be one of:
                                     $ac - accession, $si spot id, $sn spot
                                     name, $sg spot group (barcode), $sl spot
                                     length in bases, $ri read number, $rn
                                     read name, $rl read length in bases.
                                     '[]' could be used for an optional
                                     output: if all vars in [] yield empty
                                     values whole group is not printed. Empty
                                     value is empty string or for numeric
                                     variables. Ex: @$sn[_$rn]/$ri '_$rn' is
                                     omitted if name is empty
     --ngc <path>                  <path> to ngc file
     --perm <path>                 <path> to permission file
     --location <location>         location in cloud
     --cart <path>                 <path> to cart file
     --disable-multithreading      disable multithreading
  -V|--version                     Display the version of the program
  -v|--verbose                     Increase the verbosity of the program
                                     status messages. Use multiple times for
                                     more verbosity.
  -L|--log-level <level>           Logging level as number or enum string.
                                     One of
                                     (fatal|sys|int|err|warn|info|debug) or
                                     (0-6) Current/default is warn
     --option-file file            Read more options and parameters from the
                                     file.
  -h|--help                        print this message

"/usr/local/bin/fastq-dump" version 2.10.9
```

## parallel-fastq-dump_sra-stat

### Tool Description
Display table statistics

### Metadata
- **Docker Image**: quay.io/biocontainers/parallel-fastq-dump:0.6.7--pyhdfd78af_0
- **Homepage**: https://github.com/rvalieris/parallel-fastq-dump
- **Package**: https://anaconda.org/channels/bioconda/packages/parallel-fastq-dump/overview
- **Validation**: PASS
### Original Help Text
```text
Usage:
  sra-stat [options] table

Summary:
  Display table statistics

Options:
  -x|--xml                         output as XML, default is text 
  -b|--start <row-id>              starting spot id, default is 1 
  -e|--stop <row-id>               ending spot id, default is max 
  -m|--meta                        print load metadata 
  -q|--quick                       quick mode: get statistics from metadata; do 
                                   not scan the table 
  --member-stats <on | off>        print member stats, default is on 
  --archive-info                   output archive info, default is off 
  -s|--statistics                  calculate READ_LEN average and standard 
                                   deviation 
  -a|--alignment <on | off>        print alignment info, default is on 
  -p|--show_progress               show the percentage of completion 
  --ngc <path>                     path to ngc file 
  -z|--xml-log <logfile>           produce XML-formatted log file 

  -h|--help                        Output brief explanation for the program. 
  -V|--version                     Display the version of the program then 
                                   quit. 
  -L|--log-level <level>           Logging level as number or enum string. One 
                                   of (fatal|sys|int|err|warn|info|debug) or 
                                   (0-6) Current/default is warn 
  -v|--verbose                     Increase the verbosity of the program 
                                   status messages. Use multiple times for more 
                                   verbosity. Negates quiet. 
  -q|--quiet                       Turn off all status messages for the 
                                   program. Negated by verbose. 
  --option-file <file>             Read more options and parameters from the 
                                   file. 

/usr/local/bin/sra-stat : 2.10.9
```

## parallel-fastq-dump_prefetch

### Tool Description
Download SRA accessions and their dependencies

### Metadata
- **Docker Image**: quay.io/biocontainers/parallel-fastq-dump:0.6.7--pyhdfd78af_0
- **Homepage**: https://github.com/rvalieris/parallel-fastq-dump
- **Package**: https://anaconda.org/channels/bioconda/packages/parallel-fastq-dump/overview
- **Validation**: PASS
### Original Help Text
```text
Usage: prefetch [ options ] [ accessions(s)... ]

Parameters:

  accessions(s)                    list of accessions to process


Options:

  -T|--type <file-type>            Specify file type to download. Default: sra
  -N|--min-size <size>             Minimum file size to download in KB
                                     (inclusive).
  -X|--max-size <size>             Maximum file size to download in KB
                                     (exclusive). Default: 20G
  -f|--force <no|yes|all|ALL>      Force object download - one of: no, yes,
                                     all, ALL. no [default]: skip download if
                                     the object if found and complete; yes:
                                     download it even if it is found and is
                                     complete; all: ignore lock files (stale
                                     locks or it is being downloaded by
                                     another process - use at your own
                                     risk!); ALL: ignore lock files, restart
                                     download from beginning
  -p|--progress                    Show progress
  -r|--resume <yes|no>             Resume partial downloads - one of: no, yes
                                     [default]
  -C|--verify <yes|no>             Verify after download - one of: no, yes
                                     [default]
  -c|--check-all                   Double-check all refseqs
  -o|--output-file <file>          Write file to <file> when downloading
                                     single file
  -O|--output-directory <directory>
                                   Save files to <directory>/
     --ngc <path>                  <path> to ngc file
     --perm <path>                 <path> to permission file
     --location <location>         location in cloud
     --cart <path>                 <path> to cart file
     --disable-multithreading      disable multithreading
  -V|--version                     Display the version of the program
  -v|--verbose                     Increase the verbosity of the program
                                     status messages. Use multiple times for
                                     more verbosity.
  -L|--log-level <level>           Logging level as number or enum string.
                                     One of
                                     (fatal|sys|int|err|warn|info|debug) or
                                     (0-6) Current/default is warn
     --option-file file            Read more options and parameters from the
                                     file.
  -h|--help                        print this message

"/usr/local/bin/prefetch" version 2.10.9
```

