# sambamba CWL Generation Report

## sambamba_view

### Tool Description
View and convert SAM/BAM/CRAM files

### Metadata
- **Docker Image**: quay.io/biocontainers/sambamba:1.0.1--he614052_4
- **Homepage**: https://github.com/biod/sambamba
- **Package**: https://anaconda.org/channels/bioconda/packages/sambamba/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sambamba/overview
- **Total Downloads**: 471.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/biod/sambamba
- **Stars**: N/A
### Original Help Text
```text
sambamba 1.0.1
 by Artem Tarasov and Pjotr Prins (C) 2012-2023
    LDC 1.39.0 / DMD v2.109.1 / LLVM17.0.6 / bootstrap LDC - the LLVM D compiler (1.39.0)

Usage: sambamba-view [options] <input.bam | input.sam> [region1 [...]]

Options: -F, --filter=FILTER
                    set custom filter for alignments
         --num-filter=NUMFILTER
                    filter flag bits; 'i1/i2' corresponds to -f i1 -F i2 samtools arguments;
                    either of the numbers can be omitted
         -f, --format=sam|bam|json|unpack
                    specify which format to use for output (default is SAM);
                    unpack streams unpacked BAM
         -h, --with-header
                    print header before reads (always done for BAM output)
         -H, --header
                    output only header to stdout (if format=bam, the header is printed as SAM)
         -I, --reference-info
                    output to stdout only reference names and lengths in JSON
         -L, --regions=FILENAME
                    output only reads overlapping one of regions from the BED file
         -c, --count
                    output to stdout only count of matching records, hHI are ignored
         -v, --valid
                    output only valid alignments
         -S, --sam-input
                    specify that input is in SAM format
         -T, --ref-filename=FASTA
                    specify reference for writing (NA)
         -p, --show-progress
                    show progressbar in STDERR (works only for BAM files with no regions specified)
         -l, --compression-level
                    specify compression level (from 0 to 9, works only for BAM output)
         -o, --output-filename
                    specify output filename
         -t, --nthreads=NTHREADS
                    maximum number of threads to use
         -s, --subsample=FRACTION
                    subsample reads (read pairs)
         --subsampling-seed=SEED
                    set seed for subsampling
```


## sambamba_index

### Tool Description
Creates index for a BAM, or FASTA file

### Metadata
- **Docker Image**: quay.io/biocontainers/sambamba:1.0.1--he614052_4
- **Homepage**: https://github.com/biod/sambamba
- **Package**: https://anaconda.org/channels/bioconda/packages/sambamba/overview
- **Validation**: PASS

### Original Help Text
```text
sambamba 1.0.1
 by Artem Tarasov and Pjotr Prins (C) 2012-2023
    LDC 1.39.0 / DMD v2.109.1 / LLVM17.0.6 / bootstrap LDC - the LLVM D compiler (1.39.0)

Usage: sambamba-index [OPTIONS] <input.bam|input.fasta> [output_file]

	Creates index for a BAM, or FASTA file

Options: -t, --nthreads=NTHREADS
               number of threads to use for decompression
         -p, --show-progress
               show progress bar in STDERR
         -c, --check-bins
               check that bins are set correctly
         -F, --fasta-input
               specify that input is in FASTA format
```


## sambamba_merge

### Tool Description
Merge multiple BAM files into a single BAM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/sambamba:1.0.1--he614052_4
- **Homepage**: https://github.com/biod/sambamba
- **Package**: https://anaconda.org/channels/bioconda/packages/sambamba/overview
- **Validation**: PASS

### Original Help Text
```text
sambamba 1.0.1
 by Artem Tarasov and Pjotr Prins (C) 2012-2023
    LDC 1.39.0 / DMD v2.109.1 / LLVM17.0.6 / bootstrap LDC - the LLVM D compiler (1.39.0)

Usage: sambamba-merge [options] <output.bam> <input1.bam> <input2.bam> [...]

Options: -t, --nthreads=NTHREADS
               number of threads to use for compression/decompression
         -l, --compression-level=COMPRESSION_LEVEL
               level of compression for merged BAM file, number from 0 to 9
         -H, --header
               output merged header to stdout in SAM format, other options are ignored; mainly for debug purposes
         -p, --show-progress
               show progress bar in STDERR
         -F, --filter=FILTER
               keep only reads that satisfy FILTER
```


## sambamba_sort

### Tool Description
Sort BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/sambamba:1.0.1--he614052_4
- **Homepage**: https://github.com/biod/sambamba
- **Package**: https://anaconda.org/channels/bioconda/packages/sambamba/overview
- **Validation**: PASS

### Original Help Text
```text
sambamba 1.0.1
 by Artem Tarasov and Pjotr Prins (C) 2012-2023
    LDC 1.39.0 / DMD v2.109.1 / LLVM17.0.6 / bootstrap LDC - the LLVM D compiler (1.39.0)

Usage: sambamba-sort [options] <input.bam>

Options: -m, --memory-limit=LIMIT
               approximate total memory limit for all threads (by default 2GB)
         --tmpdir=TMPDIR
               directory for storing intermediate files; default is system directory for temporary files
         -o, --out=OUTPUTFILE
               output file name; if not provided, the result is written to a file with .sorted.bam extension
         -n, --sort-by-name
               sort by read name instead of coordinate (lexicographical order)
         --sort-picard
               sort by query name like in picard
         -N, --natural-sort
               sort by read name instead of coordinate (so-called 'natural' sort as in samtools)
         -M, --match-mates
               pull mates of the same alignment together when sorting by read name
         -l, --compression-level=COMPRESSION_LEVEL
               level of compression for sorted BAM, from 0 to 9
         -u, --uncompressed-chunks
               write sorted chunks as uncompressed BAM (default is writing with compression level 1), that might be faster in some cases but uses more disk space
         -p, --show-progress
               show progressbar in STDERR
         -t, --nthreads=NTHREADS
               use specified number of threads
         -F, --filter=FILTER
               keep only reads that satisfy FILTER
```


## sambamba_slice

### Tool Description
Fast copy of a region from indexed BAM or FASTA file to a new file

### Metadata
- **Docker Image**: quay.io/biocontainers/sambamba:1.0.1--he614052_4
- **Homepage**: https://github.com/biod/sambamba
- **Package**: https://anaconda.org/channels/bioconda/packages/sambamba/overview
- **Validation**: PASS

### Original Help Text
```text
sambamba 1.0.1
 by Artem Tarasov and Pjotr Prins (C) 2012-2023
    LDC 1.39.0 / DMD v2.109.1 / LLVM17.0.6 / bootstrap LDC - the LLVM D compiler (1.39.0)

Usage: sambamba-slice [options] <input.bam|input.fasta> [region1 [...]]

       Fast copy of a region from indexed BAM or FASTA file to a new file

       Regions are given in standard form ref:beg-end.
       FASTA index file name must match FASTA file name, e.g. <input.fai>
       In addition, region '*' denotes reads with no reference.
       Output is to STDOUT unless output filename is specified.

OPTIONS: -o, --output-filename=OUTPUT_FILENAME
            output BAM or FASTA filename
         -L, --regions=FILENAME
            output only reads overlapping one of regions from the BED file
         -F, --fasta-input
               specify that input is in FASTA format
```


## sambamba_markdup

### Tool Description
Marks the duplicates without removing them

### Metadata
- **Docker Image**: quay.io/biocontainers/sambamba:1.0.1--he614052_4
- **Homepage**: https://github.com/biod/sambamba
- **Package**: https://anaconda.org/channels/bioconda/packages/sambamba/overview
- **Validation**: PASS

### Original Help Text
```text
sambamba 1.0.1
 by Artem Tarasov and Pjotr Prins (C) 2012-2023
    LDC 1.39.0 / DMD v2.109.1 / LLVM17.0.6 / bootstrap LDC - the LLVM D compiler (1.39.0)

Usage: sambamba-markdup [options] <input.bam> [<input2.bam> [...]] <output.bam>
       By default, marks the duplicates without removing them

Options: -r, --remove-duplicates
                    remove duplicates instead of just marking them
         -t, --nthreads=NTHREADS
                    number of threads to use
         -l, --compression-level=N
                    specify compression level of the resulting file (from 0 to 9)
         -p, --show-progress
                    show progressbar in STDERR
         --tmpdir=TMPDIR
                    specify directory for temporary files

Performance tweaking parameters
         --hash-table-size=HASH_TABLE_SIZE
                    size of hash table for finding read pairs (default is 262144 reads);
                    will be rounded down to the nearest power of two;
                    should be > (average coverage) * (insert size) for good performance
         --overflow-list-size=OVERFLOW_LIST_SIZE
                    size of the overflow list where reads, thrown from the hash table,
                    get a second chance to meet their pairs (default is 200000 reads);
                    increasing the size reduces the number of temporary files created
         --sort-buffer-size=SORT_BUFFER_SIZE
                    total amount of memory (in *megabytes*) used for sorting purposes;
                    the default is 2048, increasing it will reduce the number of created
                    temporary files and the time spent in the main thread
         --io-buffer-size=BUFFER_SIZE
                    two buffers of BUFFER_SIZE *megabytes* each are used
                    for reading and writing BAM during the second pass (default is 128)
```


## sambamba_subsample

### Tool Description
Subsample BAM files

### Metadata
- **Docker Image**: quay.io/biocontainers/sambamba:1.0.1--he614052_4
- **Homepage**: https://github.com/biod/sambamba
- **Package**: https://anaconda.org/channels/bioconda/packages/sambamba/overview
- **Validation**: PASS

### Original Help Text
```text
sambamba 1.0.1
 by Artem Tarasov and Pjotr Prins (C) 2012-2023
    LDC 1.39.0 / DMD v2.109.1 / LLVM17.0.6 / bootstrap LDC - the LLVM D compiler (1.39.0)

object.Exception@sambamba/subsample.d(357): Output not defined
----------------
??:? [0x5f3c34516a06]
??:? [0x5f3c34516672]
??:? [0x5f3c3453f51e]
??:? [0x5f3c3451f7cf]
/opt/conda/conda-bld/sambamba_1740593116859/_h_env_placehold_placehold_placehold_placehold_placehold_placehold_placehold_placehold_placehold_placehold_placehold_placehold_placehold_placehold_placehold_placehold_placehold_placehold_placehold_placehold_plac/include/d/std/exception.d:522 [0x5f3c34474b47]
/opt/conda/conda-bld/sambamba_1740593116859/_h_env_placehold_placehold_placehold_placehold_placehold_placehold_placehold_placehold_placehold_placehold_placehold_placehold_placehold_placehold_placehold_placehold_placehold_placehold_placehold_placehold_plac/include/d/std/exception.d:442 [0x5f3c343e56fe]
sambamba/main.d:114 [0x5f3c3440fd6e]
??:? [0x5f3c3451f4ac]
??:? [0x5f3c3451f3a6]
??:? [0x5f3c3451f1fc]
??:? [0x7432501dc249]
??:? __libc_start_main [0x7432501dc304]
??:? [0x5f3c343a3d29]
```


## sambamba_flagstat

### Tool Description
Outputs SAM/BAM/CRAM alignment statistics.

### Metadata
- **Docker Image**: quay.io/biocontainers/sambamba:1.0.1--he614052_4
- **Homepage**: https://github.com/biod/sambamba
- **Package**: https://anaconda.org/channels/bioconda/packages/sambamba/overview
- **Validation**: PASS

### Original Help Text
```text
sambamba 1.0.1
 by Artem Tarasov and Pjotr Prins (C) 2012-2023
    LDC 1.39.0 / DMD v2.109.1 / LLVM17.0.6 / bootstrap LDC - the LLVM D compiler (1.39.0)

Usage: sambamba-flagstat [options] <input.bam>

OPTIONS: -t, --nthreads=NTHREADS
            use NTHREADS for decompression
         -p, --show-progress
            show progressbar in STDERR
         -b, --tabular
            output in csv format
```


## sambamba_depth

### Tool Description
Calculate depth of coverage for BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/sambamba:1.0.1--he614052_4
- **Homepage**: https://github.com/biod/sambamba
- **Package**: https://anaconda.org/channels/bioconda/packages/sambamba/overview
- **Validation**: PASS

### Original Help Text
```text
sambamba 1.0.1
 by Artem Tarasov and Pjotr Prins (C) 2012-2023
    LDC 1.39.0 / DMD v2.109.1 / LLVM17.0.6 / bootstrap LDC - the LLVM D compiler (1.39.0)

Usage: sambamba-depth region|window|base [options] input.bam  [input2.bam [...]]

          All BAM files must be coordinate-sorted and indexed.

          The tool has three modes: base, region, and window,
          each name means per which unit to print the statistics.

Common options:
         -F, --filter=FILTER
                    set custom filter for alignments; the default value is
                    'mapping_quality > 0 and not duplicate and not failed_quality_control'
         -o, --output-file=FILENAME
                    output filename (by default /dev/stdout)
         -t, --nthreads=NTHREADS
                    maximum number of threads to use
         -c, --min-coverage=MINCOVERAGE
                    minimum mean coverage for output (default: 0 for region/window, 1 for base)
         -C, --max-coverage=MAXCOVERAGE
                    maximum mean coverage for output
         -q, --min-base-quality=QUAL
                    don't count bases with lower base quality
         --combined
                    output combined statistics for all samples
         -a, --annotate
                    add additional column of y/n instead of
                    skipping records not satisfying the criteria
         -m, --fix-mate-overlaps
                    detect overlaps of mate reads and handle them on per-base basis
base subcommand options:
         -L, --regions=FILENAME|REGION
                    list or regions of interest or a single region in form chr:beg-end (optional)
         -z, --report-zero-coverage (DEPRECATED, use --min-coverage=0 instead)
                    don't skip zero coverage bases
region subcommand options:
         -L, --regions=FILENAME|REGION
                    list or regions of interest or a single region in form chr:beg-end (required)
         -T, --cov-threshold=COVTHRESHOLD
                    multiple thresholds can be provided,
                    for each one an extra column will be added,
                    the percentage of bases in the region
                    where coverage is more than this value
window subcommand options:
         -w, --window-size=WINDOWSIZE
                    breadth of the window, in bp (required)
         --overlap=OVERLAP
                    overlap of successive windows, in bp (default is 0)
         -T, --cov-threshold=COVTHRESHOLD
                    same meaning as in 'region' subcommand
```


## sambamba_validate

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/sambamba:1.0.1--he614052_4
- **Homepage**: https://github.com/biod/sambamba
- **Package**: https://anaconda.org/channels/bioconda/packages/sambamba/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
sambamba 1.0.1
 by Artem Tarasov and Pjotr Prins (C) 2012-2023
    LDC 1.39.0 / DMD v2.109.1 / LLVM17.0.6 / bootstrap LDC - the LLVM D compiler (1.39.0)

INFO: Reading input files
```


## sambamba_mpileup

### Tool Description
This subcommand relies on external tools and acts as a multi-core
implementation of samtools and bcftools.

### Metadata
- **Docker Image**: quay.io/biocontainers/sambamba:1.0.1--he614052_4
- **Homepage**: https://github.com/biod/sambamba
- **Package**: https://anaconda.org/channels/bioconda/packages/sambamba/overview
- **Validation**: PASS

### Original Help Text
```text
sambamba 1.0.1
 by Artem Tarasov and Pjotr Prins (C) 2012-2023
    LDC 1.39.0 / DMD v2.109.1 / LLVM17.0.6 / bootstrap LDC - the LLVM D compiler (1.39.0)

usage: sambamba-pileup [options] input.bam [input2.bam [...]]
                       [--samtools <samtools mpileup args>]
                       [--bcftools <bcftools call args>]

This subcommand relies on external tools and acts as a multi-core
implementation of samtools and bcftools.

Therefore, the following tools should be present in $PATH:
    * samtools
    * bcftools (when used)

If --samtools is skipped, samtools mpileup is called with default arguments
If --bcftools is used without parameters, samtools is called with
     switch '-gu' and bcftools is called as 'bcftools view -'
If --bcftools is skipped, bcftools is not called

Sambamba splits input BAM files into chunks and feeds them
to samtools mpileup and, optionally, bcftools in parallel.
The chunks are slightly overlapping so that variant calling
should not be impacted by these manipulations. The obtained results
from the multiple processes are combined as ordered output.

Sambamba options:
         -L, --regions=FILENAME
                    provide BED file with regions
                    (no need to duplicate it in samtools args);
                    all input files must be indexed
         -o, --output-filename=<STDOUT>
                    specify output filename
         --tmpdir=TMPDIR
                    directory for temporary files
         -t, --nthreads=NTHREADS
                    maximum number of threads to use
         -b, --buffer-size=64_000_000
                    chunk size (in bytes)
         -B, --output-buffer-size=512_000_000
                    output buffer size (in bytes)

Sambamba paths:

sambamba-pileup: failed to locate samtools executable in PATH
```


## Metadata
- **Skill**: generated
