# umis CWL Generation Report

## umis_add_uid

### Tool Description
Adds UID:[samplebc cellbc umi] to readname for umi-tools deduplication
  Expects formatted fastq files with correct sample and cell barcodes.

### Metadata
- **Docker Image**: quay.io/biocontainers/umis:1.0.9--py310h1fe012e_5
- **Homepage**: https://github.com/vals/umis
- **Package**: https://anaconda.org/channels/bioconda/packages/umis/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/umis/overview
- **Total Downloads**: 128.8K
- **Last updated**: 2025-09-04
- **GitHub**: https://github.com/vals/umis
- **Stars**: N/A
### Original Help Text
```text
Usage: umis add_uid [OPTIONS] FASTQ

  Adds UID:[samplebc cellbc umi] to readname for umi-tools deduplication
  Expects formatted fastq files with correct sample and cell barcodes.

Options:
  --cores INTEGER
  --help           Show this message and exit.
```


## umis_bamtag

### Tool Description
Convert a BAM/SAM with fastqtransformed read names to have UMI and cellular barcode tags

### Metadata
- **Docker Image**: quay.io/biocontainers/umis:1.0.9--py310h1fe012e_5
- **Homepage**: https://github.com/vals/umis
- **Package**: https://anaconda.org/channels/bioconda/packages/umis/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: umis bamtag [OPTIONS] SAM

  Convert a BAM/SAM with fastqtransformed read names to have UMI and cellular
  barcode tags

Options:
  --help  Show this message and exit.
```


## umis_cb_filter

### Tool Description
Filters reads with non-matching barcodes Expects formatted fastq files.

### Metadata
- **Docker Image**: quay.io/biocontainers/umis:1.0.9--py310h1fe012e_5
- **Homepage**: https://github.com/vals/umis
- **Package**: https://anaconda.org/channels/bioconda/packages/umis/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: umis cb_filter [OPTIONS] FASTQ

  Filters reads with non-matching barcodes Expects formatted fastq files.

Options:
  --bc1 TEXT       [required]
  --bc2 TEXT
  --bc3 TEXT
  --cores INTEGER
  --nedit INTEGER
  --help           Show this message and exit.
```


## umis_cb_histogram

### Tool Description
Counts the number of reads for each cellular barcode

Expects formatted fastq files.

### Metadata
- **Docker Image**: quay.io/biocontainers/umis:1.0.9--py310h1fe012e_5
- **Homepage**: https://github.com/vals/umis
- **Package**: https://anaconda.org/channels/bioconda/packages/umis/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: umis cb_histogram [OPTIONS] FASTQ

  Counts the number of reads for each cellular barcode

  Expects formatted fastq files.

Options:
  --umi_histogram TEXT  Output a count of each UMI for each cellular barcode
                        to this file.
  --help                Show this message and exit.
```


## umis_demultiplex_cells

### Tool Description
Demultiplex a fastqtransformed FASTQ file into a FASTQ file for each cell.

### Metadata
- **Docker Image**: quay.io/biocontainers/umis:1.0.9--py310h1fe012e_5
- **Homepage**: https://github.com/vals/umis
- **Package**: https://anaconda.org/channels/bioconda/packages/umis/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: umis demultiplex_cells [OPTIONS] FASTQ

  Demultiplex a fastqtransformed FASTQ file into a FASTQ file for each cell.

Options:
  --out_dir TEXT
  --readnumber TEXT
  --prefix TEXT
  --cb_histogram TEXT
  --cb_cutoff INTEGER
  --help               Show this message and exit.
```


## umis_demultiplex_samples

### Tool Description
Demultiplex a fastqtransformed FASTQ file into a FASTQ file for each sample.

### Metadata
- **Docker Image**: quay.io/biocontainers/umis:1.0.9--py310h1fe012e_5
- **Homepage**: https://github.com/vals/umis
- **Package**: https://anaconda.org/channels/bioconda/packages/umis/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: umis demultiplex_samples [OPTIONS] FASTQ

  Demultiplex a fastqtransformed FASTQ file into a FASTQ file for each sample.

Options:
  --out_dir TEXT
  --nedit INTEGER
  --barcodes FILENAME
  --help               Show this message and exit.
```


## umis_fastqtransform

### Tool Description
Transform input reads to the tagcounts compatible read layout using regular expressions as defined in a transform file. Outputs new format to stdout.

### Metadata
- **Docker Image**: quay.io/biocontainers/umis:1.0.9--py310h1fe012e_5
- **Homepage**: https://github.com/vals/umis
- **Package**: https://anaconda.org/channels/bioconda/packages/umis/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: umis fastqtransform [OPTIONS] TRANSFORM FASTQ1 [FASTQ2] [FASTQ3]
                           [FASTQ4]

  Transform input reads to the tagcounts compatible read layout using regular
  expressions as defined in a transform file. Outputs new format to stdout.

Options:
  --keep_fastq_tags
  --separate_cb         Keep dual index barcodes separate.
  --demuxed_cb TEXT
  --cores INTEGER
  --fastq1out TEXT
  --fastq2out TEXT
  --min_length INTEGER  Minimum length of read to keep.
  --help                Show this message and exit.
```


## umis_fasttagcount

### Tool Description
Count up evidence for tagged molecules, this implementation assumes the
  alignment file is coordinate sorted

### Metadata
- **Docker Image**: quay.io/biocontainers/umis:1.0.9--py310h1fe012e_5
- **Homepage**: https://github.com/vals/umis
- **Package**: https://anaconda.org/channels/bioconda/packages/umis/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: umis fasttagcount [OPTIONS] SAM OUT

  Count up evidence for tagged molecules, this implementation assumes the
  alignment file is coordinate sorted

Options:
  --genemap TEXT       A TSV file mapping transcript ids to gene ids. If
                       provided expression will be summarised to gene level
                       (recommended).
  --positional
  --minevidence FLOAT
  --cb_histogram TEXT  A TSV file with CBs and a count. If the counts are are
                       the number of reads at a CB, the cb_cutoff option can
                       be used to filter out CBs to be counted.
  --cb_cutoff TEXT     Number of counts to filter cellular barcodes. Set to
                       'auto' to calculate a cutoff automatically.
  --subsample INTEGER
  --parse_tags         Parse BAM tags in stead of read name. In this mode the
                       optional tags UM and CR will be used for UMI and cell
                       barcode, respetively.
  --gene_tags          Use the optional TX and GX tags in the BAM file to read
                       gene mapping information in stead of the mapping target
                       nane. Useful if e.g. reads have been mapped to genome
                       in stead of transcriptome.
  --umi_matrix TEXT    Save a sparse matrix of counts without UMI deduping to
                       this file.
  --help               Show this message and exit.
```


## umis_kallisto

### Tool Description
Convert fastqtransformed file to output format compatible with kallisto.

### Metadata
- **Docker Image**: quay.io/biocontainers/umis:1.0.9--py310h1fe012e_5
- **Homepage**: https://github.com/vals/umis
- **Package**: https://anaconda.org/channels/bioconda/packages/umis/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: umis kallisto [OPTIONS] FASTQ

  Convert fastqtransformed file to output format compatible with kallisto.

Options:
  --out_dir TEXT
  --cb_histogram TEXT
  --cb_cutoff INTEGER
  --help               Show this message and exit.
```


## umis_mb_filter

### Tool Description
Filters umis with non-ACGT bases Expects formatted fastq files.

### Metadata
- **Docker Image**: quay.io/biocontainers/umis:1.0.9--py310h1fe012e_5
- **Homepage**: https://github.com/vals/umis
- **Package**: https://anaconda.org/channels/bioconda/packages/umis/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: umis mb_filter [OPTIONS] FASTQ

  Filters umis with non-ACGT bases Expects formatted fastq files.

Options:
  --cores INTEGER
  --help           Show this message and exit.
```


## umis_sb_filter

### Tool Description
Filters reads with non-matching sample barcodes Expects formatted fastq files.

### Metadata
- **Docker Image**: quay.io/biocontainers/umis:1.0.9--py310h1fe012e_5
- **Homepage**: https://github.com/vals/umis
- **Package**: https://anaconda.org/channels/bioconda/packages/umis/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: umis sb_filter [OPTIONS] FASTQ

  Filters reads with non-matching sample barcodes Expects formatted fastq
  files.

Options:
  --bc FILENAME
  --cores INTEGER
  --nedit INTEGER
  --help           Show this message and exit.
```


## umis_sparse

### Tool Description
Convert a CSV file to a sparse matrix with rows and column names saved as companion files.

### Metadata
- **Docker Image**: quay.io/biocontainers/umis:1.0.9--py310h1fe012e_5
- **Homepage**: https://github.com/vals/umis
- **Package**: https://anaconda.org/channels/bioconda/packages/umis/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: umis sparse [OPTIONS] CSV SPARSE

  Convert a CSV file to a sparse matrix with rows and column names saved as
  companion files.

Options:
  --help  Show this message and exit.
```


## umis_subset_bamfile

### Tool Description
Subset a SAM/BAM file, keeping only alignments from given cellular barcodes

### Metadata
- **Docker Image**: quay.io/biocontainers/umis:1.0.9--py310h1fe012e_5
- **Homepage**: https://github.com/vals/umis
- **Package**: https://anaconda.org/channels/bioconda/packages/umis/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: umis subset_bamfile [OPTIONS] SAM BARCODES

  Subset a SAM/BAM file, keeping only alignments from given cellular barcodes

Options:
  --help  Show this message and exit.
```


## umis_tagcount

### Tool Description
Count up evidence for tagged molecules

### Metadata
- **Docker Image**: quay.io/biocontainers/umis:1.0.9--py310h1fe012e_5
- **Homepage**: https://github.com/vals/umis
- **Package**: https://anaconda.org/channels/bioconda/packages/umis/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: umis tagcount [OPTIONS] SAM OUT

  Count up evidence for tagged molecules

Options:
  --genemap TEXT                A TSV file mapping transcript ids to gene ids.
                                If provided expression will be summarised to
                                gene level (recommended).
  --output_evidence_table TEXT
  --positional
  --minevidence FLOAT
  --cb_histogram TEXT           A TSV file with CBs and a count. If the counts
                                are are the number of reads at a CB, the
                                cb_cutoff option can be used to filter out CBs
                                to be counted.
  --cb_cutoff TEXT              Number of counts to filter cellular barcodes.
                                Set to 'auto' to calculate a cutoff
                                automatically.
  --no_scale_evidence
  --subsample INTEGER
  --sparse                      Ouput counts in MatrixMarket format.
  --parse_tags                  Parse BAM tags in stead of read name. In this
                                mode the optional tags UM and CR will be used
                                for UMI and cell barcode, respetively.
  --gene_tags                   Use the optional TX and GX tags in the BAM
                                file to read gene mapping information in stead
                                of the mapping target nane. Useful if e.g.
                                reads have been mapped to genome in stead of
                                transcriptome.
  --help                        Show this message and exit.
```


## umis_umi_histogram

### Tool Description
Counts the number of reads for each UMI

### Metadata
- **Docker Image**: quay.io/biocontainers/umis:1.0.9--py310h1fe012e_5
- **Homepage**: https://github.com/vals/umis
- **Package**: https://anaconda.org/channels/bioconda/packages/umis/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: umis umi_histogram [OPTIONS] FASTQ

  Counts the number of reads for each UMI

  Expects formatted fastq files.

Options:
  --help  Show this message and exit.
```

