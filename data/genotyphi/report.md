# genotyphi CWL Generation Report

## genotyphi

### Tool Description
VCF to Typhi genotypes

### Metadata
- **Docker Image**: quay.io/biocontainers/genotyphi:2.0--hdfd78af_0
- **Homepage**: https://github.com/katholt/genotyphi
- **Package**: https://anaconda.org/channels/bioconda/packages/genotyphi/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/genotyphi/overview
- **Total Downloads**: 13.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/katholt/genotyphi
- **Stars**: N/A
### Original Help Text
```text
usage: genotyphi [-h] [--version] [--mode MODE] [--vcf VCF [VCF ...]]
                 [--bam BAM [BAM ...]] [--ref_id REF_ID] [--phred PHRED]
                 [--min_prop MIN_PROP] [--ref REF] [--output OUTPUT]
                 [--samtools_location SAMTOOLS_LOCATION]
                 [--bcftools_location BCFTOOLS_LOCATION]

VCF to Typhi genotypes

optional arguments:
  -h, --help            show this help message and exit
  --version             Show GenoTyphi version number and exit
  --mode MODE           Mode to run in based on input files (vcf, bam, or
                        vcf_parsnp)
  --vcf VCF [VCF ...]   VCF file(s) to genotype (Mapping MUST have been done
                        using CT18 as a reference sequence)
  --bam BAM [BAM ...]   BAM file(s) to genotype (Mapping MUST have been done
                        using CT18 as a reference sequence)
  --ref_id REF_ID       Name of the reference in the VCF file (#CHROM column)
                        or fasta file. Note that CT18 has genotype 3.2.1. If
                        all your strains return this genotype, it is likely
                        you have specified the name of the refrence sequence
                        incorrectly; please check your VCFs.
  --phred PHRED         Minimum phred quality to count a variant call vs CT18
                        as a true SNP (default 20)
  --min_prop MIN_PROP   Minimum proportion of reads required to call a SNP
                        (default 0.1)
  --ref REF             Reference sequence in fasta format. Required if bam
                        files provided.
  --output OUTPUT       Location and name for output file.
  --samtools_location SAMTOOLS_LOCATION
                        Location of folder containing samtools installation if
                        not standard/in path.
  --bcftools_location BCFTOOLS_LOCATION
                        Location of folder containing bcftools installation if
                        not standard/in path.
```

