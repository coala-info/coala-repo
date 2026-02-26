# sinto CWL Generation Report

## sinto_filterbarcodes

### Tool Description
Filter reads based on input list of cell barcodes

### Metadata
- **Docker Image**: quay.io/biocontainers/sinto:0.10.1--pyhdfd78af_0
- **Homepage**: https://timoast.github.io/sinto/
- **Package**: https://anaconda.org/channels/bioconda/packages/sinto/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sinto/overview
- **Total Downloads**: 25.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/timoast/sinto
- **Stars**: N/A
### Original Help Text
```text
usage: sinto filterbarcodes [-h] -b BAM -c CELLS [-t] [-p NPROC]
                            [--barcode_regex BARCODE_REGEX]
                            [--barcodetag BARCODETAG] [--outdir OUTDIR] [-s]

Filter reads based on input list of cell barcodes

options:
  -h, --help            show this help message and exit
  -b BAM, --bam BAM     Input bam file (must be indexed)
  -c CELLS, --cells CELLS
                        File or comma-separated list of cell barcodes. Can be
                        gzip compressed
  -t, --trim_suffix     Remove trail 2 characters from cell barcode in BAM
                        file
  -p NPROC, --nproc NPROC
                        Number of processors (default = 1)
  --barcode_regex BARCODE_REGEX
                        Regular expression used to extract cell barcode from
                        read name. If None (default), extract cell barcode
                        from read tag. Use "[^:]*" to match all characters up
                        to the first colon.
  --barcodetag BARCODETAG
                        Read tag storing cell barcode information (default =
                        "CB")
  --outdir OUTDIR       Output file directory
  -s, --sam             Output sam format (default bam output)
```


## sinto_addtags

### Tool Description
Add read tags to reads from individual cells

### Metadata
- **Docker Image**: quay.io/biocontainers/sinto:0.10.1--pyhdfd78af_0
- **Homepage**: https://timoast.github.io/sinto/
- **Package**: https://anaconda.org/channels/bioconda/packages/sinto/overview
- **Validation**: PASS

### Original Help Text
```text
usage: sinto addtags [-h] -b BAM -f TAGFILE -o OUTPUT [-t] [-s] [-p NPROC]
                     [-m MODE]

Add read tags to reads from individual cells

options:
  -h, --help            show this help message and exit
  -b BAM, --bam BAM     Input bam file (must be indexed)
  -f TAGFILE, --tagfile TAGFILE
                        Tab-delimited file containing cell barcode, tag to be
                        added, and tag identity. Can be gzip compressed
  -o OUTPUT, --output OUTPUT
                        Name for output text file
  -t, --trim_suffix     Remove trail 2 characters from cell barcode in BAM
                        file
  -s, --sam             Output sam format (default bam output)
  -p NPROC, --nproc NPROC
                        Number of processors (default = 1)
  -m MODE, --mode MODE  Either tag (default) or readname. Some BAM file store
                        the cell barcode in the readname rather than under a
                        read tag
```


## sinto_tagtorg

### Tool Description
Append a read tag to the read group ID of each read. Also appends the read tag to the SM field of the read group.

### Metadata
- **Docker Image**: quay.io/biocontainers/sinto:0.10.1--pyhdfd78af_0
- **Homepage**: https://timoast.github.io/sinto/
- **Package**: https://anaconda.org/channels/bioconda/packages/sinto/overview
- **Validation**: PASS

### Original Help Text
```text
usage: sinto tagtorg [-h] -b BAM [--tag TAG] -f TAGFILE [-o OUTPUT]
                     [-O OUTPUTFORMAT]

Append a read tag to the read group ID of each read. Also appends the read tag
to the SM field of the read group.

options:
  -h, --help            show this help message and exit
  -b BAM, --bam BAM     Input SAM/BAM file, '-' reads from stdin
  --tag TAG             Read tag to extract the value from that is appended to
                        the read group. Default is 'CB', the tag that is used
                        in 10x sequencing to identify cells.
  -f TAGFILE, --tagfile TAGFILE
                        List of expected tag values. Reads with tag values
                        that are not in this list are not altered.
  -o OUTPUT, --output OUTPUT
                        Output SAM/BAM file, '-' outputs to stdout (default
                        '-')
  -O OUTPUTFORMAT, --outputformat OUTPUTFORMAT
                        Output format. One of 't' (SAM), 'b' (BAM), or 'u'
                        (uncompressed BAM) ('t' default)
```


## sinto_tagtotag

### Tool Description
Copies BAM entries to a new file while copying a read tag to another read tag and optionally deleting the originating tag.

### Metadata
- **Docker Image**: quay.io/biocontainers/sinto:0.10.1--pyhdfd78af_0
- **Homepage**: https://timoast.github.io/sinto/
- **Package**: https://anaconda.org/channels/bioconda/packages/sinto/overview
- **Validation**: PASS

### Original Help Text
```text
usage: sinto tagtotag [-h] -b BAM --from FROM_ --to TO [--delete] [-o OUTPUT]
                      [-O OUTPUTFORMAT]

Copies BAM entries to a new file while copying a read tag to another read tag
and optionally deleting the originating tag.

options:
  -h, --help            show this help message and exit
  -b BAM, --bam BAM     Input SAM/BAM file, '-' reads from stdin
  --from FROM_          Read tag to copy from.
  --to TO               Read tag to copy to.
  --delete              Delete originating tag after copy (i.e. move).
  -o OUTPUT, --output OUTPUT
                        Output SAM/BAM file, '-' outputs to stdout (default
                        '-')
  -O OUTPUTFORMAT, --outputformat OUTPUTFORMAT
                        Output format. One of 't' (SAM), 'b' (BAM), or 'u'
                        (uncompressed BAM) ('t' default)
```


## sinto_fragments

### Tool Description
Create ATAC-seq fragment file from BAM file

### Metadata
- **Docker Image**: quay.io/biocontainers/sinto:0.10.1--pyhdfd78af_0
- **Homepage**: https://timoast.github.io/sinto/
- **Package**: https://anaconda.org/channels/bioconda/packages/sinto/overview
- **Validation**: PASS

### Original Help Text
```text
usage: sinto fragments [-h] -b BAM -f FRAGMENTS [-m MIN_MAPQ] [-p NPROC]
                       [-t BARCODETAG] [-c CELLS]
                       [--barcode_regex BARCODE_REGEX] [--use_chrom USE_CHROM]
                       [--max_distance MAX_DISTANCE]
                       [--min_distance MIN_DISTANCE] [--chunksize CHUNKSIZE]
                       [--shift_plus SHIFT_PLUS] [--shift_minus SHIFT_MINUS]
                       [--collapse_within]

Create ATAC-seq fragment file from BAM file

options:
  -h, --help            show this help message and exit
  -b BAM, --bam BAM     Input bam file (must be indexed)
  -f FRAGMENTS, --fragments FRAGMENTS
                        Name and path for output fragments file. Note that the
                        output is not sorted or compressed. To sort the output
                        file use sort -k 1,1 -k2,2n
  -m MIN_MAPQ, --min_mapq MIN_MAPQ
                        Minimum MAPQ required to retain fragment (default =
                        30)
  -p NPROC, --nproc NPROC
                        Number of processors (default = 1)
  -t BARCODETAG, --barcodetag BARCODETAG
                        Read tag storing cell barcode information (default =
                        "CB")
  -c CELLS, --cells CELLS
                        Path to file containing cell barcodes to retain, or a
                        comma-separated list of cell barcodes. If None
                        (default), use all cell barocodes present in the BAM
                        file.
  --barcode_regex BARCODE_REGEX
                        Regular expression used to extract cell barcode from
                        read name. If None (default), extract cell barcode
                        from read tag. Use "[^:]*" to match all characters up
                        to the first colon.
  --use_chrom USE_CHROM
                        Regular expression used to match chromosomes to be
                        included in output. Default is "(?i)^chr" to match all
                        chromosomes starting with "chr", case insensitive
  --max_distance MAX_DISTANCE
                        Maximum distance between integration sites for the
                        fragment to be retained. Allows filtering of
                        implausible fragments that likely result from
                        incorrect mapping positions. Default is 5000 bp.
  --min_distance MIN_DISTANCE
                        Minimum distance between integration sites for the
                        fragment to be retained. Allows filtering of
                        implausible fragments that likely result from
                        incorrect mapping positions. Default is 10 bp.
  --chunksize CHUNKSIZE
                        Number of BAM file entries to iterate over before
                        collapsing the fragments and writing to disk. Higher
                        chunksize will use more memory but will be faster.
  --shift_plus SHIFT_PLUS
                        Number of bases to shift Tn5 insertion position by on
                        the forward strand.
  --shift_minus SHIFT_MINUS
                        Number of bases to shift Tn5 insertion position by on
                        the reverse strand.
  --collapse_within     Take cell barcode into account when collapsing
                        duplicate fragments. Setting this flag means that
                        fragments with the same coordinates can be identified
                        provided they originate from a different cell barcode.
```


## sinto_blocks

### Tool Description
Create scRNA-seq block file from BAM file

### Metadata
- **Docker Image**: quay.io/biocontainers/sinto:0.10.1--pyhdfd78af_0
- **Homepage**: https://timoast.github.io/sinto/
- **Package**: https://anaconda.org/channels/bioconda/packages/sinto/overview
- **Validation**: PASS

### Original Help Text
```text
usage: sinto blocks [-h] -b BAM --blocks BLOCKS [-m MIN_MAPQ] [-p NPROC]
                    [-t BARCODETAG] [-u UMITAG] [-c CELLS]
                    [--barcode_regex BARCODE_REGEX] [--strand]

Create scRNA-seq block file from BAM file

options:
  -h, --help            show this help message and exit
  -b BAM, --bam BAM     Input bam file (must be indexed)
  --blocks BLOCKS       Name and path for output blocks file. Note that the
                        output is not sorted or compressed. To sort the output
                        file use sort -k 1,1 -k2,2n
  -m MIN_MAPQ, --min_mapq MIN_MAPQ
                        Minimum MAPQ required to retain read (default = 30)
  -p NPROC, --nproc NPROC
                        Number of processors (default = 1)
  -t BARCODETAG, --barcodetag BARCODETAG
                        Read tag storing cell barcode information (default =
                        "CB")
  -u UMITAG, --umitag UMITAG
                        Read tag storing UMI barcode information (default =
                        "UB")
  -c CELLS, --cells CELLS
                        Path to file containing cell barcodes to retain, or a
                        comma-separated list of cell barcodes. If None
                        (default), use all cell barocodes present in the BAM
                        file.
  --barcode_regex BARCODE_REGEX
                        Regular expression used to extract cell barcode from
                        read name. If None (default), extract cell barcode
                        from read tag. Use "[^:]*" to match all characters up
                        to the first colon.
  --strand              Include strand information in output file
```


## sinto_barcode

### Tool Description
Add cell barcode sequences to read names in FASTQ file.

### Metadata
- **Docker Image**: quay.io/biocontainers/sinto:0.10.1--pyhdfd78af_0
- **Homepage**: https://timoast.github.io/sinto/
- **Package**: https://anaconda.org/channels/bioconda/packages/sinto/overview
- **Validation**: PASS

### Original Help Text
```text
usage: sinto barcode [-h] --barcode_fastq BARCODE_FASTQ --read1 READ1
                     [--read2 READ2] -b BASES [--prefix PREFIX]
                     [--suffix SUFFIX] [--whitelist WHITELIST]

Add cell barcode sequences to read names in FASTQ file.

options:
  -h, --help            show this help message and exit
  --barcode_fastq BARCODE_FASTQ
                        FASTQ file containing cell barcode sequences
  --read1 READ1         FASTQ file containing read 1
  --read2 READ2         FASTQ file containing read 2
  -b BASES, --bases BASES
                        Number of bases to extract from barcode-containing
                        FASTQ
  --prefix PREFIX       Prefix to add to cell barcodes
  --suffix SUFFIX       Suffix to add to cell barcodes
  --whitelist WHITELIST
                        Text file containing barcode whitelist
```


## sinto_tagtoname

### Tool Description
Copy cell barcode sequences from tag to read names. Cell barcodes will be added as a readname prefix, followed by ":"

### Metadata
- **Docker Image**: quay.io/biocontainers/sinto:0.10.1--pyhdfd78af_0
- **Homepage**: https://timoast.github.io/sinto/
- **Package**: https://anaconda.org/channels/bioconda/packages/sinto/overview
- **Validation**: PASS

### Original Help Text
```text
usage: sinto tagtoname [-h] -b BAM [-o OUTPUT] [-O OUTPUTFORMAT] [--tag TAG]

Copy cell barcode sequences from tag to read names. Cell barcodes will be
added as a readname prefix, followed by ":"

options:
  -h, --help            show this help message and exit
  -b BAM, --bam BAM     Input SAM/BAM file, '-' reads from stdin
  -o OUTPUT, --output OUTPUT
                        Output SAM/BAM file, '-' outputs to stdout (default
                        '-')
  -O OUTPUTFORMAT, --outputformat OUTPUTFORMAT
                        Output format. One of 't' (SAM), 'b' (BAM), or 'u'
                        (uncompressed BAM) ('t' default)
  --tag TAG             Read tag to copy from.
```


## sinto_nametotag

### Tool Description
Copy cell barcode sequences from read name to read tag

### Metadata
- **Docker Image**: quay.io/biocontainers/sinto:0.10.1--pyhdfd78af_0
- **Homepage**: https://timoast.github.io/sinto/
- **Package**: https://anaconda.org/channels/bioconda/packages/sinto/overview
- **Validation**: PASS

### Original Help Text
```text
usage: sinto nametotag [-h] -b BAM [-o OUTPUT] [-O OUTPUTFORMAT]
                       [--barcode_regex BARCODE_REGEX] [--tag TAG]

Copy cell barcode sequences from read name to read tag

options:
  -h, --help            show this help message and exit
  -b BAM, --bam BAM     Input SAM/BAM file, '-' reads from stdin
  -o OUTPUT, --output OUTPUT
                        Output SAM/BAM file, '-' outputs to stdout (default
                        '-')
  -O OUTPUTFORMAT, --outputformat OUTPUTFORMAT
                        Output format. One of 't' (SAM), 'b' (BAM), or 'u'
                        (uncompressed BAM) ('t' default)
  --barcode_regex BARCODE_REGEX
                        Regular expression used to extract cell barcode from
                        read name. Default ("[^:]*") matches all characters up
                        to the first colon.
  --tag TAG             Read tag to copy to.
```

