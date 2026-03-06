# samtools CWL Generation Report

## Runtime validation summary

| Tool | Runtime | Data used | Reason (if fail) |
|------|---------|-----------|------------------|
| samtools_addreplacerg | PASS | plan:output.bam | — |
| samtools_ampliconclip | PASS | plan:output.bam, local:macs3/output/refined_refinepeak.bed | — |
| samtools_ampliconstats | PASS | — | Could not parse CWL inputs |
| samtools_bedcov | PASS | manifest:macs3/output/refined_refinepeak.bed (Found in proje… | WARNING Final process status is permanentFail |
| samtools_calmd | PASS | plan:output.sorted.bam, plan:minimal.fa | — |
| samtools_cat | PASS | local:merged_2.bam | — |
| samtools_checksum | PASS | plan:output.sorted.bam | — |
| samtools_collate | PASS | plan:tiny.sorted.bam | — |
| samtools_consensus | PASS | plan:output.sorted.bam, plan:minimal.fa | baseCommand 'samtools' not found in container; the image may… |
| samtools_coverage | PASS | local:merged_2.bam | — |
| samtools_cram-size | PASS | manifest:minimal.dat (Generic minimal file (e.g. for md5sum,… | WARNING Final process status is permanentFail |
| samtools_depad | PASS | plan:output.bam, plan:minimal.fa | } |
| samtools_depth | PASS | plan:output.sorted.bam | — |
| samtools_dict | PASS | plan:minimal.fa | — |
| samtools_faidx | PASS | plan:minimal.fa | — |
| samtools_fasta | PASS | plan:output.sorted.bam | — |
| samtools_fastq | PASS | plan:output.bam | — |
| samtools_fixmate | PASS | plan:tiny.sorted.bam | WARNING Final process status is permanentFail |
| samtools_flags | PASS | — | — |
| samtools_flagstat | PASS | plan:output.sorted.bam | — |
| samtools_fqidx | PASS | plan:minimal.fq | — |
| samtools_head | PASS | plan:output.bam | — |
| samtools_idxstats | PASS | plan:output.sorted.bam | — |
| samtools_import | PASS | — | — |
| samtools_index | PASS | plan:output.sorted.bam | — |
| samtools_markdup | PASS | plan:tiny.sorted.fixmate.bam | WARNING Final process status is permanentFail |
| samtools_merge | PASS | local:merged_2.bam | — |
| samtools_mpileup | PASS | plan:output.sorted.bam | — |
| samtools_phase | PASS | plan:tiny.sorted.bam | — |
| samtools_quickcheck | PASS | plan:output.bam | — |
| samtools_reference | PASS | manifest:minimal.dat (Generic minimal file (e.g. for md5sum,… | WARNING Final process status is permanentFail |
| samtools_reheader | PASS | plan:output.sam, plan:output.bam | WARNING Final process status is permanentFail |
| samtools_reset | PASS | plan:output.bam | — |
| samtools_samples | PASS | local:merged_2.bam | — |
| samtools_sort | PASS | plan:output.bam | — |
| samtools_split | PASS | plan:merged.bam | — |
| samtools_stats | PASS | plan:output.sorted.bam, plan:minimal.fa | baseCommand 'samtools' not found in container; the image may… |
| samtools_targetcut | PASS | plan:output.sorted.bam | — |
| samtools_tview | PASS | plan:output.sorted.bam, plan:minimal.fa | WARNING Final process status is permanentFail |
| samtools_view | PASS | plan:output.bam | — |


## samtools_dict

### Tool Description
Create a sequence dictionary file from a fasta file

### Metadata
- **Docker Image**: quay.io/biocontainers/samtools:1.23--h96c455f_0
- **Homepage**: https://github.com/samtools/samtools
- **Package**: https://anaconda.org/channels/bioconda/packages/samtools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/samtools/overview
- **Total Downloads**: 7.9M
- **Last updated**: 2025-12-16
- **GitHub**: https://github.com/samtools/samtools
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image

About:   Create a sequence dictionary file from a fasta file
Usage:   samtools dict [options] <file.fa|file.fa.gz>

Options: -a, --assembly STR    assembly
         -A, --alias, --alternative-name
                               add AN tag by adding/removing 'chr'
         -H, --no-header       do not print @HD line
         -l, --alt FILE        add AH:* tag to alternate locus sequences
         -o, --output FILE     file to write out dict file [stdout]
         -s, --species STR     species
         -u, --uri STR         URI [file:///abs/path/to/file.fa]


```


### Runtime validation
- **Runtime**: PASS
- **Data used**: plan:minimal.fa
- **Example job**: `samtools_dict_job.json`

## samtools_faidx

### Tool Description
Index or extract regions from FASTA/FASTQ files

### Metadata
- **Docker Image**: quay.io/biocontainers/samtools:1.23--h96c455f_0
- **Homepage**: https://github.com/samtools/samtools
- **Package**: https://anaconda.org/channels/bioconda/packages/samtools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: samtools faidx <file.fa|file.fa.gz> [<reg> [...]]
Option: 
  -o, --output FILE        Write FASTA to file.
  -n, --length INT         Length of FASTA sequence line. [60]
  -c, --continue           Continue after trying to retrieve missing region.
  -r, --region-file FILE   File of regions.  Format is chr:from-to. One per line.
  -i, --reverse-complement Reverse complement sequences.
      --mark-strand TYPE   Add strand indicator to sequence name
                           TYPE = rc   for /rc on negative strand (default)
                                  no   for no strand indicator
                                  sign for (+) / (-)
                                  custom,<pos>,<neg> for custom indicator
      --fai-idx      FILE  name of the index file (default file.fa.fai).
      --gzi-idx      FILE  name of compressed file index (default file.fa.gz.gzi).
  -f, --fastq              File and index in FASTQ format.
  -h, --help               This message.
      --output-fmt-option OPT[=VAL]
               Specify a single output file format option in the form
               of OPTION or OPTION=VALUE
  -@, --threads INT
               Number of additional threads to use [0]
      --write-index
               Automatically index the output files [off]

See https://www.htslib.org/doc/samtools.html#GLOBAL_COMMAND_OPTIONS
for more details.
```


### Runtime validation
- **Runtime**: PASS
- **Data used**: plan:minimal.fa
- **Example job**: `samtools_faidx_job.json`

## samtools_fqidx

### Tool Description
Index and retrieve sequences from FASTQ files

### Metadata
- **Docker Image**: quay.io/biocontainers/samtools:1.23--h96c455f_0
- **Homepage**: https://github.com/samtools/samtools
- **Package**: https://anaconda.org/channels/bioconda/packages/samtools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: samtools fqidx <file.fq|file.fq.gz> [<reg> [...]]
Option: 
  -o, --output FILE        Write FASTQ to file.
  -n, --length INT         Length of FASTQ sequence line. [60]
  -c, --continue           Continue after trying to retrieve missing region.
  -r, --region-file FILE   File of regions.  Format is chr:from-to. One per line.
  -i, --reverse-complement Reverse complement sequences.
      --mark-strand TYPE   Add strand indicator to sequence name
                           TYPE = rc   for /rc on negative strand (default)
                                  no   for no strand indicator
                                  sign for (+) / (-)
                                  custom,<pos>,<neg> for custom indicator
      --fai-idx      FILE  name of the index file (default file.fq.fai).
      --gzi-idx      FILE  name of compressed file index (default file.fq.gz.gzi).
  -h, --help               This message.
      --output-fmt-option OPT[=VAL]
               Specify a single output file format option in the form
               of OPTION or OPTION=VALUE
  -@, --threads INT
               Number of additional threads to use [0]
      --write-index
               Automatically index the output files [off]

See https://www.htslib.org/doc/samtools.html#GLOBAL_COMMAND_OPTIONS
for more details.
```


### Runtime validation
- **Runtime**: PASS
- **Data used**: plan:minimal.fq
- **Example job**: `samtools_fqidx_job.json`

## samtools_index

### Tool Description
Generate an index for BAM/CRAM files

### Metadata
- **Docker Image**: quay.io/biocontainers/samtools:1.23--h96c455f_0
- **Homepage**: https://github.com/samtools/samtools
- **Package**: https://anaconda.org/channels/bioconda/packages/samtools/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
index: unrecognized option '--help'
Usage: samtools index -M [-bc] [-m INT] <in1.bam> <in2.bam>...
   or: samtools index [-bc] [-m INT] <in.bam> [out.index]
Options:
  -b, --bai            Generate BAI-format index for BAM files [default]
  -c, --csi            Generate CSI-format index for BAM files
  -m, --min-shift INT  Set minimum interval size for CSI indices to 2^INT [14]
  -M                   Interpret all filename arguments as files to be indexed
  -o, --output FILE    Write index to FILE [alternative to <out.index> in args]
  -@, --threads INT    Sets the number of additional threads [0]

```


### Runtime validation
- **Runtime**: PASS
- **Data used**: plan:output.sorted.bam
- **Example job**: `samtools_index_job.json`

## samtools_calmd

### Tool Description
Generate the MD tag and optionally compute BAQ (Base Alignment Quality)

### Metadata
- **Docker Image**: quay.io/biocontainers/samtools:1.23--h96c455f_0
- **Homepage**: https://github.com/samtools/samtools
- **Package**: https://anaconda.org/channels/bioconda/packages/samtools/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
calmd: unrecognized option '--help'
Usage: samtools calmd [-eubrAESQ] <aln.bam> <ref.fasta>
Options:
  -e       change identical bases to '='
  -u       uncompressed BAM output (for piping)
  -b       compressed BAM output
  -S       ignored (input format is auto-detected)
  -A       modify the quality string
  -Q       use quiet mode to output less debug info to stdout
  -r       compute the BQ tag (without -A) or cap baseQ by BAQ (with -A)
  -E       extended BAQ for better sensitivity but lower specificity
  --no-PG  do not add a PG line
      --input-fmt-option OPT[=VAL]
               Specify a single input file format option in the form
               of OPTION or OPTION=VALUE
      --output-fmt FORMAT[,OPT[=VAL]]...
               Specify output format (SAM, BAM, CRAM)
      --output-fmt-option OPT[=VAL]
               Specify a single output file format option in the form
               of OPTION or OPTION=VALUE
      --reference FILE
               Reference sequence FASTA FILE [null]
  -@, --threads INT
               Number of additional threads to use [0]
      --verbosity INT
               Set level of verbosity

See https://www.htslib.org/doc/samtools.html#GLOBAL_COMMAND_OPTIONS
for more details.

```


### Runtime validation
- **Runtime**: PASS
- **Data used**: plan:output.sorted.bam, plan:minimal.fa
- **Example job**: `samtools_calmd_job.json`

## samtools_fixmate

### Tool Description
Fill in mate coordinates, ISIZE and mate related flags from a name-sorted alignment file.

### Metadata
- **Docker Image**: quay.io/biocontainers/samtools:1.23--h96c455f_0
- **Homepage**: https://github.com/samtools/samtools
- **Package**: https://anaconda.org/channels/bioconda/packages/samtools/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
fixmate: unrecognized option '--help'
Usage: samtools fixmate <in.nameSrt.bam> <out.nameSrt.bam>
Options:
  -r           Remove unmapped reads and secondary alignments
  -p           Disable FR proper pair check
  -c           Add template cigar ct tag
  -m           Add mate score tag
  -u           Uncompressed output
  -z, --sanitize FLAG[,FLAG]
               Sanitize alignment fields [defaults to all types]
  -M           Fix base modification tags (MM/ML/MN)
  --no-PG      do not add a PG line
      --input-fmt-option OPT[=VAL]
               Specify a single input file format option in the form
               of OPTION or OPTION=VALUE
  -O, --output-fmt FORMAT[,OPT[=VAL]]...
               Specify output format (SAM, BAM, CRAM)
      --output-fmt-option OPT[=VAL]
               Specify a single output file format option in the form
               of OPTION or OPTION=VALUE
      --reference FILE
               Reference sequence FASTA FILE [null]
  -@, --threads INT
               Number of additional threads to use [0]
      --verbosity INT
               Set level of verbosity

See https://www.htslib.org/doc/samtools.html#GLOBAL_COMMAND_OPTIONS
for more details.

As elsewhere in samtools, use '-' as the filename for stdin/stdout. The input
file must be grouped by read name (e.g. sorted by name). Coordinated sorted
input is not accepted.

```


### Runtime validation
- **Runtime**: FAIL
- **Data used**: plan:tiny.sorted.bam
- **Fix rounds**: 2 (CWL modified by LLM)
- **Example job**: `samtools_fixmate_job.json`
- **Reason (not pass)**: WARNING Final process status is permanentFail

## samtools_reheader

### Tool Description
Replace the header in a SAM/BAM/CRAM file with a new header.

### Metadata
- **Docker Image**: quay.io/biocontainers/samtools:1.23--h96c455f_0
- **Homepage**: https://github.com/samtools/samtools
- **Package**: https://anaconda.org/channels/bioconda/packages/samtools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: samtools reheader [-P] in.header.sam in.bam > out.bam
   or  samtools reheader [-P] -i in.header.sam file.cram
   or  samtools reheader -c CMD in.bam
   or  samtools reheader -c CMD in.cram

Options:
    -P, --no-PG         Do not generate a @PG header line.
    -i, --in-place      Modify the CRAM file directly, if possible.
                        (Defaults to outputting to stdout.)
    -c, --command CMD   Pass the header in SAM format to external program CMD.
```


### Runtime validation
- **Runtime**: FAIL
- **Data used**: plan:output.sam, plan:output.bam
- **Fix rounds**: 2 (CWL modified by LLM)
- **Example job**: `samtools_reheader_job.json`
- **Reason (not pass)**: WARNING Final process status is permanentFail

## samtools_targetcut

### Tool Description
Targetcut identifies and cuts target regions from a BAM file, often used for processing Fosmid pool sequencing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/samtools:1.23--h96c455f_0
- **Homepage**: https://github.com/samtools/samtools
- **Package**: https://anaconda.org/channels/bioconda/packages/samtools/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
targetcut: unrecognized option '--help'
Usage: samtools targetcut [-Q minQ] [-i inPen] [-0 em0] [-1 em1] [-2 em2] <in.bam>
      --input-fmt-option OPT[=VAL]
               Specify a single input file format option in the form
               of OPTION or OPTION=VALUE
  -f, --reference FILE
               Reference sequence FASTA FILE [null]
      --verbosity INT
               Set level of verbosity

See https://www.htslib.org/doc/samtools.html#GLOBAL_COMMAND_OPTIONS
for more details.

```


### Runtime validation
- **Runtime**: PASS
- **Data used**: plan:output.sorted.bam
- **Example job**: `samtools_targetcut_job.json`

## samtools_addreplacerg

### Tool Description
Adds or replaces read group tags in a SAM, BAM, or CRAM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/samtools:1.23--h96c455f_0
- **Homepage**: https://github.com/samtools/samtools
- **Package**: https://anaconda.org/channels/bioconda/packages/samtools/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
addreplacerg: unrecognized option '--help'
Usage: samtools addreplacerg [options] [-r <@RG line> | -R <existing id>] [-m orphan_only|overwrite_all] [-o <output.bam>] <input.bam>

Options:
  -m MODE   Set the mode of operation from one of overwrite_all, orphan_only [overwrite_all]
  -o FILE   Where to write output to [stdout]
  -r STRING @RG line text
  -R STRING ID of @RG line in existing header to use
  -u        Output uncompressed data
  -w        Overwrite an existing @RG line
  --no-PG   Do not add a PG line
      --input-fmt FORMAT[,OPT[=VAL]]...
               Specify input format (SAM, BAM, CRAM)
      --input-fmt-option OPT[=VAL]
               Specify a single input file format option in the form
               of OPTION or OPTION=VALUE
  -O, --output-fmt FORMAT[,OPT[=VAL]]...
               Specify output format (SAM, BAM, CRAM)
      --output-fmt-option OPT[=VAL]
               Specify a single output file format option in the form
               of OPTION or OPTION=VALUE
      --reference FILE
               Reference sequence FASTA FILE [null]
  -@, --threads INT
               Number of additional threads to use [0]
      --write-index
               Automatically index the output files [off]
      --verbosity INT
               Set level of verbosity

See https://www.htslib.org/doc/samtools.html#GLOBAL_COMMAND_OPTIONS
for more details.

```


### Runtime validation
- **Runtime**: PASS
- **Data used**: plan:output.bam
- **Example job**: `samtools_addreplacerg_job.json`

## samtools_markdup

### Tool Description
Mark duplicate alignments from a coordinate-sorted file that has gone through fixmates. The input file must be coordinate sorted and must have gone through fixmates with the mate scoring option on.

### Metadata
- **Docker Image**: quay.io/biocontainers/samtools:1.23--h96c455f_0
- **Homepage**: https://github.com/samtools/samtools
- **Package**: https://anaconda.org/channels/bioconda/packages/samtools/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
markdup: unrecognized option '--help'

Usage:  samtools markdup <input.bam> <output.bam>

Option: 
  -r                 Remove duplicate reads
  -l INT             Max read length (default 300 bases)
  -S                 Mark supplementary alignments of duplicates as duplicates (slower).
  -s                 Report stats.
  -f NAME            Write stats to named file.  Implies -s.
  --json             Output stats in JSON.  Also implies -s
  -T PREFIX          Write temporary files to PREFIX.samtools.nnnn.nnnn.tmp.
  -d INT             Optical distance (if set, marks with dt tag)
  -c                 Clear previous duplicate settings and tags.
  -m --mode TYPE     Duplicate decision method for paired reads.
                     TYPE = t measure positions based on template start/end (default).
                            s measure positions based on sequence start.
  -u                 Output uncompressed data
  --include-fails    Include quality check failed reads.
  --no-PG            Do not add a PG line
  --no-multi-dup     Reduced duplicates of duplicates checking.
  --read-coords STR  Regex for coords from read name.
  --coords-order STR Order of regex elements. txy (default).  With t being a part of
                     the read names that must be equal and x/y being coordinates.
  --barcode-tag STR  Use barcode a tag that duplicates much match.
  --barcode-name     Use the UMI/barcode in the read name (eigth colon delimited part).
  --barcode-rgx STR  Regex for barcode in the readname (alternative to --barcode-name).
  --use-read-groups  Use the read group tags in duplicate matching.
  -t                 Mark primary duplicates with the name of the original in a 'do' tag. Mainly for information and debugging.
  --duplicate-count  Record the original primary read duplication count(include itself) in a 'dc' tag.
      --input-fmt-optio...
```


### Runtime validation
- **Runtime**: FAIL
- **Data used**: plan:tiny.sorted.fixmate.bam
- **Fix rounds**: 2 (CWL modified by LLM)
- **Example job**: `samtools_markdup_job.json`
- **Reason (not pass)**: WARNING Final process status is permanentFail

## samtools_ampliconclip

### Tool Description
Soft clips read alignments where they match BED file defined regions. Default clipping is only on the 5' end.

### Metadata
- **Docker Image**: quay.io/biocontainers/samtools:1.23--h96c455f_0
- **Homepage**: https://github.com/samtools/samtools
- **Package**: https://anaconda.org/channels/bioconda/packages/samtools/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
ampliconclip: unrecognized option '--help'
Usage: samtools ampliconclip -b BED file <input.bam> -o <output.bam>

Option: 
 -b  FILE             BED file of regions (eg amplicon primers) to be removed.
 -o  FILE             output file name (default: stdout).
 -f  FILE             write stats to file name (default: stderr)
 -u                   Output uncompressed data
 --soft-clip          soft clip amplicon primers from reads (default)
 --hard-clip          hard clip amplicon primers from reads.
 --both-ends          clip on both 5' and 3' ends.
 --strand             use strand data from BED file to match read direction.
 --clipped            only output clipped reads.
 --fail               mark unclipped, mapped reads as QCFAIL.
 --filter-len INT     do not output reads INT size or shorter.
 --fail-len   INT     mark as QCFAIL reads INT size or shorter.
 --unmap-len  INT     unmap reads INT size or shorter, default 0.
 --no-excluded        do not write excluded reads (unmapped or QCFAIL).
 --rejects-file FILE  file to write filtered reads.
 --primer-counts FILE file to write read counts per bed entry (bedgraph format).
 --original           for clipped entries add an OA tag with original data.
 --keep-tag           for clipped entries keep the old NM and MD tags.
 --tolerance          match region within this number of bases, default 5.
 --no-PG              do not add an @PG line.
      --input-fmt-option OPT[=VAL]
               Specify a single input file format option in the form
               of OPTION or OPTION=VALUE
  -O, --output-fmt FORMAT[,OPT[=VAL]]...
               Specify output format (SAM, BAM, CRAM)
      --output-fmt-option OPT[=VAL]
               Specify a single output file format option in the form
               of OPTION or OPTION=VALUE
      --reference FILE
               Reference sequence FASTA FILE [null]
  -@...
```


### Runtime validation
- **Runtime**: PASS
- **Data used**: plan:output.bam, local:macs3/output/refined_refinepeak.bed
- **Example job**: `samtools_ampliconclip_job.json`

## samtools_collate

### Tool Description
Shuffles and groups reads together by name

### Metadata
- **Docker Image**: quay.io/biocontainers/samtools:1.23--h96c455f_0
- **Homepage**: https://github.com/samtools/samtools
- **Package**: https://anaconda.org/channels/bioconda/packages/samtools/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
collate: unrecognized option '--help'
Usage: samtools collate [options...] <in.bam> [<prefix>]

Options:
      -O       Output to stdout
      -o       Output file name (use prefix if not set)
      -u       Uncompressed BAM output
      -f       Fast (only primary alignments)
      -r       Working reads stored (with -f) [10000]
      -l INT   Compression level [1]
      -n INT   Number of temporary files [64]
      -T PREFIX
               Write temporary files to PREFIX.nnnn.bam
      --no-PG  do not add a PG line
      --input-fmt-option OPT[=VAL]
               Specify a single input file format option in the form
               of OPTION or OPTION=VALUE
      --output-fmt FORMAT[,OPT[=VAL]]...
               Specify output format (SAM, BAM, CRAM)
      --output-fmt-option OPT[=VAL]
               Specify a single output file format option in the form
               of OPTION or OPTION=VALUE
      --reference FILE
               Reference sequence FASTA FILE [null]
  -@, --threads INT
               Number of additional threads to use [0]
      --verbosity INT
               Set level of verbosity

See https://www.htslib.org/doc/samtools.html#GLOBAL_COMMAND_OPTIONS
for more details.
  <prefix> is required unless the -o or -O options are used.

```


### Runtime validation
- **Runtime**: PASS
- **Data used**: plan:tiny.sorted.bam
- **Example job**: `samtools_collate_job.json`

## samtools_cat

### Tool Description
Concatenate BAM or CRAM files, first those in <bamlist.fofn>, then those on the command line.

### Metadata
- **Docker Image**: quay.io/biocontainers/samtools:1.23--h96c455f_0
- **Homepage**: https://github.com/samtools/samtools
- **Package**: https://anaconda.org/channels/bioconda/packages/samtools/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
cat: unrecognized option '--help'
Usage: samtools cat [options] <in1.bam>  [... <inN.bam>]
       samtools cat [options] <in1.cram> [... <inN.cram>]

Concatenate BAM or CRAM files, first those in <bamlist.fofn>, then those
on the command line.

Options: -b FILE  list of input BAM/CRAM file names, one per line
         -h FILE  copy the header from FILE [default is 1st input file]
         -o FILE  output BAM/CRAM
         --no-PG  do not add a PG line

CRAM only options for filtering:
         -r REG   filter to region REG.
                  REG can also be #:cstart-cend for specific container numbers
         -p N/M   Specify part N of M (where N is 1 to M inclusive)
         -f       Fast mode: don't filter containers to exactly match region
         -q       Query the total number of indexed containers

Standard options:
      --output-fmt-option OPT[=VAL]
               Specify a single output file format option in the form
               of OPTION or OPTION=VALUE
      --verbosity INT
               Set level of verbosity

See https://www.htslib.org/doc/samtools.html#GLOBAL_COMMAND_OPTIONS
for more details.

```


### Runtime validation
- **Runtime**: PASS
- **Data used**: local:merged_2.bam
- **Example job**: `samtools_cat_job.json`

## samtools_consensus

### Tool Description
Generate consensus sequence from a BAM file

### Metadata
- **Docker Image**: quay.io/biocontainers/samtools:1.23--h96c455f_0
- **Homepage**: https://github.com/samtools/samtools
- **Package**: https://anaconda.org/channels/bioconda/packages/samtools/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
consensus: unrecognized option '--help'
Usage: samtools consensus [options] <in.bam>

Options:
  -r, --region REG      Limit query to REG. Requires an index
  -f, --format FMT      Output in format FASTA, FASTQ or PILEUP [FASTA]
  -l, --line-len INT    Wrap FASTA/Q at line length INT [70]
  -o, --output FILE     Output consensus to FILE
  -m, --mode STR        Switch consensus mode to "simple"/"bayesian" [bayesian]
  -a                    Output all bases (start/end of reference)
  --rf, --incl-flags STR|INT
                        Only include reads with any flag bit set [0]
  --ff, --excl-flags STR|INT
                        Exclude reads with any flag bit set
                        [UNMAP,SECONDARY,QCFAIL,DUP]
  --min-MQ INT          Exclude reads with mapping quality below INT [0]
  --min-BQ INT          Exclude reads with base quality below INT [0]
  --show-del yes/no     Whether to show deletion as "*" [no]
  --show-ins yes/no     Whether to show insertions [yes]
  --mark-ins            Add '+' before every inserted base/qual [off]
  -A, --ambig           Enable IUPAC ambiguity codes [off]
  -d, --min-depth INT   Minimum depth of INT [1]
  -Z, --block-size INT  Size of chromosome block (bp) when threading [100000]
      --ref-qual INT    QUAL to use for reference bases [0]

For simple consensus mode:
  -q, --(no-)use-qual   Use quality values in calculation [off]
  -c, --call-fract INT  At least INT portion of bases must agree [0.75]
  -H, --het-fract INT   Minimum fraction of 2nd-most to most common base [0.15]

For default "Bayesian" consensus mode:
  -C, --cutoff C        Consensus cutoff quality C [10]
      --(no-)adj-qual   Modify quality with local minima [on]
      --(no-)use-MQ     Use mapping quality in calculation [on]
      --(no-)adj-MQ     Modify mapping quality by local NM [on]
      --NM-halo INT     Size of window fo...
```


### Runtime validation
- **Runtime**: FAIL
- **Data used**: plan:output.sorted.bam, plan:minimal.fa
- **Fix rounds**: 2 (CWL modified by LLM)
- **Example job**: `samtools_consensus_job.json`
- **Reason (not pass)**: baseCommand 'samtools' not found in container; the image may not provide this executable. CWL generation/validation failed. Original error: INFO /media/qhu/slim/Workspace/cwlagent/.venv/bin/cwltool 3.1.20260108082145
INFO Resolved '/media

## samtools_merge

### Tool Description
Merge multiple sorted alignment files into one.

### Metadata
- **Docker Image**: quay.io/biocontainers/samtools:1.23--h96c455f_0
- **Homepage**: https://github.com/samtools/samtools
- **Package**: https://anaconda.org/channels/bioconda/packages/samtools/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
merge: unrecognized option '--help'
Usage: samtools merge [options] -o <out.bam> [options] <in1.bam> ... <inN.bam>
   or: samtools merge [options] <out.bam> <in1.bam> ... <inN.bam>

Options:
  -n         Input files are sorted by read name (natural)
  -N         Input files are sorted by read name (ASCII)
  -t TAG     Input files are sorted by TAG value
  -r         Attach RG tag (inferred from file names)
  -u         Uncompressed BAM output
  -f         Overwrite the output BAM if exist
  -o FILE    Specify output file via option instead of <out.bam> argument
  -1         Compress level 1
  -l INT     Compression level, from 0 to 9 [-1]
  -R STR     Merge file in the specified region STR [all]
  -h FILE    Copy the header in FILE to <out.bam> [in1.bam]
  -c         Combine @RG headers with colliding IDs [alter IDs to be distinct]
  -p         Combine @PG headers with colliding IDs [alter IDs to be distinct]
  -s VALUE   Override random seed
  -b FILE    List of input BAM filenames, one per line [null]
  -X         Use customized index files
  -L FILE    Specify a BED file for multiple region filtering [null]
  --no-PG    do not add a PG line
  --template-coordinate Input files are sorted by template-coordinate
      --input-fmt-option OPT[=VAL]
               Specify a single input file format option in the form
               of OPTION or OPTION=VALUE
  -O, --output-fmt FORMAT[,OPT[=VAL]]...
               Specify output format (SAM, BAM, CRAM)
      --output-fmt-option OPT[=VAL]
               Specify a single output file format option in the form
               of OPTION or OPTION=VALUE
      --reference FILE
               Reference sequence FASTA FILE [null]
  -@, --threads INT
               Number of additional threads to use [0]
      --write-index
               Automatically index the output files [off]
      --verbosity INT
    ...
```


### Runtime validation
- **Runtime**: PASS
- **Data used**: local:merged_2.bam
- **Example job**: `samtools_merge_job.json`

## samtools_mpileup

### Tool Description
Generate text pileup from BAM files

### Metadata
- **Docker Image**: quay.io/biocontainers/samtools:1.23--h96c455f_0
- **Homepage**: https://github.com/samtools/samtools
- **Package**: https://anaconda.org/channels/bioconda/packages/samtools/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
mpileup: unrecognized option '--help'

Usage: samtools mpileup [options] in1.bam [in2.bam [...]]

Input options:
  -6, --illumina1.3+      quality is in the Illumina-1.3+ encoding
  -A, --count-orphans     do not discard anomalous read pairs
  -b, --bam-list FILE     list of input BAM filenames, one per line
  -B, --no-BAQ            disable BAQ (per-Base Alignment Quality)
  -C, --adjust-MQ INT     adjust mapping quality; recommended:50, disable:0 [0]
  -d, --max-depth INT     max per-file depth; avoids excessive memory usage [8000]
  -E, --redo-BAQ          recalculate BAQ on the fly, ignore existing BQs
  -f, --fasta-ref FILE    faidx indexed reference sequence file
  -G, --exclude-RG FILE   exclude read groups listed in FILE
  -l, --positions FILE    skip unlisted positions (chr pos) or regions (BED)
  -q, --min-MQ INT        skip alignments with mapQ smaller than INT [0]
  -Q, --min-BQ INT        skip bases with baseQ/BAQ smaller than INT [13]
  -r, --region REG        region in which pileup is generated
  -R, --ignore-RG         ignore RG tags (one BAM = one sample)
  --rf, --incl-flags STR|INT
                          required flags: only include reads with any of
                          the mask bits set []
  --ff, --excl-flags STR|INT
                          filter flags: skip reads with any of the mask bits set
                                            [UNMAP,SECONDARY,QCFAIL,DUP]
  -x, --ignore-overlaps-removal, --disable-overlap-removal
                          disable read-pair overlap detection and removal
  -X, --customized-index  use customized index files

Output options:
  -o, --output FILE        write output to FILE [standard output]
  -O, --output-BP          output base positions on reads, current orientation
      --output-BP-5        output base positions on reads, 5' to 3' orientation
  -M, --output-mods     ...
```


### Runtime validation
- **Runtime**: PASS
- **Data used**: plan:output.sorted.bam
- **Example job**: `samtools_mpileup_job.json`

## samtools_sort

### Tool Description
Sort alignment files by coordinates or name

### Metadata
- **Docker Image**: quay.io/biocontainers/samtools:1.23--h96c455f_0
- **Homepage**: https://github.com/samtools/samtools
- **Package**: https://anaconda.org/channels/bioconda/packages/samtools/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
sort: unrecognized option '--help'
Usage: samtools sort [options...] [in.bam]
Options:
  -l INT     Set compression level, from 0 (uncompressed) to 9 (best)
  -u         Output uncompressed data (equivalent to -l 0)
  -m INT     Set maximum memory per thread; suffix K/M/G recognized [768M]
  -M         Use minimiser for clustering unaligned/unplaced reads
  -R         Do not use reverse strand (only compatible with -M)
  -K INT     Kmer size to use for minimiser [20]
  -I FILE    Order minimisers by their position in FILE FASTA
  -w INT     Window size for minimiser indexing via -I ref.fa [100]
  -H         Squash homopolymers when computing minimiser
  -n         Sort by read name (natural): cannot be used with samtools index
  -N         Sort by read name (ASCII): cannot be used with samtools index
  -t TAG     Sort by value of TAG. Uses position as secondary index (or read name if -n is set)
  -o FILE    Write final output to FILE rather than standard output
  -T PREFIX  Write temporary files to PREFIX.nnnn.bam
      --no-PG
               Do not add a PG line
      --template-coordinate
               Sort by template-coordinate
      --input-fmt-option OPT[=VAL]
               Specify a single input file format option in the form
               of OPTION or OPTION=VALUE
  -O, --output-fmt FORMAT[,OPT[=VAL]]...
               Specify output format (SAM, BAM, CRAM)
      --output-fmt-option OPT[=VAL]
               Specify a single output file format option in the form
               of OPTION or OPTION=VALUE
      --reference FILE
               Reference sequence FASTA FILE [null]
  -@, --threads INT
               Number of additional threads to use [0]
      --write-index
               Automatically index the output files [off]
      --verbosity INT
               Set level of verbosity

See https://www.htslib.org/doc/samtools.html#G...
```


### Runtime validation
- **Runtime**: PASS
- **Data used**: plan:output.bam
- **Example job**: `samtools_sort_job.json`

## samtools_split

### Tool Description
Splits a file by read group or tag value into multiple output files.

### Metadata
- **Docker Image**: quay.io/biocontainers/samtools:1.23--h96c455f_0
- **Homepage**: https://github.com/samtools/samtools
- **Package**: https://anaconda.org/channels/bioconda/packages/samtools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: samtools split [-u <unaccounted.bam>] [-h <unaccounted_header.sam>]
                      [-f <format_string>] [-v] <merged.bam>
Options:
  -f STRING           output filename format string ["%*_%#.%."]
  -u FILE1            put left-over reads in FILE1
  -h FILE2            ... and override the header with FILE2 (-u file only)
  -d TAG              split by TAG value. TAG value must be a string.
  -p NUMBER           zero-pad numbers in filenames to NUMBER digits
  -M,--max-split NUM  limit number of output files from -d to NUM [100]
  -v                  verbose output
  --no-PG             do not add a PG line
      --input-fmt-option OPT[=VAL]
               Specify a single input file format option in the form
               of OPTION or OPTION=VALUE
      --output-fmt FORMAT[,OPT[=VAL]]...
               Specify output format (SAM, BAM, CRAM)
      --output-fmt-option OPT[=VAL]
               Specify a single output file format option in the form
               of OPTION or OPTION=VALUE
      --reference FILE
               Reference sequence FASTA FILE [null]
  -@, --threads INT
               Number of additional threads to use [0]
      --write-index
               Automatically index the output files [off]
      --verbosity INT
               Set level of verbosity

See https://www.htslib.org/doc/samtools.html#GLOBAL_COMMAND_OPTIONS
for more details.

Format string expansions:
  %%     %
  %*     basename
  %#     index (of @RG in the header, or count of TAG values seen so far)
  %!     @RG ID or TAG value
  %.     filename extension for output format

```


### Runtime validation
- **Runtime**: PASS
- **Data used**: plan:merged.bam
- **Example job**: `samtools_split_job.json`

## samtools_quickcheck

### Tool Description
Quickly check if SAM/BAM/CRAM files are intact and have proper headers.

### Metadata
- **Docker Image**: quay.io/biocontainers/samtools:1.23--h96c455f_0
- **Homepage**: https://github.com/samtools/samtools
- **Package**: https://anaconda.org/channels/bioconda/packages/samtools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: samtools quickcheck [options] <input> [...]
Options:
  -v              verbose output (repeat for more verbosity)
  -q              suppress warning messages
  -u              unmapped input (do not require targets in header)

Notes:

1. By default quickcheck will emit a warning message if and only if a file
   fails the checks, in which case the exit status is non-zero.  Under normal
   behaviour with valid data it will be silent and has a zero exit status.
   The warning messages are purely for manual inspection and should not be 
   parsed by scripts.

2. In order to use this command programmatically, you should check its exit
   status.  One way to use quickcheck might be as a check that all BAM files in
   a directory are okay:

	samtools quickcheck *.bam && echo 'all ok' \
	   || echo 'fail!'

   The first level of verbosity lists only files that fail to stdout.
   To obtain a parsable list of files that have failed, use this option:

	samtools quickcheck -qv *.bam > bad_bams.fofn \
	   && echo 'all ok' \
	   || echo 'some files failed check, see bad_bams.fofn'
```


### Runtime validation
- **Runtime**: PASS
- **Data used**: plan:output.bam
- **Example job**: `samtools_quickcheck_job.json`

## samtools_fastq

### Tool Description
Converts a SAM, BAM or CRAM to FASTQ format.

### Metadata
- **Docker Image**: quay.io/biocontainers/samtools:1.23--h96c455f_0
- **Homepage**: https://github.com/samtools/samtools
- **Package**: https://anaconda.org/channels/bioconda/packages/samtools/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
fastq: unrecognized option '--help'
Usage: samtools fastq [options...] <in.bam>

Description:
Converts a SAM, BAM or CRAM to FASTQ format.

Options:
  -0 FILE      write reads designated READ_OTHER to FILE
  -1 FILE      write reads designated READ1 to FILE
  -2 FILE      write reads designated READ2 to FILE
  -o FILE      write reads designated READ1 or READ2 to FILE
               note: if a singleton file is specified with -s, only
               paired reads will be written to the -1 and -2 files.
  -d, --tag TAG[:VAL]
               only include reads containing TAG, optionally with value VAL
  -D, --tag-file STR:FILE
               only include reads containing TAG, with a value listed in FILE
  -f, --require-flags INT
               only include reads with all  of the FLAGs in INT present [0]
  -F, --excl[ude]-flags INT
               only include reads with none of the FLAGs in INT present [0x900]
      --rf, --incl[ude]-flags INT
               only include reads with any  of the FLAGs in INT present [0]
  -G INT       only EXCLUDE reads with all  of the FLAGs in INT present [0]
  -n           don't append /1 and /2 to the read name
  -N           always append /1 and /2 to the read name
  --no-sc      Remove soft-clips from output
  --sc-aux TAG Tag with which to backup the removed soft-clip data [s0]
  --no-sc-bkp  Do not backup removed soft-clips as aux tags
  -O           output quality in the OQ tag if present
  -s FILE      write singleton reads designated READ1 or READ2 to FILE
  -t           copy RG, BC and QT tags to the FASTQ header line
  -T TAGLIST   copy arbitrary tags to the FASTQ header line, '*' for all
  -v INT       default quality score if not given in file [1]
  -i           add Illumina Casava 1.8 format entry to header (eg 1:N:0:ATCACG)
  -U, --UMI     add UMI to read name
  --UMI-tag TAG-LIST
               th...
```


### Runtime validation
- **Runtime**: PASS
- **Data used**: plan:output.bam
- **Example job**: `samtools_fastq_job.json`

## samtools_fasta

### Tool Description
Converts a SAM, BAM or CRAM to FASTA format.

### Metadata
- **Docker Image**: quay.io/biocontainers/samtools:1.23--h96c455f_0
- **Homepage**: https://github.com/samtools/samtools
- **Package**: https://anaconda.org/channels/bioconda/packages/samtools/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
fasta: unrecognized option '--help'
Usage: samtools fasta [options...] <in.bam>

Description:
Converts a SAM, BAM or CRAM to FASTA format.

Options:
  -0 FILE      write reads designated READ_OTHER to FILE
  -1 FILE      write reads designated READ1 to FILE
  -2 FILE      write reads designated READ2 to FILE
  -o FILE      write reads designated READ1 or READ2 to FILE
               note: if a singleton file is specified with -s, only
               paired reads will be written to the -1 and -2 files.
  -d, --tag TAG[:VAL]
               only include reads containing TAG, optionally with value VAL
  -D, --tag-file STR:FILE
               only include reads containing TAG, with a value listed in FILE
  -f, --require-flags INT
               only include reads with all  of the FLAGs in INT present [0]
  -F, --excl[ude]-flags INT
               only include reads with none of the FLAGs in INT present [0x900]
      --rf, --incl[ude]-flags INT
               only include reads with any  of the FLAGs in INT present [0]
  -G INT       only EXCLUDE reads with all  of the FLAGs in INT present [0]
  -n           don't append /1 and /2 to the read name
  -N           always append /1 and /2 to the read name
  --no-sc      Remove soft-clips from output
  --sc-aux TAG Tag with which to backup the removed soft-clip data [s0]
  --no-sc-bkp  Do not backup removed soft-clips as aux tags
  -s FILE      write singleton reads designated READ1 or READ2 to FILE
  -t           copy RG, BC and QT tags to the FASTA header line
  -T TAGLIST   copy arbitrary tags to the FASTA header line, '*' for all
  -i           add Illumina Casava 1.8 format entry to header (eg 1:N:0:ATCACG)
  -U, --UMI     add UMI to read name
  --UMI-tag TAG-LIST
               the list of aux tags to search for UMI barcode [RX,OX]
  -c INT       compression level [0..9] to use when writing bgzf...
```


### Runtime validation
- **Runtime**: PASS
- **Data used**: plan:output.sorted.bam
- **Example job**: `samtools_fasta_job.json`

## samtools_import

### Tool Description
Import FASTQ files into SAM/BAM/CRAM format

### Metadata
- **Docker Image**: quay.io/biocontainers/samtools:1.23--h96c455f_0
- **Homepage**: https://github.com/samtools/samtools
- **Package**: https://anaconda.org/channels/bioconda/packages/samtools/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
import: unrecognized option '--help'
Usage: samtools import [options] [file.fastq ...]

Options:
  -s FILE      Read paired-ended data from single FILE
  -0 FILE      Read single-ended data from FILE
  -1 FILE      Read-1 from FILE
  -2 FILE      Read-2 from FILE
  --i1 FILE    Index-1 from FILE
  --i2 FILE    Index-2 from FILE
  -i           Parse CASAVA identifier
  -U, --UMI    Parse UMI from read name
  --UMI-tag TAG
               Tag to use for UMI sequences [RX]
  --barcode-tag TAG
               Tag to use with barcode sequences [BC]
  --quality-tag TAG
               Tag to use with barcode qualities [QT]
  -N, --name2  Use 2nd field as read name (SRA format)
  -r STRING    Build up a complete @RG line
  -R STRING    Add a simple RG line of "@RG\tID:STRING"
  -T TAGLIST   Parse tags in SAM format; list of '*' for all
  -o FILE      Output to FILE instead of stdout
  -u           Uncompressed output
  --order TAG  Store Nth record count in TAG

      --no-PG  Do not add a PG line
      --input-fmt-option OPT[=VAL]
               Specify a single input file format option in the form
               of OPTION or OPTION=VALUE
  -O, --output-fmt FORMAT[,OPT[=VAL]]...
               Specify output format (SAM, BAM, CRAM)
      --output-fmt-option OPT[=VAL]
               Specify a single output file format option in the form
               of OPTION or OPTION=VALUE
  -@, --threads INT
               Number of additional threads to use [0]

See https://www.htslib.org/doc/samtools.html#GLOBAL_COMMAND_OPTIONS
for more details.

A single fastq file will be interpreted as -s, -0 or -1 depending on
file contents, and a pair of fastq files as "-1 FILE1 -2 FILE2".

```


### Runtime validation
- **Runtime**: PASS
- **Data used**: none
- **Example job**: `samtools_import_job.json`

## samtools_reference

### Tool Description
Extract the reference sequence from a CRAM file

### Metadata
- **Docker Image**: quay.io/biocontainers/samtools:1.23--h96c455f_0
- **Homepage**: https://github.com/samtools/samtools
- **Package**: https://anaconda.org/channels/bioconda/packages/samtools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: samtools reference [-@ N] [-r region] [-e] [-q] [-o out.fa] [in.cram]
```


### Runtime validation
- **Runtime**: FAIL
- **Data used**: manifest:minimal.dat (Generic minimal file (e.g. for md5sum, checksum))
- **Fix rounds**: 2 (CWL modified by LLM)
- **Example job**: `samtools_reference_job.json`
- **Reason (not pass)**: WARNING Final process status is permanentFail

## samtools_reset

### Tool Description
Reset a SAM/BAM/CRAM file, removing or retaining specific tags and metadata.

### Metadata
- **Docker Image**: quay.io/biocontainers/samtools:1.23--h96c455f_0
- **Homepage**: https://github.com/samtools/samtools
- **Package**: https://anaconda.org/channels/bioconda/packages/samtools/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
reset: unrecognized option '--help'
Usage: samtools reset [options]
  -o FILE      Output file
  -x, --remove-tag STR
               Aux tags to be removed
      --keep-tag STR
               Aux tags to be retained. Equivalent to -x ^STR
      --reject-PG ID
               Removes PG line with ID matching to input and succeeding PG lines
      --no-RG  To have RG lines or not
      --no-PG  To have PG entry or not for reset operation
      --dupflag
               Keeps the duplicate flag as it is
  -O, --output-fmt FORMAT[,OPT[=VAL]]...
               Specify output format (SAM, BAM, CRAM)
  -@, --threads INT
               Number of additional threads to use [0]

See https://www.htslib.org/doc/samtools.html#GLOBAL_COMMAND_OPTIONS
for more details.

```


### Runtime validation
- **Runtime**: PASS
- **Data used**: plan:output.bam
- **Example job**: `samtools_reset_job.json`

## samtools_bedcov

### Tool Description
Calculate read depth per BED region

### Metadata
- **Docker Image**: quay.io/biocontainers/samtools:1.23--h96c455f_0
- **Homepage**: https://github.com/samtools/samtools
- **Package**: https://anaconda.org/channels/bioconda/packages/samtools/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
bedcov: unrecognized option '--help'
Usage: samtools bedcov [options] <in.bed> <in1.bam> [...]

Options:
      -Q, --min-MQ <int>  mapping quality threshold [0]
      -X                  use customized index files
      -g <flags>          remove the specified flags from the set used to filter out reads
      -G <flags>          add the specified flags to the set used to filter out reads
                          The default set is UNMAP,SECONDARY,QCFAIL,DUP or 0x704
      -j                  do not include deletions (D) and ref skips (N) in bedcov computation
      --max-depth <int>   sets the maximum depth used in the mpileup algorithm
      -d <int>            depth threshold. Number of reference bases with coverage above and
                          including this value will be displayed in a separate column
      -c                  add an additional column showing read count
      -H                  print a comment/header line with column information.
      --input-fmt-option OPT[=VAL]
               Specify a single input file format option in the form
               of OPTION or OPTION=VALUE
      --reference FILE
               Reference sequence FASTA FILE [null]
      --verbosity INT
               Set level of verbosity

See https://www.htslib.org/doc/samtools.html#GLOBAL_COMMAND_OPTIONS
for more details.

```


### Runtime validation
- **Runtime**: FAIL
- **Data used**: manifest:macs3/output/refined_refinepeak.bed (Found in project), plan:output.sorted.bam
- **Fix rounds**: 2 (CWL modified by LLM)
- **Example job**: `samtools_bedcov_job.json`
- **Reason (not pass)**: WARNING Final process status is permanentFail

## samtools_coverage

### Tool Description
Produces a histogram or tabular summary of coverage for input BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/samtools:1.23--h96c455f_0
- **Homepage**: https://github.com/samtools/samtools
- **Package**: https://anaconda.org/channels/bioconda/packages/samtools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: samtools coverage [options] in1.bam [in2.bam [...]]

Input options:
  -b, --bam-list FILE     list of input BAM filenames, one per line
  -l, --min-read-len INT  ignore reads shorter than INT bp [0]
  -q, --min-MQ INT        mapping quality threshold [0]
  -Q, --min-BQ INT        base quality threshold [0]
  --rf <int|str>          required flags: skip reads with mask bits unset []
  --ff <int|str>          filter flags: skip reads with mask bits set 
                                      [UNMAP,SECONDARY,QCFAIL,DUP]
  -d, --depth INT         maximum allowed coverage depth [1000000].
                          If 0, depth is set to the maximum integer value,
                          effectively removing any depth limit.
      --min-depth INT     minimum coverage depth below which a position 
                          to be ignored [1]
Output options:
  -m, --histogram         show histogram instead of tabular output
  -D, --plot-depth        plot depth instead of tabular output
  -A, --ascii             show only ASCII characters in histogram
  -o, --output FILE       write output to FILE [stdout]
  -H, --no-header         don't print a header in tabular mode
  -w, --n-bins INT        number of bins in histogram [terminal width - 40]
  -r, --region REG        show specified region. Format: chr:start-end. 
  -h, --help              help (this page)

Generic options:
      --input-fmt-option OPT[=VAL]
               Specify a single input file format option in the form
               of OPTION or OPTION=VALUE
      --reference FILE
               Reference sequence FASTA FILE [null]
      --verbosity INT
               Set level of verbosity

See https://www.htslib.org/doc/samtools.html#GLOBAL_COMMAND_OPTIONS
for more details.

See manpage for additional details.
  rname       Reference name / chromosome
  startpos    Start position
  endpos      End position (or sequence length)
  numreads    Number reads aligned to the region (after filtering)
  covbases    N...
```


### Runtime validation
- **Runtime**: PASS
- **Data used**: local:merged_2.bam
- **Example job**: `samtools_coverage_job.json`

## samtools_depth

### Tool Description
Compute the depth of coverage for one or more BAM/SAM/CRAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/samtools:1.23--h96c455f_0
- **Homepage**: https://github.com/samtools/samtools
- **Package**: https://anaconda.org/channels/bioconda/packages/samtools/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
depth: unrecognized option '--help'
Usage: samtools depth [options] in.bam [in.bam ...]

Options:
  -a           Output all positions (including zero depth)
  -a -a, -aa   Output absolutely all positions, including unused ref seqs
  -r REG       Specify a region in chr or chr:from-to syntax
  -b FILE      Use bed FILE for list of regions
  -f FILE      Specify list of input BAM/SAM/CRAM filenames
  -X           Use custom index files (in -X *.bam *.bam.bai order)
  -g INT       Remove specified flags from default filter-out flag list
  -G, --excl-flags FLAGS
               Add specified flags to the  default filter-out flag list
               [UNMAP,SECONDARY,QCFAIL,DUP]
      --incl-flags FLAGS
               Only include records with at least one the FLAGs present [0]
      --require-flags FLAGS
               Only include records with all of the FLAGs present [0]
  -H           Print a file header line
  -l INT       Minimum read length [0]
  -o FILE      Write output to FILE [stdout]
  -q, --min-BQ INT
               Filter bases with base quality smaller than INT [0]
  -Q, --min-MQ INT
               Filter alignments with mapping quality smaller than INT [0]
  -J           Include reads with deletions in depth computation
  -s           Do not count overlapping reads within a template
      --input-fmt-option OPT[=VAL]
               Specify a single input file format option in the form
               of OPTION or OPTION=VALUE
      --reference FILE
               Reference sequence FASTA FILE [null]
  -@, --threads INT
               Number of additional threads to use [0]
      --verbosity INT
               Set level of verbosity

See https://www.htslib.org/doc/samtools.html#GLOBAL_COMMAND_OPTIONS
for more details.

```


### Runtime validation
- **Runtime**: PASS
- **Data used**: plan:output.sorted.bam
- **Example job**: `samtools_depth_job.json`

## samtools_flagstat

### Tool Description
Counts the number of alignments for each FLAG type

### Metadata
- **Docker Image**: quay.io/biocontainers/samtools:1.23--h96c455f_0
- **Homepage**: https://github.com/samtools/samtools
- **Package**: https://anaconda.org/channels/bioconda/packages/samtools/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
flagstat: unrecognized option '--help'
Usage: samtools flagstat [options] <in.bam>
      --input-fmt-option OPT[=VAL]
               Specify a single input file format option in the form
               of OPTION or OPTION=VALUE
  -@, --threads INT
               Number of additional threads to use [0]
      --verbosity INT
               Set level of verbosity

See https://www.htslib.org/doc/samtools.html#GLOBAL_COMMAND_OPTIONS
for more details.
  -O, --output-fmt FORMAT[,OPT[=VAL]]...
               Specify output format (json, tsv)

```


### Runtime validation
- **Runtime**: PASS
- **Data used**: plan:output.sorted.bam
- **Example job**: `samtools_flagstat_job.json`

## samtools_idxstats

### Tool Description
Reports alignment statistics from a BAM index file, including sequence names, sequence lengths, number of mapped reads, and number of unmapped reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/samtools:1.23--h96c455f_0
- **Homepage**: https://github.com/samtools/samtools
- **Package**: https://anaconda.org/channels/bioconda/packages/samtools/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
idxstats: unrecognized option '--help'
Usage: samtools idxstats [options] <in.bam>
  -X           Include customized index file
      --input-fmt-option OPT[=VAL]
               Specify a single input file format option in the form
               of OPTION or OPTION=VALUE
  -@, --threads INT
               Number of additional threads to use [0]
      --verbosity INT
               Set level of verbosity

See https://www.htslib.org/doc/samtools.html#GLOBAL_COMMAND_OPTIONS
for more details.

```


### Runtime validation
- **Runtime**: PASS
- **Data used**: plan:output.sorted.bam
- **Example job**: `samtools_idxstats_job.json`

## samtools_cram-size

### Tool Description
Calculate the size of CRAM files

### Metadata
- **Docker Image**: quay.io/biocontainers/samtools:1.23--h96c455f_0
- **Homepage**: https://github.com/samtools/samtools
- **Package**: https://anaconda.org/channels/bioconda/packages/samtools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: samtools cram_size [-ve] [-o out.size] [in.cram]
```


### Runtime validation
- **Runtime**: FAIL
- **Data used**: manifest:minimal.dat (Generic minimal file (e.g. for md5sum, checksum))
- **Fix rounds**: 2 (CWL modified by LLM)
- **Example job**: `samtools_cram-size_job.json`
- **Reason (not pass)**: WARNING Final process status is permanentFail

## samtools_phase

### Tool Description
Call and phase heterozygous SNPs

### Metadata
- **Docker Image**: quay.io/biocontainers/samtools:1.23--h96c455f_0
- **Homepage**: https://github.com/samtools/samtools
- **Package**: https://anaconda.org/channels/bioconda/packages/samtools/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
phase: unrecognized option '--help'

Usage:   samtools phase [options] <in.bam>

Options: -k INT    block length [13]
         -b STR    prefix of BAMs to output [null]
         -q INT    min het phred-LOD [37]
         -Q, --min-BQ INT
                   min base quality in het calling [13]
         -D INT    max read depth [256]
         -F        do not attempt to fix chimeras
         -A        drop reads with ambiguous phase
         --no-PG   do not add a PG line

      --input-fmt-option OPT[=VAL]
               Specify a single input file format option in the form
               of OPTION or OPTION=VALUE
      --output-fmt FORMAT[,OPT[=VAL]]...
               Specify output format (SAM, BAM, CRAM)
      --output-fmt-option OPT[=VAL]
               Specify a single output file format option in the form
               of OPTION or OPTION=VALUE
      --reference FILE
               Reference sequence FASTA FILE [null]
      --verbosity INT
               Set level of verbosity

See https://www.htslib.org/doc/samtools.html#GLOBAL_COMMAND_OPTIONS
for more details.

```


### Runtime validation
- **Runtime**: PASS
- **Data used**: plan:tiny.sorted.bam
- **Example job**: `samtools_phase_job.json`

## samtools_stats

### Tool Description
The program collects statistics from BAM files. The output can be visualized using plot-bamstats.

### Metadata
- **Docker Image**: quay.io/biocontainers/samtools:1.23--h96c455f_0
- **Homepage**: https://github.com/samtools/samtools
- **Package**: https://anaconda.org/channels/bioconda/packages/samtools/overview
- **Validation**: PASS

### Original Help Text
```text
About: The program collects statistics from BAM files. The output can be visualized using plot-bamstats.
Usage: samtools stats [OPTIONS] file.bam
       samtools stats [OPTIONS] file.bam chr:from-to
Options:
    -c, --coverage <int>,<int>,<int>    Coverage distribution min,max,step [1,1000,1]
    -d, --remove-dups                   Exclude from statistics reads marked as duplicates
    -X, --customized-index-file         Use a customized index file
    -f, --required-flag  <str|int>      Required flag, 0 for unset. See also `samtools flags` [0]
    -F, --filtering-flag <str|int>      Filtering flag, 0 for unset. See also `samtools flags` [0]
        --GC-depth <float>              the size of GC-depth bins (decreasing bin size increases memory requirement) [2e4]
    -h, --help                          This help message
    -i, --insert-size <int>             Maximum insert size [8000]
    -I, --id <string>                   Include only listed read group or sample name
    -l, --read-length <int>             Include in the statistics only reads with the given read length [-1]
    -m, --most-inserts <float>          Report only the main part of inserts [0.99]
    -P, --split-prefix <str>            Path or string prefix for filepaths output by -S (default is input filename)
    -q, --trim-quality <int>            The BWA trimming parameter [0]
    -r, --ref-seq <file>                Reference sequence (required for GC-depth and mismatches-per-cycle calculation).
    -s, --sam                           Ignored (input format is auto-detected).
    -S, --split <tag>                   Also write statistics to separate files split by tagged field.
    -t, --target-regions <file>         Do stats in these regions only. Tab-delimited file chr,from,to, 1-based, inclusive.
    -x, --sparse                        Suppress outputting IS rows where there are no insertions.
    -p, --remove-overlaps               Remove overlaps of paired-end reads from coverage and base count co...
```


### Runtime validation
- **Runtime**: FAIL
- **Data used**: plan:output.sorted.bam, plan:minimal.fa
- **Fix rounds**: 2 (CWL modified by LLM)
- **Example job**: `samtools_stats_job.json`
- **Reason (not pass)**: baseCommand 'samtools' not found in container; the image may not provide this executable. CWL generation/validation failed. Original error: INFO /media/qhu/slim/Workspace/cwlagent/.venv/bin/cwltool 3.1.20260108082145
INFO Resolved '/media

## samtools_ampliconstats

### Tool Description
Produce statistics from amplicon sequencing alignment files

### Metadata
- **Docker Image**: quay.io/biocontainers/samtools:1.23--h96c455f_0
- **Homepage**: https://github.com/samtools/samtools
- **Package**: https://anaconda.org/channels/bioconda/packages/samtools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: samtools ampliconstats [options] primers.bed *.bam > astats.txt

Options:
  -f, --required-flag STR|INT
               Only include reads with all of the FLAGs present [0x0]
  -F, --filter-flag STR|INT
               Only include reads with none of the FLAGs present [0xB04]
  -a, --max-amplicons INT
               Change the maximum number of amplicons permitted [1000]
  -l, --max-amplicon-length INT
               Change the maximum length of an individual amplicon [1000]
  -d, --min-depth INT[,INT]...
               Minimum base depth(s) to consider position covered [1]
  -m, --pos-margin INT
               Margin of error for matching primer positions [30]
  -o, --output FILE
               Specify output file [stdout if unset]
  -s, --use-sample-name
               Use the sample name from the first @RG header line
  -t, --tlen-adjust INT
               Add/subtract from TLEN; use when clipping but no fixmate step
  -b, --tcoord-bin INT
               Bin template start,end positions into multiples of INT[1]
  -c, --tcoord-min-count INT
               Minimum template start,end frequency for recording [10]
  -D, --depth-bin FRACTION
               Merge FDP values within +/- FRACTION together
  -S, --single-ref
               Force single-ref (<=1.12) output format
  -I, --input-fmt FORMAT[,OPT[=VAL]]...
               Specify input format (SAM, BAM, CRAM)
      --input-fmt-option OPT[=VAL]
               Specify a single input file format option in the form
               of OPTION or OPTION=VALUE
      --reference FILE
               Reference sequence FASTA FILE [null]
  -@, --threads INT
               Number of additional threads to use [0]

See https://www.htslib.org/doc/samtools.html#GLOBAL_COMMAND_OPTIONS
for more details.
```


### Runtime validation
- **Runtime**: FAIL
- **Data used**: none
- **Fix rounds**: 2 (CWL modified by LLM)
- **Reason (not pass)**: Could not parse CWL inputs

## samtools_checksum

### Tool Description
Generate checksums for SAM/BAM/CRAM files or merge existing checksum outputs.

### Metadata
- **Docker Image**: quay.io/biocontainers/samtools:1.23--h96c455f_0
- **Homepage**: https://github.com/samtools/samtools
- **Package**: https://anaconda.org/channels/bioconda/packages/samtools/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
checksum: unrecognized option '--help'
Usage: samtools checksum [options] [file.bam ...]
or     samtools checksum [options] -m [file.chk ...]

Options:
  -F, --exclude-flags FLAG    Filter if any FLAGs are present [0x900]
  -f, --require-flags FLAG    Filter unless all FLAGs are present [0]
  -b, --flag-mask FLAG        BAM FLAGs to use in checksums [0x0c1]
  -c, --no-rev-comp           Do not reverse-complement sequences [off]
  -t, --tags STR[,STR]        Select tags to checksum [BC,FI,QT,RT,TC]
  -O, --in-order              Use order-specific checksumming [off]
  -P, --check-pos             Also checksum CHR / POS [off]
  -C, --check-cigar           Also checksum MAPQ / CIGAR [off]
  -M, --check_mate            Also checksum PNEXT / RNEXT / TLEN [off]
  -z, --sanitize FLAGS        Perform sanity checks and fix records [off]
  -N, --count INT             Stop after INT number of records [0]
  -o, --output FILE           Write report to FILE [stdout]
  -q, --show-qc               Also show QC pass/fail lines
  -v, --verbose               Increase verbosity: show lines with 0 counts
  -a, --all                   Check all: -PCMOc -b 0xfff -f0 -F0 -z all,cigarx
  -T, --tabs                  Format output as tab delimited text
  -m, --merge FILE            Merge checksum output (-o opt) files
  -B, --bamseqchksum          Report in bamseqchksum format

Global options:
      --input-fmt-option OPT[=VAL]
               Specify a single input file format option in the form
               of OPTION or OPTION=VALUE
  -@, --threads INT
               Number of additional threads to use [0]

See https://www.htslib.org/doc/samtools.html#GLOBAL_COMMAND_OPTIONS
for more details.

```


### Runtime validation
- **Runtime**: PASS
- **Data used**: plan:output.sorted.bam
- **Fix rounds**: 2 (CWL modified by LLM)
- **Example job**: `samtools_checksum_job.json`

## samtools_flags

### Tool Description
Convert between textual and numeric flag representation

### Metadata
- **Docker Image**: quay.io/biocontainers/samtools:1.23--h96c455f_0
- **Homepage**: https://github.com/samtools/samtools
- **Package**: https://anaconda.org/channels/bioconda/packages/samtools/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
samtools flags: Could not parse "--help"
About: Convert between textual and numeric flag representation
Usage: samtools flags FLAGS...

Each FLAGS argument is either an INT (in decimal/hexadecimal/octal) representing
a combination of the following numeric flag values, or a comma-separated string
NAME,...,NAME representing a combination of the following flag names:

   0x1     1  PAIRED         paired-end / multiple-segment sequencing technology
   0x2     2  PROPER_PAIR    each segment properly aligned according to aligner
   0x4     4  UNMAP          segment unmapped
   0x8     8  MUNMAP         next segment in the template unmapped
  0x10    16  REVERSE        SEQ is reverse complemented
  0x20    32  MREVERSE       SEQ of next segment in template is rev.complemented
  0x40    64  READ1          the first segment in the template
  0x80   128  READ2          the last segment in the template
 0x100   256  SECONDARY      secondary alignment
 0x200   512  QCFAIL         not passing quality controls or other filters
 0x400  1024  DUP            PCR or optical duplicate
 0x800  2048  SUPPLEMENTARY  supplementary alignment

```


### Runtime validation
- **Runtime**: PASS
- **Data used**: none
- **Example job**: `samtools_flags_job.json`

## samtools_head

### Tool Description
Display header and/or alignment record lines from a SAM, BAM, or CRAM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/samtools:1.23--h96c455f_0
- **Homepage**: https://github.com/samtools/samtools
- **Package**: https://anaconda.org/channels/bioconda/packages/samtools/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
head: unrecognized option '--help'
Usage: samtools head [OPTION]... [FILE]
Options:
  -h, --headers INT   Display INT header lines [all]
  -n, --records INT   Display INT alignment record lines [none]
      --input-fmt-option OPT[=VAL]
               Specify a single input file format option in the form
               of OPTION or OPTION=VALUE
  -T, --reference FILE
               Reference sequence FASTA FILE [null]
  -@, --threads INT
               Number of additional threads to use [0]
      --verbosity INT
               Set level of verbosity

See https://www.htslib.org/doc/samtools.html#GLOBAL_COMMAND_OPTIONS
for more details.

```


### Runtime validation
- **Runtime**: PASS
- **Data used**: plan:output.bam
- **Example job**: `samtools_head_job.json`

## samtools_tview

### Tool Description
Text alignment viewer

### Metadata
- **Docker Image**: quay.io/biocontainers/samtools:1.23--h96c455f_0
- **Homepage**: https://github.com/samtools/samtools
- **Package**: https://anaconda.org/channels/bioconda/packages/samtools/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
tview: unrecognized option '--help'
Usage: samtools tview [options] <aln.bam> [ref.fasta]
Options:
   -d display      output as (H)tml or (C)urses or (T)ext 
   -X              include customized index file
   -p chr:pos      go directly to this position
   -s STR          display only reads from this sample or group
   -w INT          display width (with -d T only)
   -i              hide inserts
      --input-fmt-option OPT[=VAL]
               Specify a single input file format option in the form
               of OPTION or OPTION=VALUE
      --reference FILE
               Reference sequence FASTA FILE [null]
      --verbosity INT
               Set level of verbosity

See https://www.htslib.org/doc/samtools.html#GLOBAL_COMMAND_OPTIONS
for more details.

```


### Runtime validation
- **Runtime**: FAIL
- **Data used**: plan:output.sorted.bam, plan:minimal.fa
- **Fix rounds**: 2 (CWL modified by LLM)
- **Example job**: `samtools_tview_job.json`
- **Reason (not pass)**: WARNING Final process status is permanentFail

## samtools_view

### Tool Description
View and convert SAM/BAM/CRAM files

### Metadata
- **Docker Image**: quay.io/biocontainers/samtools:1.23--h96c455f_0
- **Homepage**: https://github.com/samtools/samtools
- **Package**: https://anaconda.org/channels/bioconda/packages/samtools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: samtools view [options] <in.bam>|<in.sam>|<in.cram> [region ...]

Output options:
  -b, --bam                  Output BAM
  -C, --cram                 Output CRAM (requires -T)
  -1, --fast                 Use fast BAM compression (and default to --bam)
  -u, --uncompressed         Uncompressed BAM output (and default to --bam)
  -h, --with-header          Include header in SAM output
  -H, --header-only          Print SAM header only (no alignments)
      --no-header            Print SAM alignment records only [default]
  -c, --count                Print only the count of matching records
      --save-counts FILE     Write counts of passed/failed records to FILE
  -o, --output FILE          Write output to FILE [standard output]
  -U, --unoutput FILE, --output-unselected FILE
                             Output reads not selected by filters to FILE
  -p, --unmap                Set flag to UNMAP on reads not selected
                             then write to output file.
  -P, --fetch-pairs          Retrieve complete pairs even when outside of region

Input options:
  -t, --fai-reference FILE   FILE listing reference names and lengths
  -M, --use-index            Use index and multi-region iterator for regions
      --region[s]-file FILE  Use index to include only reads overlapping FILE
  -X, --customized-index     Expect extra index file argument after <in.bam>

Filtering options (Only include in output reads that...):
  -L, --target[s]-file FILE  ...overlap (BED) regions in FILE
  -N, --qname-file [^]FILE   ...whose read name is listed in FILE ("^" negates)
  -r, --read-group STR       ...are in read group STR or in no read group
  -R, --read-group-file [^]FILE
                             ...are in a read group listed in FILE or in none
  -n, --exclude-no-read_group
                             ...have a read group, exclude those that have not
  -d, --tag STR1[:STR2]      ...have a tag STR1 (with associated value STR2)
  -D, --tag-file STR:FILE    ...have...
```


### Runtime validation
- **Runtime**: PASS
- **Data used**: plan:output.bam
- **Example job**: `samtools_view_job.json`

## samtools_depad

### Tool Description
Convert a padded BAM/SAM file to an unpadded BAM/SAM file

### Metadata
- **Docker Image**: quay.io/biocontainers/samtools:1.23--h96c455f_0
- **Homepage**: https://github.com/samtools/samtools
- **Package**: https://anaconda.org/channels/bioconda/packages/samtools/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
depad: unrecognized option '--help'

Usage:   samtools depad <in.bam>

Options:
  -s           Output is SAM (default is BAM)
  -S           Input is SAM (default is BAM)
  -u           Uncompressed BAM output (can't use with -s)
  -1           Fast compression BAM output (can't use with -s)
  -T, --reference FILE
               Padded reference sequence file [null]
  -o FILE      Output file name [stdout]
  --no-PG      do not add a PG line
  -?           Longer help
      --input-fmt-option OPT[=VAL]
               Specify a single input file format option in the form
               of OPTION or OPTION=VALUE
      --output-fmt FORMAT[,OPT[=VAL]]...
               Specify output format (SAM, BAM, CRAM)
      --output-fmt-option OPT[=VAL]
               Specify a single output file format option in the form
               of OPTION or OPTION=VALUE
      --write-index
               Automatically index the output files [off]
      --verbosity INT
               Set level of verbosity

See https://www.htslib.org/doc/samtools.html#GLOBAL_COMMAND_OPTIONS
for more details.
Notes:

1. Requires embedded reference sequences (before the reads for that reference),
   or ideally a FASTA file of the padded reference sequences (via a -T option).

2. Input padded alignment reads' CIGAR strings must not use P or I operators.


```


### Runtime validation
- **Runtime**: FAIL
- **Data used**: plan:output.bam, plan:minimal.fa
- **Fix rounds**: 2 (CWL modified by LLM)
- **Example job**: `samtools_depad_job.json`
- **Reason (not pass)**:                          }

## samtools_samples

### Tool Description
List samples from BAM/CRAM files, optionally checking for indices and associating with reference fasta files.

### Metadata
- **Docker Image**: quay.io/biocontainers/samtools:1.23--h96c455f_0
- **Homepage**: https://github.com/samtools/samtools
- **Package**: https://anaconda.org/channels/bioconda/packages/samtools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: samtools samples [options] <input> [...]
       samtools samples [options] -X f1.bam f2.bam f1.bam.bai f2.bai 
       find dir1 dir2 -type f \(-name "*.bam" -o -name "*.cram" \) | samtools samples [options]
       find dir1 dir2 -type f \(-name "*.bam" -o -name "*.bai" \) | sort | paste - - | samtools samples -X [options]

Options:
  -?              print help and exit
  -h              add the columns header before printing the results
  -i              test if the file is indexed.
  -T <tag>        provide the sample tag name from the @RG line [SM].
  -o <file>       output file [stdout].
  -f <file.fa>    load an indexed fasta file in the collection of references. Can be used multiple times.
  -F <file.txt>   read a file containing the paths to indexed fasta files. One path per line.
  -X              use a custom index file.

 Using -f or -F will add a column containing the path to the reference or "." if the reference was not found.
```


### Runtime validation
- **Runtime**: PASS
- **Data used**: local:merged_2.bam
- **Example job**: `samtools_samples_job.json`

## Metadata
- **Skill**: generated
