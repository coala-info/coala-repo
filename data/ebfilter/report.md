# ebfilter CWL Generation Report

## ebfilter_EBFilter

### Tool Description
EBFilter is a tool for filtering mutations based on read counts in target and control BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/ebfilter:0.2.2--pyh5ca1d4c_0
- **Homepage**: https://github.com/Genomon-Project/EBFilter
- **Package**: https://anaconda.org/channels/bioconda/packages/ebfilter/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ebfilter/overview
- **Total Downloads**: 9.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Genomon-Project/EBFilter
- **Stars**: N/A
### Original Help Text
```text
usage: EBFilter [-h] [--version] [-f {vcf,anno}] [-t thread_num]
                [-q mapping_qual_thres] [-Q base_qual_thres]
                [--ff filter_flags] [--loption] [--region REGION] [--debug]
                target.vcf target.bam controlBam_list.txt output.vcf

positional arguments:
  target.vcf            the path to the mutation file
  target.bam            the path to the target bam file
  controlBam_list.txt   the list of paths to control bam files
  output.vcf            the path to the output

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -f {vcf,anno}         the format of mutation file vcf or annovar (tsv)
                        format
  -t thread_num         the number of threads
  -q mapping_qual_thres
                        threshold for mapping quality for calculating base
                        counts
  -Q base_qual_thres    threshold for base quality for calculating base counts
  --ff filter_flags     skip reads with mask bits set
  --loption             use samtools mpileup -l option
  --region REGION       restrict the chromosomal region for mutation. active
                        only if loption is on
  --debug               keep intermediate files
```

