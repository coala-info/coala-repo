# pathogentrack CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| pathogentrack_align | Failed | image problem: STAR not installed in the image, the tool prints status 127 and writes no output |
| pathogentrack_classify | Failed | image problem: kraken2 not installed in the image, the tool prints status 127 and writes no output |
| pathogentrack_count | Failed | image problem: umi_tools, fastp, STAR and kraken2 not installed in the image, the tool prints status 127 and writes no output |
| pathogentrack_extract | Failed | image problem: umi_tools not installed in the image, the tool prints status 127 and writes no output |
| pathogentrack_filter | Failed | image problem: fastp not installed in the image, the tool prints status 127 and writes no output |
| pathogentrack_quant | PASS | synthetic data: kraken2 input made from SARS-CoV-2 reads spiked into 10x barcodes (classify not runnable in the image) |
| pathogentrack_trim | PASS |  |

## pathogentrack_count

### Tool Description
One command to count microbes at single-cell levels.

### Metadata
- **Docker Image**: quay.io/biocontainers/pathogentrack:0.2.3--pyh5e36f6f_0
- **Homepage**: https://github.com/ncrna/PathogenTrack
- **Package**: https://anaconda.org/channels/bioconda/packages/pathogentrack/overview
- **Validation**: PASS

### Original Help Text
```text
usage: PathogenTrack count [-h] --project_id PROJECT_ID --star_index
                           STAR_INDEX --kraken_db KRAKEN_DB --barcode BARCODE
                           --read1 READ1 --read2 READ2 [--pattern PATTERN]
                           [--thread THREAD] [--confidence CONFIDENCE]
                           [--min_reads MIN_READS] [--trim_poly_x]
                           [--filter_low_complexity]
                           [--complexity_threshold COMPLEXITY_THRESHOLD]
                           [--ignore_suffix]

optional arguments:
  -h, --help            show this help message and exit
  --project_id PROJECT_ID
                        project id to store output files
  --star_index STAR_INDEX
                        star indices of the reference genome
  --kraken_db KRAKEN_DB
                        kraken2 database name
  --barcode BARCODE     file name for raw barcodes from cellranger, decompress
                        it before use
  --read1 READ1         file name for Read1
  --read2 READ2         file name for Read2
  --pattern PATTERN     barcode pattern, default="CCCCCCCCCCCCCCCCNNNNNNNNNN",
                        please refer to umi_tools help manual
  --thread THREAD       number of threads to use, default is 8
  --confidence CONFIDENCE
                        confidence threshold to use [0-1], default is 0.11
  --min_reads MIN_READS
                        minimum number of reads that supports the taxonomy,
                        default is 10
  --trim_poly_x         enable polyA/T/C/G/N trimming in 3' ends
  --filter_low_complexity
                        enable filter out low complexity reads, default is
                        False
  --complexity_threshold COMPLEXITY_THRESHOLD
                        the threshold for low complexity filter [0-100],
                        default is 30
  --ignore_suffix       ignore the read name suffixes, eg., /1 and /2 in the
                        read are ignored, default is False
```

## pathogentrack_trim

### Tool Description
Trim -1 at the end of barcode.

### Metadata
- **Docker Image**: quay.io/biocontainers/pathogentrack:0.2.3--pyh5e36f6f_0
- **Homepage**: https://github.com/ncrna/PathogenTrack
- **Package**: https://anaconda.org/channels/bioconda/packages/pathogentrack/overview
- **Validation**: PASS

### Original Help Text
```text
usage: PathogenTrack trim [-h] --project_id PROJECT_ID --barcode BARCODE
                          [--output OUTPUT]

optional arguments:
  -h, --help            show this help message and exit
  --project_id PROJECT_ID
                        project id to store output files
  --barcode BARCODE     file name for raw barcodes from cellranger, decompress
                        it before use
  --output OUTPUT       file to output barcodes to, default is barcodes.tsv
```

## pathogentrack_extract

### Tool Description
Extract and append barcode and UMI to the read2 name.

### Metadata
- **Docker Image**: quay.io/biocontainers/pathogentrack:0.2.3--pyh5e36f6f_0
- **Homepage**: https://github.com/ncrna/PathogenTrack
- **Package**: https://anaconda.org/channels/bioconda/packages/pathogentrack/overview
- **Validation**: PASS

### Original Help Text
```text
usage: PathogenTrack extract [-h] --project_id PROJECT_ID --read1 READ1
                             --read2 READ2 [--pattern PATTERN]
                             [--barcode BARCODE] [--output OUTPUT]
                             [--ignore_suffix]

optional arguments:
  -h, --help            show this help message and exit
  --project_id PROJECT_ID
                        project id to store output files
  --read1 READ1         file name for Read1
  --read2 READ2         file name for Read2
  --pattern PATTERN     barcode pattern, default="CCCCCCCCCCCCCCCCNNNNNNNNNN",
                        please refer to umi_tools help manual
  --barcode BARCODE     file name for valid barcodes
  --output OUTPUT       file to output processed read to
  --ignore_suffix       ignore the read name suffixes, eg., /1 and /2 in the
                        read are ignored, default is False
```

## pathogentrack_filter

### Tool Description
Filter out low quality / complexity reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/pathogentrack:0.2.3--pyh5e36f6f_0
- **Homepage**: https://github.com/ncrna/PathogenTrack
- **Package**: https://anaconda.org/channels/bioconda/packages/pathogentrack/overview
- **Validation**: PASS

### Original Help Text
```text
usage: PathogenTrack filter [-h] --project_id PROJECT_ID
                            [--input_reads INPUT_READS] [--thread THREAD]
                            [--output OUTPUT] [--trim_poly_x]
                            [--filter_low_complexity]
                            [--complexity_threshold COMPLEXITY_THRESHOLD]

optional arguments:
  -h, --help            show this help message and exit
  --project_id PROJECT_ID
                        project id to store output files
  --input_reads INPUT_READS
                        input single-end fastq file produced by "extract"
                        command
  --thread THREAD       number of threads to use, default is 8
  --output OUTPUT       file to output processed read to, default is
                        reads_barcoded_clean.fq.gz
  --trim_poly_x         enable polyA/T/C/G/N trimming in 3' ends
  --filter_low_complexity
                        enable filter out low complexity reads, default is
                        False
  --complexity_threshold COMPLEXITY_THRESHOLD
                        the threshold for low complexity filter [0-100],
                        default is 30
```

## pathogentrack_align

### Tool Description
Align clean reads to the reference genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/pathogentrack:0.2.3--pyh5e36f6f_0
- **Homepage**: https://github.com/ncrna/PathogenTrack
- **Package**: https://anaconda.org/channels/bioconda/packages/pathogentrack/overview
- **Validation**: PASS

### Original Help Text
```text
usage: PathogenTrack align [-h] --project_id PROJECT_ID --star_index
                           STAR_INDEX [--input_reads INPUT_READS]
                           [--thread THREAD] [--output OUTPUT]

optional arguments:
  -h, --help            show this help message and exit
  --project_id PROJECT_ID
                        project id to store output files
  --star_index STAR_INDEX
                        star indices of the reference genome
  --input_reads INPUT_READS
                        input single-end fastq file
  --thread THREAD       number of threads to use, default is 8
  --output OUTPUT       file to output unmapped reads to
```

## pathogentrack_classify

### Tool Description
Classify unmapped reads to taxons.

### Metadata
- **Docker Image**: quay.io/biocontainers/pathogentrack:0.2.3--pyh5e36f6f_0
- **Homepage**: https://github.com/ncrna/PathogenTrack
- **Package**: https://anaconda.org/channels/bioconda/packages/pathogentrack/overview
- **Validation**: PASS

### Original Help Text
```text
usage: PathogenTrack classify [-h] --project_id PROJECT_ID --kraken_db
                              KRAKEN_DB [--input_reads INPUT_READS]
                              [--thread THREAD] [--confidence CONFIDENCE]
                              [--out_reads OUT_READS] [--out_table OUT_TABLE]
                              [--out_report OUT_REPORT]

optional arguments:
  -h, --help            show this help message and exit
  --project_id PROJECT_ID
                        project id to store output files
  --kraken_db KRAKEN_DB
                        kraken2 database name
  --input_reads INPUT_READS
                        input single-end fastq file produced by "align"
                        command
  --thread THREAD       number of threads to use, default is 8
  --confidence CONFIDENCE
                        confidence threshold to use [0-1], default is 0.11
  --out_reads OUT_READS
                        file to output processed reads to
  --out_table OUT_TABLE
                        file to output kraken results to
  --out_report OUT_REPORT
                        file to output kraken report to
```

## pathogentrack_quant

### Tool Description
Deduplication and quantification of microbes at single-cell levels.

### Metadata
- **Docker Image**: quay.io/biocontainers/pathogentrack:0.2.3--pyh5e36f6f_0
- **Homepage**: https://github.com/ncrna/PathogenTrack
- **Package**: https://anaconda.org/channels/bioconda/packages/pathogentrack/overview
- **Validation**: PASS

### Original Help Text
```text
usage: PathogenTrack quant [-h] --project_id PROJECT_ID [--barcode BARCODE]
                           [--input_reads INPUT_READS]
                           [--input_table INPUT_TABLE]
                           [--input_report INPUT_REPORT]
                           [--min_reads MIN_READS]
                           [--output_reads OUTPUT_READS]
                           [--output_matrix OUTPUT_MATRIX]

optional arguments:
  -h, --help            show this help message and exit
  --project_id PROJECT_ID
                        project id to store output files
  --barcode BARCODE     file name for valid barcodes
  --input_reads INPUT_READS
                        input fastq file produced by "classify" command
  --input_table INPUT_TABLE
                        input table file produced by "classify" command
  --input_report INPUT_REPORT
                        input report file produced by "classify" command
  --min_reads MIN_READS
                        minimum number of reads that supports the taxonomy,
                        default is 10
  --output_reads OUTPUT_READS
                        file to output classified reads to, default is
                        microbes.fa
  --output_matrix OUTPUT_MATRIX
                        file to output microbe quantification matrix to,
                        default is microbes.tsv
```

## Metadata
- **Skill**: generated

