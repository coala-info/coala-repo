# slow5tools CWL Generation Report

## slow5tools_f2s

### Tool Description
Convert FAST5 files to SLOW5/BLOW5 format.

### Metadata
- **Docker Image**: quay.io/biocontainers/slow5tools:1.4.0--hee927d3_0
- **Homepage**: https://github.com/hasindu2008/slow5tools
- **Package**: https://anaconda.org/channels/bioconda/packages/slow5tools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/slow5tools/overview
- **Total Downloads**: 373.5K
- **Last updated**: 2026-01-31
- **GitHub**: https://github.com/hasindu2008/slow5tools
- **Stars**: N/A
### Original Help Text
```text
Convert FAST5 files to SLOW5/BLOW5 format.
Usage: slow5tools f2s [OPTIONS] [FAST5_FILE/DIR] ...

OPTIONS:
        --to FORMAT               specify output file format [blow5, auto detected using extension if -o FILE is provided]
    -d, --out-dir DIR             output to directory
    -o, --output FILE             output to FILE [stdout]
    -c, --compress REC_MTD        record compression method [zlib] (only for blow5 format)
    -s, --sig-compress SIG_MTD    signal compression method [svb-zd] (only for blow5 format)
    -p, --iop INT                 number of I/O processes [8]
        --lossless                retain information in auxiliary fields during the conversion [true]
    -a, --allow                   allow run id mismatches in a multi-fast5 file or in a single-fast5 directory
        --retain                  retain the same directory structure in the converted output as the input (experimental)
    -h, --help                    display this message and exit
FORMAT:
    slow5 - SLOW5 ASCII
    blow5 - SLOW5 binary (BLOW5)
REC_MTD:
    none - no record compression
    zlib - Z library (also known as gzip or DEFLATE)
    zstd - Z standard 
SIG_MTD:
    none - no special signal compression
    svb-zd - StreamVByte with zig-zag delta
    ex-zd - exception with zig-zag delta

See https://slow5.bioinf.science/man for detailed description of these command-line options.
```


## slow5tools_s2f

### Tool Description
Convert SLOW5/BLOW5 files to FAST5 format.

### Metadata
- **Docker Image**: quay.io/biocontainers/slow5tools:1.4.0--hee927d3_0
- **Homepage**: https://github.com/hasindu2008/slow5tools
- **Package**: https://anaconda.org/channels/bioconda/packages/slow5tools/overview
- **Validation**: PASS

### Original Help Text
```text
Convert SLOW5/BLOW5 files to FAST5 format.
Usage: slow5tools s2f [OPTIONS] -d [OUT_DIR] [SLOW5_FILE/DIR] ...

OPTIONS:
    -d, --out-dir DIR             output to directory
    -o, --output FILE             output to FILE [stdout]
    -p, --iop INT                 number of I/O processes [8]
    -h, --help                    display this message and exit
```


## slow5tools_merge

### Tool Description
Merge multiple SLOW5/BLOW5 files to a single file

### Metadata
- **Docker Image**: quay.io/biocontainers/slow5tools:1.4.0--hee927d3_0
- **Homepage**: https://github.com/hasindu2008/slow5tools
- **Package**: https://anaconda.org/channels/bioconda/packages/slow5tools/overview
- **Validation**: PASS

### Original Help Text
```text
Merge multiple SLOW5/BLOW5 files to a single file
Usage: slow5tools merge [OPTIONS] [SLOW5_FILE/DIR] ...

OPTIONS:
        --to FORMAT               specify output file format [blow5, auto detected using extension if -o FILE is provided]
    -o, --output FILE             output to FILE [stdout]
    -c, --compress REC_MTD        record compression method [zlib] (only for blow5 format)
    -s, --sig-compress SIG_MTD    signal compression method [svb-zd] (only for blow5 format)
    -t, --threads INT             number of threads [8]
    -K, --batchsize INT           number of records loaded to the memory at once [4096]
        --lossless                retain information in auxiliary fields during the conversion [true]
    -a, --allow                   allow merging despite attribute differences in the same run_id
    -h, --help                    display this message and exit
FORMAT:
    slow5 - SLOW5 ASCII
    blow5 - SLOW5 binary (BLOW5)
REC_MTD:
    none - no record compression
    zlib - Z library (also known as gzip or DEFLATE)
    zstd - Z standard 
SIG_MTD:
    none - no special signal compression
    svb-zd - StreamVByte with zig-zag delta
    ex-zd - exception with zig-zag delta

See https://slow5.bioinf.science/man for detailed description of these command-line options.
```


## slow5tools_split

### Tool Description
Split a single a SLOW5/BLOW5 file into multiple separate files.

### Metadata
- **Docker Image**: quay.io/biocontainers/slow5tools:1.4.0--hee927d3_0
- **Homepage**: https://github.com/hasindu2008/slow5tools
- **Package**: https://anaconda.org/channels/bioconda/packages/slow5tools/overview
- **Validation**: PASS

### Original Help Text
```text
Split a single a SLOW5/BLOW5 file into multiple separate files.
Usage: slow5tools split [OPTIONS] [SLOW5_FILE/DIR] ...

OPTIONS:
        --to FORMAT               specify output file format [blow5, auto detected using extension if -o FILE is provided]
    -d, --out-dir DIR             output to directory
    -c, --compress REC_MTD        record compression method [zlib] (only for blow5 format)
    -s, --sig-compress SIG_MTD    signal compression method [svb-zd] (only for blow5 format)
    -g, --groups                  split multi read group file into single read group files
    -r, --reads [INT]             split into n reads, i.e., each file will have n reads
    -f, --files [INT]             split reads into n files evenly 
    -x, --demux [TSV_PATH]        split reads according to TSV file
        --demux-code [STR]        specify categories column name ['barcode_arrangement']
        --demux-rid [STR]         specify read IDs column name ['parent_read_id']
    -m, --demux-missing [STR]     uncategorised reads to category named STR
    -u, --demux-uniq [STR]        multi-category reads to category named STR
    -t, --threads INT             number of threads [8]
    -K, --batchsize INT           number of records loaded to the memory at once [4096]
        --lossless                retain information in auxiliary fields during the conversion [true]
    -h, --help                    display this message and exit
FORMAT:
    slow5 - SLOW5 ASCII
    blow5 - SLOW5 binary (BLOW5)
REC_MTD:
    none - no record compression
    zlib - Z library (also known as gzip or DEFLATE)
    zstd - Z standard 
SIG_MTD:
    none - no special signal compression
    svb-zd - StreamVByte with zig-zag delta
    ex-zd - exception with zig-zag delta

See https://slow5.bioinf.science/man for detailed description of these command-line options.
```


## slow5tools_index

### Tool Description
Create a slow5 or blow5 index file.

### Metadata
- **Docker Image**: quay.io/biocontainers/slow5tools:1.4.0--hee927d3_0
- **Homepage**: https://github.com/hasindu2008/slow5tools
- **Package**: https://anaconda.org/channels/bioconda/packages/slow5tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: slow5tools index  [SLOW5|BLOW5_FILE]
Create a slow5 or blow5 index file.

OPTIONS:
    -h, --help
        Display this message and exit.
```


## slow5tools_get

### Tool Description
Display the read entry for each specified read id from a slow5 file. With no READ_ID, read from standard input newline separated read ids.

### Metadata
- **Docker Image**: quay.io/biocontainers/slow5tools:1.4.0--hee927d3_0
- **Homepage**: https://github.com/hasindu2008/slow5tools
- **Package**: https://anaconda.org/channels/bioconda/packages/slow5tools/overview
- **Validation**: PASS

### Original Help Text
```text
Display the read entry for each specified read id from a slow5 file.
With no READ_ID, read from standard input newline separated read ids.
Usage: slow5tools get [OPTIONS] [SLOW5_FILE] [READ_ID]...

OPTIONS:
    --to FORMAT                   specify output file format
    -o, --output [FILE]           output contents to FILE [default: stdout]
    -c, --compress REC_MTD        record compression method [zlib] (only for blow5 format)
    -s, --sig-compress SIG_MTD    signal compression method [svb-zd] (only for blow5 format)
    -t, --threads INT             number of threads [8]
    -K, --batchsize INT           number of records loaded to the memory at once [4096]
    -l --list [FILE]              list of read ids provided as a single-column text file with one read id per line.
    --skip                        warn and continue if a read_id was not found.
    --index [FILE]                path to a custom slow5 index (experimental).
    -h, --help                    display this message and exit
FORMAT:
    slow5 - SLOW5 ASCII
    blow5 - SLOW5 binary (BLOW5)
REC_MTD:
    none - no record compression
    zlib - Z library (also known as gzip or DEFLATE)
    zstd - Z standard 
SIG_MTD:
    none - no special signal compression
    svb-zd - StreamVByte with zig-zag delta
    ex-zd - exception with zig-zag delta

See https://slow5.bioinf.science/man for detailed description of these command-line options.
```


## slow5tools_view

### Tool Description
View a slow5 as blow5 FILE and vice versa.

### Metadata
- **Docker Image**: quay.io/biocontainers/slow5tools:1.4.0--hee927d3_0
- **Homepage**: https://github.com/hasindu2008/slow5tools
- **Package**: https://anaconda.org/channels/bioconda/packages/slow5tools/overview
- **Validation**: PASS

### Original Help Text
```text
View a slow5 as blow5 FILE and vice versa.
Usage: slow5tools view [OPTIONS] [FILE]

OPTIONS:
        --to FORMAT               specify output file format [slow5, auto detected using extension if -o FILE is provided]
    -o, --output FILE             output to FILE [stdout]
    -c, --compress REC_MTD        record compression method [zlib] (only for blow5 format)
    -s, --sig-compress SIG_MTD    signal compression method [svb-zd] (only for blow5 format)
    -t, --threads INT             number of threads [8]
    -K, --batchsize INT           number of records loaded to the memory at once [4096]
        --from FORMAT             specify input file format [auto]
    -h, --help                    display this message and exit
FORMAT:
    slow5 - SLOW5 ASCII
    blow5 - SLOW5 binary (BLOW5)
REC_MTD:
    none - no record compression
    zlib - Z library (also known as gzip or DEFLATE)
    zstd - Z standard 
SIG_MTD:
    none - no special signal compression
    svb-zd - StreamVByte with zig-zag delta
    ex-zd - exception with zig-zag delta

See https://slow5.bioinf.science/man for detailed description of these command-line options.
```


## slow5tools_stats

### Tool Description
Prints statistics of a SLOW5/BLOW5 file to the stdout. If no argument is given details about slow5tools is printed.

### Metadata
- **Docker Image**: quay.io/biocontainers/slow5tools:1.4.0--hee927d3_0
- **Homepage**: https://github.com/hasindu2008/slow5tools
- **Package**: https://anaconda.org/channels/bioconda/packages/slow5tools/overview
- **Validation**: PASS

### Original Help Text
```text
Prints statistics of a SLOW5/BLOW5 file to the stdout. If no argument is given details about slow5tools is printed. 
Usage: slow5tools stats [SLOW5_FILE]

OPTIONS:
    -h, --help         display this message and exit
```


## slow5tools_cat

### Tool Description
Quickly concatenate SLOW5/BLOW5 files of same type (same header, extension, compression)

### Metadata
- **Docker Image**: quay.io/biocontainers/slow5tools:1.4.0--hee927d3_0
- **Homepage**: https://github.com/hasindu2008/slow5tools
- **Package**: https://anaconda.org/channels/bioconda/packages/slow5tools/overview
- **Validation**: PASS

### Original Help Text
```text
Quickly concatenate SLOW5/BLOW5 files of same type (same header, extension, compression)
Usage: slow5tools cat [SLOW5_FILE/DIR]

OPTIONS:
    -o, --output FILE             output to FILE [stdout]
```


## slow5tools_quickcheck

### Tool Description
Performs a quick check if a SLOW5/BLOW5 file is intact. That is, quickcheck checks if the file begins with a valid header (SLOW5 or BLOW5), attempt to decode the first SLOW5 record and then seeks to the end of the file and checks if proper EOF exists (BLOW5 only).If the file is intact, the commands exists with 0. Otherwise exists with a non-zero error code.

### Metadata
- **Docker Image**: quay.io/biocontainers/slow5tools:1.4.0--hee927d3_0
- **Homepage**: https://github.com/hasindu2008/slow5tools
- **Package**: https://anaconda.org/channels/bioconda/packages/slow5tools/overview
- **Validation**: PASS

### Original Help Text
```text
Performs a quick check if a SLOW5/BLOW5 file is intact. That is, quickcheck checks if the file begins with a valid header (SLOW5 or BLOW5), attempt to decode the first SLOW5 record and then seeks to the end of the file and checks if proper EOF exists (BLOW5 only).If the file is intact, the commands exists with 0. Otherwise exists with a non-zero error code.
Usage: slow5tools quickcheck  [SLOW5_FILE]

OPTIONS:
    -h, --help         display this message and exit
```


## slow5tools_skim

### Tool Description
Skims through requested components in a SLOW5/BLOW5 file. If no options are provided, all the SLOW5 records except the raw signal will be printed.

### Metadata
- **Docker Image**: quay.io/biocontainers/slow5tools:1.4.0--hee927d3_0
- **Homepage**: https://github.com/hasindu2008/slow5tools
- **Package**: https://anaconda.org/channels/bioconda/packages/slow5tools/overview
- **Validation**: PASS

### Original Help Text
```text
Skims through requested components in a SLOW5/BLOW5 file. If no options are provided, all the SLOW5 records except the raw signal will be printed.
Usage: slow5tools skim [OPTIONS] [SLOW5_FILE]

OPTIONS:
    -t, --threads INT             number of threads [8]
    -K, --batchsize INT           number of records loaded to the memory at once [4096]
    --hdr              		  print the header only
    --rid              		  print the list of read ids only
    -h, --help                    display this message and exit
```


## slow5tools_degrade

### Tool Description
Irreversibly degrade and convert slow5/blow5 FILEs.

### Metadata
- **Docker Image**: quay.io/biocontainers/slow5tools:1.4.0--hee927d3_0
- **Homepage**: https://github.com/hasindu2008/slow5tools
- **Package**: https://anaconda.org/channels/bioconda/packages/slow5tools/overview
- **Validation**: PASS

### Original Help Text
```text
Irreversibly degrade and convert slow5/blow5 FILEs.
Usage: slow5tools degrade [OPTIONS] [FILE]

OPTIONS:
        --to FORMAT               specify output file format [slow5, auto detected using extension if -o FILE is provided]
    -o, --output FILE             output to FILE [stdout]
    -c, --compress REC_MTD        record compression method [zlib] (only for blow5 format)
    -s, --sig-compress SIG_MTD    signal compression method [ex-zd] (only for blow5 format)
    -t, --threads INT             number of threads [8]
    -K, --batchsize INT           number of records loaded to the memory at once [4096]
        --from FORMAT             specify input file format [auto]
    -b, --bits INT                specify the number of least significant bits to eliminate [auto]
    -h, --help                    display this message and exit
FORMAT:
    slow5 - SLOW5 ASCII
    blow5 - SLOW5 binary (BLOW5)
REC_MTD:
    none - no record compression
    zlib - Z library (also known as gzip or DEFLATE)
    zstd - Z standard 
SIG_MTD:
    none - no special signal compression
    svb-zd - StreamVByte with zig-zag delta
    ex-zd - exception with zig-zag delta

See https://slow5.bioinf.science/man for detailed description of these command-line options.
```

