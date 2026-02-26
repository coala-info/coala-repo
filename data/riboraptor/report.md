# riboraptor CWL Generation Report

## riboraptor_bam-to-bedgraph

### Tool Description
Convert bam to bedgraph

### Metadata
- **Docker Image**: quay.io/biocontainers/riboraptor:0.2.2--py36_0
- **Homepage**: https://github.com/saketkc/riboraptor
- **Package**: https://anaconda.org/channels/bioconda/packages/riboraptor/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/riboraptor/overview
- **Total Downloads**: 6.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/saketkc/riboraptor
- **Stars**: N/A
### Original Help Text
```text
Usage: riboraptor bam-to-bedgraph [OPTIONS]

  Convert bam to bedgraph

Options:
  -i, --bam TEXT                  Path to BAM file  [required]
  -s, --strand [+|-|both]         Count from strand of this type only
  -e, --end_type [5prime|3prime|either]
                                  Pileup 5' / 3'/ either ends
  -o, --saveto TEXT               Path to write bedgraph output
  -h, --help                      Show this message and exit.
```


## riboraptor_bedgraph-to-bigwig

### Tool Description
Convert bedgraph to bigwig

### Metadata
- **Docker Image**: quay.io/biocontainers/riboraptor:0.2.2--py36_0
- **Homepage**: https://github.com/saketkc/riboraptor
- **Package**: https://anaconda.org/channels/bioconda/packages/riboraptor/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: riboraptor bedgraph-to-bigwig [OPTIONS]

  Convert bedgraph to bigwig

Options:
  -bg, -i, --bedgraph TEXT  Path to bedgraph file (optional)
  -s, --sizes TEXT          Path to genome chrom.sizes file  [required]
  -o, --saveto TEXT         Path to write bigwig output  [required]
  -h, --help                Show this message and exit.
```


## riboraptor_export-bed-fasta

### Tool Description
Export gene level fasta from specified bed regions

### Metadata
- **Docker Image**: quay.io/biocontainers/riboraptor:0.2.2--py36_0
- **Homepage**: https://github.com/saketkc/riboraptor
- **Package**: https://anaconda.org/channels/bioconda/packages/riboraptor/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: riboraptor export-bed-fasta [OPTIONS]

  Export gene level fasta from specified bed regions

Options:
  --region_bed TEXT    Path to bed file  [required]
  --fasta TEXT         Path to fasta file  [required]
  -o, --prefix TEXT    Path to write output
  --chrom_sizes TEXT   Path to chrom.sizes  [required]
  --offset_5p INTEGER  Number of upstream bases to count(5')
  --offset_3p INTEGER  Number of downstream bases to count(3')
  --ignore_tx_version  Ignore version (.xyz) in gene names
  -h, --help           Show this message and exit.
```


## riboraptor_export-gene-coverages

### Tool Description
Export gene level coverage for all genes for given region

### Metadata
- **Docker Image**: quay.io/biocontainers/riboraptor:0.2.2--py36_0
- **Homepage**: https://github.com/saketkc/riboraptor
- **Package**: https://anaconda.org/channels/bioconda/packages/riboraptor/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: riboraptor export-gene-coverages [OPTIONS]

  Export gene level coverage for all genes for given region

Options:
  -bw, --bigwig TEXT   Path to bigwig  [required]
  --region_bed TEXT    Path to bed file  [required]
  --saveto TEXT        Path to write gene coverages tsv file
  --offset_5p INTEGER  Number of upstream bases to count(5')
  --offset_3p INTEGER  Number of downstream bases to count(3')
  --ignore_tx_version  Ignore version (.xyz) in gene names
  -h, --help           Show this message and exit.
```


## riboraptor_export-metagene-coverage

### Tool Description
Export metagene coverage for given region

### Metadata
- **Docker Image**: quay.io/biocontainers/riboraptor:0.2.2--py36_0
- **Homepage**: https://github.com/saketkc/riboraptor
- **Package**: https://anaconda.org/channels/bioconda/packages/riboraptor/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: riboraptor export-metagene-coverage [OPTIONS]

  Export metagene coverage for given region

Options:
  -bw, --bigwig TEXT       Path to bigwig  [required]
  --region_bed TEXT        Path to bed file or a genome name (hg38_utr5,
                           hg38_cds, hg38_utr3)  [required]
  --saveto TEXT            Path to write metagene coverage tsv file
  --max_positions INTEGER  maximum positions to count
  --offset_5p INTEGER      Number of upstream bases to count(5')
  --offset_3p INTEGER      Number of downstream bases to count(3')
  --ignore_tx_version      Ignore version (.xyz) in gene names
  -h, --help               Show this message and exit.
```


## riboraptor_periodicity

### Tool Description
Calculate periodicity of Ribo-seq data.

### Metadata
- **Docker Image**: quay.io/biocontainers/riboraptor:0.2.2--py36_0
- **Homepage**: https://github.com/saketkc/riboraptor
- **Package**: https://anaconda.org/channels/bioconda/packages/riboraptor/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/riboraptor", line 6, in <module>
    sys.exit(riboraptor.cli.cli())
  File "/usr/local/lib/python3.6/site-packages/click/core.py", line 722, in __call__
    return self.main(*args, **kwargs)
  File "/usr/local/lib/python3.6/site-packages/click/core.py", line 697, in main
    rv = self.invoke(ctx)
  File "/usr/local/lib/python3.6/site-packages/click/core.py", line 1066, in invoke
    return _process_result(sub_ctx.command.invoke(sub_ctx))
  File "/usr/local/lib/python3.6/site-packages/click/core.py", line 895, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/usr/local/lib/python3.6/site-packages/click/core.py", line 535, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.6/site-packages/riboraptor/cli.py", line 131, in periodicity_cmd
    sys.stdin.readlines(), input_is_stream=True)
TypeError: naive_periodicity() got an unexpected keyword argument 'input_is_stream'
```


## riboraptor_plot-metagene

### Tool Description
Plot metagene read counts.

### Metadata
- **Docker Image**: quay.io/biocontainers/riboraptor:0.2.2--py36_0
- **Homepage**: https://github.com/saketkc/riboraptor
- **Package**: https://anaconda.org/channels/bioconda/packages/riboraptor/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/riboraptor", line 6, in <module>
    sys.exit(riboraptor.cli.cli())
  File "/usr/local/lib/python3.6/site-packages/click/core.py", line 722, in __call__
    return self.main(*args, **kwargs)
  File "/usr/local/lib/python3.6/site-packages/click/core.py", line 697, in main
    rv = self.invoke(ctx)
  File "/usr/local/lib/python3.6/site-packages/click/core.py", line 1066, in invoke
    return _process_result(sub_ctx.command.invoke(sub_ctx))
  File "/usr/local/lib/python3.6/site-packages/click/core.py", line 895, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/usr/local/lib/python3.6/site-packages/click/core.py", line 535, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.6/site-packages/riboraptor/cli.py", line 241, in plot_read_counts_cmd
    input_is_stream=True)
  File "/usr/local/lib/python3.6/site-packages/riboraptor/plotting.py", line 338, in plot_read_counts
    for line in counts:
UnboundLocalError: local variable 'counts' referenced before assignment
```


## riboraptor_plot-read-length

### Tool Description
Plot read length distribution

### Metadata
- **Docker Image**: quay.io/biocontainers/riboraptor:0.2.2--py36_0
- **Homepage**: https://github.com/saketkc/riboraptor
- **Package**: https://anaconda.org/channels/bioconda/packages/riboraptor/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/riboraptor", line 6, in <module>
    sys.exit(riboraptor.cli.cli())
  File "/usr/local/lib/python3.6/site-packages/click/core.py", line 722, in __call__
    return self.main(*args, **kwargs)
  File "/usr/local/lib/python3.6/site-packages/click/core.py", line 697, in main
    rv = self.invoke(ctx)
  File "/usr/local/lib/python3.6/site-packages/click/core.py", line 1066, in invoke
    return _process_result(sub_ctx.command.invoke(sub_ctx))
  File "/usr/local/lib/python3.6/site-packages/click/core.py", line 895, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/usr/local/lib/python3.6/site-packages/click/core.py", line 535, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.6/site-packages/riboraptor/cli.py", line 278, in plot_read_length_dist_cmd
    ascii=ascii)
  File "/usr/local/lib/python3.6/site-packages/riboraptor/plotting.py", line 168, in plot_read_length_dist
    min(read_lengths_counts),
ValueError: min() arg is an empty sequence
```


## riboraptor_read-length-dist

### Tool Description
Calculate read length distribution

### Metadata
- **Docker Image**: quay.io/biocontainers/riboraptor:0.2.2--py36_0
- **Homepage**: https://github.com/saketkc/riboraptor
- **Package**: https://anaconda.org/channels/bioconda/packages/riboraptor/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: riboraptor read-length-dist [OPTIONS]

  Calculate read length distribution

Options:
  --bam TEXT     Path to BAM file  [required]
  --saveto TEXT  Path to write read length dist tsv output
  -h, --help     Show this message and exit.
```


## riboraptor_uniq-bam

### Tool Description
Create a new bam with unique mapping reads only

### Metadata
- **Docker Image**: quay.io/biocontainers/riboraptor:0.2.2--py36_0
- **Homepage**: https://github.com/saketkc/riboraptor
- **Package**: https://anaconda.org/channels/bioconda/packages/riboraptor/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: riboraptor uniq-bam [OPTIONS]

  Create a new bam with unique mapping reads only

Options:
  --inbam TEXT   [required]
  --outbam TEXT  [required]
  -h, --help     Show this message and exit.
```


## riboraptor_uniq-mapping-count

### Tool Description
Count number of unique mapping reads

### Metadata
- **Docker Image**: quay.io/biocontainers/riboraptor:0.2.2--py36_0
- **Homepage**: https://github.com/saketkc/riboraptor
- **Package**: https://anaconda.org/channels/bioconda/packages/riboraptor/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: riboraptor uniq-mapping-count [OPTIONS]

  Count number of unique mapping reads

Options:
  --bam TEXT  Path to BAM file  [required]
  -h, --help  Show this message and exit.
```


## Metadata
- **Skill**: generated
