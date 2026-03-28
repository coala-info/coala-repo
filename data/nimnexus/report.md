# nimnexus CWL Generation Report

## nimnexus_trim

### Tool Description
Trim the fastq reads

### Metadata
- **Docker Image**: quay.io/biocontainers/nimnexus:0.1.1--hcb20899_3
- **Homepage**: https://github.com/avsecz/nimnexus
- **Package**: https://anaconda.org/channels/bioconda/packages/nimnexus/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/nimnexus/overview
- **Total Downloads**: 10.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/avsecz/nimnexus
- **Stars**: N/A
### Original Help Text
```text
Trim the fastq reads

    Usage: nimnexus trim [options] <barcode>

Arguments:

   <barcode>    Barcode sequences (comma-separated) that follow random barcode

Options:

  -t --trim <int>           Pre-trim all reads by this length before processing [default: 0]
  -k --keep <int>           Minimum number of bases required after barcode to keep read [default: 18]
  -r --randombarcode <int>  Number of bases at the start of each read used for random barcode [default: 5]

Example:
  zcat input.fastq.gz | nimnexus trim -t 1 CTGA,TGAC,GACT,ACTG | gzip -c > output.fastq.gz

  # Using pigz to (de-)compress in parallel
  pigz -cd input.fastq.gz | nimnexus trim -t 1 CTGA,TGAC,GACT,ACTG | pigz -c > output.fastq.gz
```


## nimnexus_dedup

### Tool Description
Remove duplicate reads from the sorted bam file

### Metadata
- **Docker Image**: quay.io/biocontainers/nimnexus:0.1.1--hcb20899_3
- **Homepage**: https://github.com/avsecz/nimnexus
- **Package**: https://anaconda.org/channels/bioconda/packages/nimnexus/overview
- **Validation**: PASS

### Original Help Text
```text
Remove duplicate reads from the sorted bam file

    Usage: nimnexus dedup [options] <BAM>

Arguments:

   <BAM>    sorted BAM file

Options:

  -t --threads <int>       number of BAM decompression threads [default: 2]

Example:
  nimnexus dedup -t 10 file.bam | samtools view -b > file.dedup.bam
```


## Metadata
- **Skill**: generated
