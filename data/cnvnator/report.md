# cnvnator CWL Generation Report

## cnvnator

### Tool Description
A tool for CNV discovery and genotyping from depth of read mapping

### Metadata
- **Docker Image**: quay.io/biocontainers/cnvnator:0.4.1--py312h99c8fb2_11
- **Homepage**: https://github.com/abyzovlab/CNVnator
- **Package**: https://anaconda.org/channels/bioconda/packages/cnvnator/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cnvnator/overview
- **Total Downloads**: 9.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/abyzovlab/CNVnator
- **Stars**: N/A
### Original Help Text
```text
Not enough parameters.

CNVnator v0.4.1

Usage:
cnvnator -root out.root  [-genome name] [-chrom 1 2 ...] -tree  file1.bam ... [-lite]
cnvnator -root out.root  [-genome name] [-chrom 1 2 ...] -merge file1.root ...
cnvnator -root file.root  [-genome name] [-chrom 1 2 ...] -vcf [file.vcf.gz | file.vcf] [-rmchr] [-addchr]
cnvnator -root file.root  [-genome name] [-chrom 1 2 ...] -idvar [file.vcf.gz | file.vcf] [-rmchr] [-addchr]
cnvnator -root file.root  [-genome name] [-chrom 1 2 ...] -mask strict.mask.file.fa.gz [-rmchr] [-addchr]
cnvnator -root file.root [-genome name] [-chrom 1 2 ...] [-d dir | -fasta file.fa.gz] -his bin_size
cnvnator -root file.root [-genome name] [-chrom 1 2 ...] -baf bin_size [-hap] [-useid] [-nomask]
cnvnator -root file.root [-chrom 1 2 ...] -stat      bin_size
cnvnator -root file.root                  -eval      bin_size
cnvnator -root file.root [-chrom 1 2 ...] -partition bin_size [-ngc]
cnvnator -root file.root [-chrom 1 2 ...] -call      bin_size [-ngc]
cnvnator -root file.root -genotype bin_size [-ngc]
cnvnator -root file.root -view     bin_size [-ngc]
cnvnator -pe   file1.bam ... -qual val(20) -over val(0.8) [-f file]
cnvnator-root file.root [-chrom 1 2 ...] -cptrees newfile.root
cnvnator-root file.root -ls

Valid genomes (-genome option) are: NCBI36, hg18, GRCh37, hg19, mm9, hg38, GRCh38
```

