# sscocaller CWL Generation Report

## sscocaller

### Tool Description
Call SNPs in single-cell DNA sequencing data

### Metadata
- **Docker Image**: quay.io/biocontainers/sscocaller:0.2.2--hda81887_4
- **Homepage**: https://gitlab.svi.edu.au/biocellgen-public/sscocaller
- **Package**: https://anaconda.org/channels/bioconda/packages/sscocaller/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sscocaller/overview
- **Total Downloads**: 7.1K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
0.2.2

  Usage:
      sscocaller [options] <BAM> <VCF> <barcodeFile> <out_prefix>

Arguments:

  <BAM> the read alignment file with records of single-cell DNA reads
  
  <VCF> the variant call file with records of SNPs

  <barcodeFile> the text file containing the list of cell barcodes

  <out_prefix>  the prefix of output files


Options:
  -t --threads <threads> number of BAM decompression threads [default: 4]
  -cb --cellbarcode <cellbarcode> the cell barcode tag, by default it is CB
  --minMAPQ <mapq> Minimum MAPQ for read filtering [default: 20]
  --baseq <baseq>  base quality threshold for a base to be used for counting [default: 13]
  --chrom <chrom> the selected chromsome (whole genome if not supplied,separate by comma if multiple chroms)
  --minDP <minDP> the minimum DP for a SNP to be included in the output file [default: 1]
  --maxDP <maxDP> the maximum DP for a SNP to be included in the output file [default: 5]
  --maxTotalDP <maxTotalDP> the maximum DP across all barcodes for a SNP to be included in the output file [default: 25]
  --minTotalDP <minTotalDP> the minimum DP across all barcodes for a SNP to be included in the output file [default: 10]          
  --chrName <chrName> the chr names with chr prefix or not, if not supplied then no prefix
  --thetaREF <thetaREF> the theta for the binomial distribution conditioning on hidden state being REF [default: 0.1]
  --thetaALT <thetaALT> the theta for the binomial distribution conditioning on hidden state being ALT [default: 0.9]
  --cmPmb <cmPmb> the average centiMorgan distances per megabases default 0.1 cm per Mb [default 0.1]
  -h --help  show help

  Examples
      ./sscocaller --threads 10 AAAGTAGCACGTCTCT-1.raw.bam AAAGTAGCACGTCTCT-1.raw.bam.dp3.alt.vcf.gz barcodeFile.tsv ./percell/ccsnp
```

