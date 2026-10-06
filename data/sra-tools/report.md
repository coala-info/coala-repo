# sra-tools CWL Generation Report

## sra-tools_prefetch

### Tool Description
Download SRA files and their dependencies

### Metadata
- **Docker Image**: quay.io/biocontainers/sra-tools:3.4.1--2_linux_64
- **Homepage**: https://github.com/ncbi/sra-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/sra-tools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sra-tools/overview
- **Total Downloads**: 675.5K
- **Last updated**: 2026-04-19
- **GitHub**: https://github.com/ncbi/sra-tools
- **Stars**: N/A
### Original Help Text
```text
Usage:
  prefetch [options] <SRA accession> [...]
  Download SRA files and their dependencies

  prefetch [options] --perm <JWT cart file> <SRA accession> [...]
  Download SRA files and their dependencies from JWT cart

  prefetch [options] --cart <kart file>
  Download cart file

  prefetch [options] <URL> --output-file <FILE>
  Download URL to FILE

  prefetch [options] <URL> [...] --output-directory <DIRECTORY>
  Download URL or URL-s to DIRECTORY

  prefetch [options] <SRA file> [...]
  Check SRA file for missed dependencies and download them

Options:
  -T|--type <value>                Specify file type to download. Default: sra 
  -t|--transport <http|fasp|both>  Transport: one of: fasp; http; both 
                                   [default]. (fasp only; http only; first try 
                                   fasp (ascp), use http if cannot download 
                                   using fasp). 
  --location <value>               Location of data. 

  -N|--min-size <size>             Minimum file size to download in KB 
                                   (inclusive). 
  -X|--max-size <size>             Maximum file size to download in KB 
                                   (exclusive). Default: 20G 
  -f|--force <yes|no|all|ALL>      Force object download: one of: no, yes, 
                                   all, ALL. no [default]: skip download if the 
                                   object if found and complete; yes: download 
                                   it even if it is found and is complete; all: 
                                   ignore lock files (stale locks or it is 
                                   being downloaded by another process use 
                                   at your own risk!); ALL: ignore lock files, 
                                   restart download from beginning. 
  -r|--resume <yes|no>             Resume partial downloads: one of: no, yes 
                                   [default]. 
  -C|--verify <yes|no>             Verify after download: one of: no, yes 
                                   [default]. 
  -p|--progress                    Show progress. 
  -H|--heartbeat <value>           Time period in minutes to display download 
                                   progress. (0: no progress), default: 1 

  --eliminate-quals                Download SRA Lite files with simplified 
                                   base quality scores, or fail if not 
                                   available. 
  -c|--check-all                   Double-check all refseqs. 
  -S|--check-rs <yes|no|smart>     Check for refseqs in downloaded files: one 
                                   of: no, yes, smart [default]. Smart: skip 
                                   check for large encrypted non-sra files. 

  -l|--list                        List the content of kart file. 
  -n|--numbered-list               List the content of kart file with kart 
                                   row numbers. 
  -s|--list-sizes                  List the content of kart file with target 
                                   file sizes. 
  -o|--order <kart|size>           Kart prefetch order when downloading 
                                   kart: one of: kart, size. (in kart order, by 
                                   file size: smallest first), default: size. 
  -R|--rows <rows>                 Kart rows to download (default all). Row 
                                   list should be ordered. 
  --perm <PATH>                    PATH to jwt cart file. 
  --ngc <PATH>                     PATH to ngc file. 
  --cart <PATH>                    To read kart file. 

  -a|--ascp-path <ascp-binary|private-key-file>  Path to ascp program and 
                                   private key file (aspera_tokenauth_id_rsa) 
  --ascp-options <value>           Arbitrary options to pass to ascp command 
                                   line. 
  -O|--output-directory <DIRECTORY>  Save files to DIRECTORY/ 

  -h|--help                        Output brief explanation for the program. 
  -V|--version                     Display the version of the program then 
                                   quit. 
  -L|--log-level <level>           Logging level as number or enum string. One 
                                   of (fatal|sys|int|err|warn|info|debug) or 
                                   (0-6) Current/default is warn. 
  -v|--verbose                     Increase the verbosity of the program 
                                   status messages. Use multiple times for more 
                                   verbosity. Negates quiet. 
  -q|--quiet                       Turn off all status messages for the 
                                   program. Negated by verbose. 
  --option-file <file>             Read more options and parameters from the 
                                   file. 
prefetch : 3.4.1

2026-06-24T21:55:21 prefetch.3.4.1 err: param unknown while parsing argument list within application support module - Unknown argument '-e'
```

## sra-tools_fasterq-dump

### Tool Description
A tool for dumping data from SRA accessions or paths in FASTQ/FASTA format, designed for speed and efficiency.

### Metadata
- **Docker Image**: quay.io/biocontainers/sra-tools:3.4.1--2_linux_64
- **Homepage**: https://github.com/ncbi/sra-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/sra-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
  fasterq-dump <path> [options]
  fasterq-dump <accession> [options]

Options:
  -F|--format                      format (special, fastq, default=fastq) 
  -o|--outfile                     output-file 
  -O|--outdir                      output-dir 
  -b|--bufsize                     size of file-buffer dflt=1MB 
  -c|--curcache                    size of cursor-cache dflt=10MB 
  -m|--mem                         memory limit for sorting dflt=100MB 
  -t|--temp                        where to put temp. files dflt=curr dir 
  -e|--threads                     how many thread dflt=6 
  -p|--progress                    show progress 
  -x|--details                     print details 
  -s|--split-spot                  split spots into reads 
  -S|--split-files                 write reads into different files 
  -3|--split-3                     writes single reads in special file 
  --concatenate-reads              writes whole spots into one file 
  -Z|--stdout                      print output to stdout 
  -f|--force                       force to overwrite existing file(s) 
  --skip-technical                 skip technical reads 
  --include-technical              include technical reads 
  -M|--min-read-len                filter by sequence-len 
  --table                          which seq-table to use in case of pacbio 
  -B|--bases                       filter by bases 
  -A|--append                      append to output-file 
  --fasta                          produce FASTA output 
  --fasta-unsorted                 produce FASTA output, unsorted 
  --fasta-ref-tbl                  produce FASTA output from REFERENCE tbl 
  --fasta-concat-all               concatenate all rows and produce FASTA 
  --internal-ref                   extract only internal REFERENCEs 
  --external-ref                   extract only external REFERENCEs 
  --ref-name                       extract only these REFERENCEs 
  --ref-report                     enumerate references 
  --use-name                       print name instead of seq-id 
  --seq-defline                    custom defline for sequence:  $ac=accession, 
                                   $sn=spot-name,  $sg=spot-group, $si=spot-id,  
                                   $ri=read-id, $rl=read-length 
  --qual-defline                   custom defline for qualities:  same as 
                                   seq-defline 
  -U|--only-unaligned              process only unaligned reads 
  -a|--only-aligned                process only aligned reads 
  --disk-limit                     explicitly set disk-limit 
  --disk-limit-tmp                 explicitly set disk-limit for temp. files 
  --size-check                     switch to control: on=perform size-check 
                                   (default),  off=do not perform size-check,  
                                   only=perform size-check only 
  --ngc <PATH>                     PATH to ngc file 

  -h|--help                        Output brief explanation for the program. 
  -V|--version                     Display the version of the program then 
                                   quit. 
  -L|--log-level <level>           Logging level as number or enum string. One 
                                   of (fatal|sys|int|err|warn|info|debug) or 
                                   (0-6) Current/default is warn. 
  -v|--verbose                     Increase the verbosity of the program 
                                   status messages. Use multiple times for more 
                                   verbosity. Negates quiet. 
  -q|--quiet                       Turn off all status messages for the 
                                   program. Negated by verbose. 
  --option-file <file>             Read more options and parameters from the 
                                   file. 
for more information visit:
   https://github.com/ncbi/sra-tools/wiki/HowTo:-fasterq-dump
   https://github.com/ncbi/sra-tools/wiki/08.-prefetch-and-fasterq-dump
fasterq-dump : 3.4.1
```

## sra-tools_fastq-dump

### Tool Description
Dump data from SRA (Sequence Read Archive) into FASTQ format

### Metadata
- **Docker Image**: quay.io/biocontainers/sra-tools:3.4.1--2_linux_64
- **Homepage**: https://github.com/ncbi/sra-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/sra-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
  fastq-dump [options] <path> [<path>...]
  fastq-dump [options] <accession>

INPUT
  -A|--accession <accession>       Replaces accession derived from <path> in 
                                   filename(s) and deflines (only for single 
                                   table dump) 
  --table <table-name>             Table name within cSRA object, default is 
                                   "SEQUENCE" 

PROCESSING

Read Splitting                     Sequence data may be used in raw form or
                                     split into individual reads
  --split-spot                     Split spots into individual reads 

Full Spot Filters                  Applied to the full spot independently
                                     of --split-spot
  -N|--minSpotId <rowid>           Minimum spot id 
  -X|--maxSpotId <rowid>           Maximum spot id 
  --spot-groups <[list]>           Filter by SPOT_GROUP (member): name[,...] 
  -W|--clip                        Remove adapter sequences from reads 

Common Filters                     Applied to spots when --split-spot is not
                                     set, otherwise - to individual reads
  -M|--minReadLen <len>            Filter by sequence length >= <len> 
  -R|--read-filter <[filter]>      Split into files by READ_FILTER value 
                                   optionally filter by value: 
                                   pass|reject|criteria|redacted 
  -E|--qual-filter                 Filter used in early 1000 Genomes data: no 
                                   sequences starting or ending with >= 10N 
  --qual-filter-1                  Filter used in current 1000 Genomes data 

Filters based on alignments        Filters are active when alignment
                                     data are present
  --aligned                        Dump only aligned sequences 
  --unaligned                      Dump only unaligned sequences 
  --aligned-region <name[:from-to]>  Filter by position on genome. Name can 
                                   either be accession.version (ex: 
                                   NC_000001.10) or file specific name (ex: 
                                   "chr1" or "1"). "from" and "to" are 1-based 
                                   coordinates 
  --matepair-distance <from-to|unknown>  Filter by distance between matepairs. 
                                   Use "unknown" to find matepairs split 
                                   between the references. Use from-to to limit 
                                   matepair distance on the same reference 

Filters for individual reads       Applied only with --split-spot set
  --skip-technical                 Dump only biological reads 

OUTPUT
  -O|--outdir <path>               Output directory, default is working 
                                   directory '.' ) 
  -Z|--stdout                      Output to stdout, all split data become 
                                   joined into single stream 
  --gzip                           Compress output using gzip: deprecated, not 
                                   recommended 
  --bzip2                          Compress output using bzip2: deprecated, 
                                   not recommended 

Multiple File Options              Setting these options will produce more
                                     than 1 file, each of which will be suffixed
                                     according to splitting criteria.
  --split-files                    Write reads into separate files. Read 
                                   number will be suffixed to the file name.  
                                   NOTE! The `--split-3` option is recommended. 
                                   In cases where not all spots have the same 
                                   number of reads, this option will produce 
                                   files that WILL CAUSE ERRORS in most programs 
                                   which process split pair fastq files. 
  --split-3                        3-way splitting for mate-pairs. For each 
                                   spot, if there are two biological reads 
                                   satisfying filter conditions, the first is 
                                   placed in the `*_1.fastq` file, and the 
                                   second is placed in the `*_2.fastq` file. If 
                                   there is only one biological read 
                                   satisfying the filter conditions, it is 
                                   placed in the `*.fastq` file.All other 
                                   reads in the spot are ignored. 
  -G|--spot-group                  Split into files by SPOT_GROUP (member name) 
  -R|--read-filter <[filter]>      Split into files by READ_FILTER value 
                                   optionally filter by value: 
                                   pass|reject|criteria|redacted 
  -T|--group-in-dirs               Split into subdirectories instead of files 
  -K|--keep-empty-files            Do not delete empty files 

FORMATTING

Sequence
  -C|--dumpcs <[cskey]>            Formats sequence using color space (default 
                                   for SOLiD),"cskey" may be specified for 
                                   translation 
  -B|--dumpbase                    Formats sequence using base space (default 
                                   for other than SOLiD). 

Quality
  -Q|--offset <integer>            Offset to use for quality conversion, 
                                   default is 33 
  --fasta <[line width]>           FASTA only, no qualities, optional line 
                                   wrap width (set to zero for no wrapping) 
  --suppress-qual-for-cskey        suppress quality-value for cskey 

Defline
  -F|--origfmt                     Defline contains only original sequence name 
  -I|--readids                     Append read id after spot id as 
                                   'accession.spot.readid' on defline 
  --helicos                        Helicos style defline 
  --defline-seq <fmt>              Defline format specification for sequence. 
  --defline-qual <fmt>             Defline format specification for quality. 
                                   <fmt> is string of characters and/or 
                                   variables. The variables can be one of: $ac 
                                   - accession, $si spot id, $sn spot 
                                   name, $sg spot group (barcode), $sl spot 
                                   length in bases, $ri read number, $rn 
                                   read name, $rl read length in bases. '[]' 
                                   could be used for an optional output: if 
                                   all vars in [] yield empty values whole 
                                   group is not printed. Empty value is empty 
                                   string or for numeric variables. Ex: 
                                   @$sn[_$rn]/$ri '_$rn' is omitted if name 
                                   is empty
 
OTHER:
  --ngc <path>                     <path> to ngc file 
  --disable-multithreading         disable multithreading 
  -h|--help                        Output brief explanation of program usage 
  -V|--version                     Display the version of the program 
  -L|--log-level <level>           Logging level as number or enum string One 
                                   of (fatal|sys|int|err|warn|info) or (0-5) 
                                   Current/default is warn 
  -v|--verbose                     Increase the verbosity level of the program 
                                   Use multiple times for more verbosity 
  --ncbi_error_report              Control program execution environment 
                                   report generation (if implemented). One of 
                                   (never|error|always). Default is error 
  --legacy-report                  use legacy style 'Written spots' for tool 

fastq-dump : 3.4.1
```

## sra-tools_vdb-validate

### Tool Description
Examine directories, files and VDB objects, reporting any problems that can be detected. Components md5s are always checked if present.

### Metadata
- **Docker Image**: quay.io/biocontainers/sra-tools:3.4.1--2_linux_64
- **Homepage**: https://github.com/ncbi/sra-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/sra-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: vdb-validate [options] path [ path... ]

  Examine directories, files and VDB objects,
  reporting any problems that can be detected.

Components md5s are always checked if present.

Options:
  -B|--BLOB-CRC <yes | no>         Check blobs CRC32 (default: no) 
  -I|--REFERENTIAL-INTEGRITY <yes | no>  Check data referential integrity for 
                                   databases (default: yes) 
  -C|--CONSISTENCY-CHECK <yes | no>  Deeply check data consistency for tables 
                                   (default: no) 
  -x|--exhaustive                  Continue checking object for all possible 
                                   errors (default: false) 
  --sdc:rows <rows>                Specify maximum amount of secondary 
                                   alignment table rows to look at before 
                                   saying accession is good, default 100000. 
                                   Specifying will iterate the whole table. 
                                   Can be in percent (e.g. 5%) 
  --sdc:seq-rows <rows>            Specify maximum amount of sequence table 
                                   rows to look at before saying accession is 
                                   good, default 100000. Specifying will 
                                   iterate the whole table. Can be in percent 
                                   (e.g. 5%) 
  --sdc:plen_thold <threshold>     Specify threshold for amount of secondary 
                                   alignment which are shorter (hard-clipped) 
                                   than corresponding primaries, default 1%. 
  --ngc <path>                     path to ngc file 
  --check-redact                   check if redaction of bases has been 
                                   correctly performed (default: false) 
  --require-blob-checksums         Require blob checksums (default: no) 

  -h|--help                        Output brief explanation for the program. 
  -V|--version                     Display the version of the program then 
                                   quit. 
  -L|--log-level <level>           Logging level as number or enum string. One 
                                   of (fatal|sys|int|err|warn|info|debug) or 
                                   (0-6) Current/default is warn. 
  -v|--verbose                     Increase the verbosity of the program 
                                   status messages. Use multiple times for more 
                                   verbosity. Negates quiet. 
  -q|--quiet                       Turn off all status messages for the 
                                   program. Negated by verbose. 
  --option-file <file>             Read more options and parameters from the 
                                   file. 
vdb-validate : 3.4.1

2026-06-24T21:56:12 vdb-validate.3.4.1 err: param unknown while parsing argument list within application support module - Unknown argument '-e'
2026-06-24T21:56:12 vdb-validate.3.4.1 err: param unknown while parsing argument list within application support module - Unknown argument '-l'
2026-06-24T21:56:12 vdb-validate.3.4.1 err: param unknown while parsing argument list within application support module - Unknown argument '-p'
```

## sra-tools_sam-dump

### Tool Description
Dump SRA runs in SAM format

### Metadata
- **Docker Image**: quay.io/biocontainers/sra-tools:3.4.1--2_linux_64
- **Homepage**: https://github.com/ncbi/sra-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/sra-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
	sam-dump [options] path-to-run[ path-to-run ...]

Options:
  -u|--unaligned                   Output unaligned reads along with aligned 
                                   reads 
  -1|--primary                     Output only primary alignments 
  -c|--cigar-long                  Output long version of CIGAR 
  --cigar-CG                       Output CG version of CIGAR 
  -r|--header                      Always reconstruct header 
  --header-file <filename>         take all headers from this file 
  -n|--no-header                   Do not output headers 
  --header-comment <text>          Add comment to header. Use multiple times 
                                   for several lines. Use quotes 
  --aligned-region <name[:from-to]>  Filter by position on genome. Name can 
                                   either be file specific name (ex: "chr1" or 
                                   "1"). "from" and "to" (inclusive) are 
                                   1-based coordinates 
  --matepair-distance <from-to|'unknown'>  Filter by distance between 
                                   matepairs. Use "unknown" to find matepairs 
                                   split between the references. Use from-to 
                                   (inclusive) to limit matepair distance on 
                                   the same reference 
  -s|--seqid                       Print reference SEQ_ID in RNAME instead of 
                                   NAME 
  -=|--hide-identical              Output '=' if base is identical to reference 
  --gzip                           Compress output using gzip 
  --bzip2                          Compress output using bzip2 
  -g|--spot-group                  Add .SPOT_GROUP to QNAME 
  --fastq                          Produce FastQ formatted output 
  --fasta                          Produce Fasta formatted output 
  -p|--prefix <prefix>             Prefix QNAME: prefix.QNAME 
  --reverse                        Reverse unaligned reads according to read 
                                   type 
  --cigar-CG-merge                 Apply CG fixups to CIGAR/SEQ/QUAL and 
                                   outputs CG-specific columns 
  --XI                             Output cSRA alignment id in XI column 
  -Q|--qual-quant <quantization string>  Quality scores quantization level 
                                   string like '1:10,10:20,20:30,30:-' 
  --CG-evidence                    Output CG evidence aligned to reference 
  --CG-ev-dnb                      Output CG evidence DNB's aligned to evidence 
  --CG-mappings                    Output CG sequences aligned to reference  
  --CG-SAM                         Output CG evidence DNB's aligned to 
                                   reference  
  --report                         report options instead of executing 
  --output-file                    print output into this file (instead of 
                                   STDOUT) 
  --output-buffer-size             size of output-buffer(dflt:32k, 0...off) 
  --cachereport                    print report about mate-pair-cache 
  --unaligned-spots-only           output reads for spots with no aligned reads 
  --CG-names                       prints cg-style spotgroup.spotid formed 
                                   names 
  --cursor-cache                   open cached cursor with this size 
  --min-mapq                       min. mapq an alignment has to have, to be 
                                   printed 
  --no-mate-cache                  do not use mate-cache, slower but less 
                                   memory usage 
  --rna-splicing                   modify cigar-string (replace .D. with .N.) 
                                   and add output flags (XS:A:+/-)  when 
                                   rna-splicing is detected by match to 
                                   spliceosome recognition sites 
  --rna-splice-level               level of rna-splicing detection (0,1,2) when 
                                   testing for spliceosome recognition sites  
                                   0=perfect match, 1=one mismatch, 2=two 
                                   mismatches  one on each site 
  --rna-splice-log                 file, into which rna-splice events are 
                                   written 
  --disable-multithreading         disable multithreading 
  -o|--omit-quality                omit qualities 
  --with-md-flag                   print MD-flag 
  --ngc <PATH>                     PATH to ngc file 

  -h|--help                        Output brief explanation for the program. 
  -V|--version                     Display the version of the program then 
                                   quit. 
  -L|--log-level <level>           Logging level as number or enum string. One 
                                   of (fatal|sys|int|err|warn|info|debug) or 
                                   (0-6) Current/default is warn. 
  -v|--verbose                     Increase the verbosity of the program 
                                   status messages. Use multiple times for more 
                                   verbosity. Negates quiet. 
  -q|--quiet                       Turn off all status messages for the 
                                   program. Negated by verbose. 
  --option-file <file>             Read more options and parameters from the 
                                   file. 
sam-dump : 3.4.1

2026-06-24T21:56:21 sam-dump.3.4.1 err: param invalid while parsing argument list - no inputfiles given at commandline
```

## sra-tools_sra-stat

### Tool Description
Display table statistics

### Metadata
- **Docker Image**: quay.io/biocontainers/sra-tools:3.4.1--2_linux_64
- **Homepage**: https://github.com/ncbi/sra-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/sra-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
  sra-stat [options] table

Summary:
  Display table statistics

Options:
  -x|--xml                         Output as XML, default is text. 
  -b|--start <row-id>              Starting spot id, default is 1. 
  -e|--stop <row-id>               Ending spot id, default is max. 
  -m|--meta                        Print load metadata. 
  -q|--quick                       Quick mode: get statistics from metadata; do 
                                   not scan the table. 
  --member-stats <on | off>        Print member stats, default is on. 
  --archive-info                   Output archive info, default is off. 
  -s|--statistics                  Calculate READ_LEN average and standard 
                                   deviation. 
  -a|--alignment <on | off>        Print alignment info, default is on. 
  -l|--local-info                  Print the date, path, size and md5 of local 
                                   run. 
  -p|--show_progress               Show the percentage of completion. 
  --ngc <path>                     Path to ngc file. 
  -z|--xml-log <logfile>           Produce XML-formatted log file. 
  --repair-data                    Generate data for repair tool. 
  --info                           Print report for all fields examined for 
                                   mismatch even if the old value is correct. 

  -h|--help                        Output brief explanation for the program. 
  -V|--version                     Display the version of the program then 
                                   quit. 
  -L|--log-level <level>           Logging level as number or enum string. One 
                                   of (fatal|sys|int|err|warn|info|debug) or 
                                   (0-6) Current/default is warn. 
  -v|--verbose                     Increase the verbosity of the program 
                                   status messages. Use multiple times for more 
                                   verbosity. Negates quiet. 
  -q|--quiet                       Turn off all status messages for the 
                                   program. Negated by verbose. 
  --option-file <file>             Read more options and parameters from the 
                                   file. 
sra-stat : 3.4.1
```

