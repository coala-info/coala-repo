# blaze2 CWL Generation Report

## blaze2_blaze

### Tool Description
BLAZE2 is a tool for demultiplexing 10X single cell long-read RNA-seq data. It takes fastq files as input and output a whitelist of barcodes and a fastq with demultiplexed reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/blaze2:2.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/shimlab/BLAZE
- **Package**: https://anaconda.org/channels/bioconda/packages/blaze2/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/blaze2/overview
- **Total Downloads**: 2.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/shimlab/BLAZE
- **Stars**: N/A
### Original Help Text
```text
usage: blaze [options] <input fastq filename/directory>

[1mBLAZE2 is a tool for demultiplexing 10X single cell long-read RNA-seq
data. It takes fastq files as input and output a whitelist of barcodes and a
fastq with demultiplexed reads. [0m

positional arguments:
  <input fastq filename/directory>
                        Filename of input fastq files. Can be a directory or a
                        single file.

options:
  -h, --help            show this help message and exit
  --output-prefix OUTPUT_PREFIX
                        Filename of output files. Note that the output can be
                        directed to a different directory by specifying the
                        path in the prefix. E.g., --output-prefix
                        /path/to/output/prefix (default: )
  --output-fastq OUTPUT_FASTQ, -o OUTPUT_FASTQ
                        Filename of output fastq file name. Note that the
                        filename has to end with .fastq, .fq, .fastq.gz or
                        .fq.gz. (default: matched_reads.fastq.gz)
  --threads THREADS     Number of threads to used. (default: 19)
  --batch-size BATCH_SIZE
                        Number of reads process together as a batch. Note that
                        if the specified number larger than the number of
                        reads in each fastq files, all reads in the file will
                        be processed as a batch. (default: 1000)
  --overwrite           By default, BLAZE will skip the steps generating the
                        existing file(s). Specify this option to rerun the
                        steps those steps and overwrite the existing output
                        files. (default: False)
  --minimal_stdout      Minimise the command-line printing. (default: False)

[1mOne of these argument is required to generate the whitelist.Note that if multiple options are specified, the priority is as follows: --no-whitelisting > --force-cells > --count-threshold > --expect-cells[0m:
  --expect-cells EXPECT_CELLS
                        Expected number of cells. (default: None)
  --count-threshold COUNT_THRESHOLD
                        Output the whitelist base of the count threshold of
                        high-quality putative barcodes (default: None)
  --force-cells FORCE_CELLS
                        Force the number of cells to be the specified number.
                        This option is useful when the expected number of
                        cells is known. (default: None)
  --no-whitelisting     Do not perform whitelisting, if dumultiplexing is
                        enabled, the reads will be assigned to know list of
                        barcodes specified by --known-bc-list. (default: True)

[1m
Optional arguments for generating the whitelist[0m:
  --minQ MINQ           Minimum phred score for all bases in a putative BC to
                        define a "high quality putative barcode". (default:
                        15)
  --max-edit-distance MAX_EDIT_DISTANCE
                        Maximum edit distance allowed between a putative
                        barcode and a barcode for a read to be assigned to the
                        barcode. (default: 2)
  --10x-kit-version {3v4,3v3,3v2,5v3,5v2}, --kit-version {3v4,3v3,3v2,5v3,5v2}
                        Choose from 10X Single Cell 3ʹ gene expression v4, v3,
                        v2 (3v4, 3v3, 3v2) or 5ʹ gene expression v3, v2 (5v3,
                        5v2). If using other protocols, please do not specify
                        this option and specify --full-bc-whitelist and --umi-
                        len instead. (default: 3v3)
  --umi-len UMI_LEN     UMI length, will only be used when --kit-version is
                        not specified. (default: 12)
  --full-bc-whitelist FULL_BC_WHITELIST
                        Filename of the full barcode whitelist. If not
                        specified, the corresponding version of 10X whitelist
                        will be used. (default: None)
  --high-sensitivity-mode
                        Turn on the sensitivity mode, which increases the
                        sensitivity of barcode detections but potentially
                        increase the number false/uninformative BC in the
                        whitelist. Identification of empty droplets are
                        recommended in downstream (default: False)

[1mDemultiplexing options[0m:
  --no-demultiplexing   Do not perform the demultiplexing step. (default:
                        True)
  --known-bc-list KNOWN_BC_LIST
                        A file specifies a list of barcodes for
                        demultiplexing. If not specified, the barcodes will be
                        assigned to the whitelist from the whitelisting step.
                        (default: None)
  --no-restrand         By default, blaze2 re-strands all reads to transcript
                        strand: reads from the reverse strand (those with
                        ployT instead of polyA) will be reverse complemented
                        the their quality scores will be reversed. This option
                        will disable the re-stranding. (default: True)
```

