# hat-phasing CWL Generation Report

## hat-phasing_HAT

### Tool Description
HAT

### Metadata
- **Docker Image**: quay.io/biocontainers/hat-phasing:0.1.8--pyh5e36f6f_0
- **Homepage**: https://github.com/AbeelLab/hat/
- **Package**: https://anaconda.org/channels/bioconda/packages/hat-phasing/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/hat-phasing/overview
- **Total Downloads**: 10.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/AbeelLab/hat
- **Stars**: N/A
### Original Help Text
```text
usage: HAT [-h] [-rl READ_LENGTH] [-pl PHASING_LOCATION] [-r REFERENCE_FILE]
           [-lf LONGREADS_FASTA] [-sf1 SHORTREADS_1_FASTQ]
           [-sf2 SHORTREADS_2_FASTQ] [-th TRUE_HAPLOTYPES]
           [-ma MULTIPLE_GENOME_ALIGNMENT] [-ha HAPLOTYPE_ASSEMBLY]
           chromosome_name vcf_file short_read_alignment long_read_alignment
           ploidy output output_dir

positional arguments:
  chromosome_name       The chromosome which is getting phased
  vcf_file              VCF file name
  short_read_alignment  short reads alignment file
  long_read_alignment   long reads alignment file
  ploidy                ploidy of the chromosome
  output                output prefix file name
  output_dir            output directory

optional arguments:
  -h, --help            show this help message and exit
  -rl READ_LENGTH, --read_length READ_LENGTH
                        short reads length
  -pl PHASING_LOCATION, --phasing_location PHASING_LOCATION
                        the location in the chromosome which is phased
  -r REFERENCE_FILE, --reference_file REFERENCE_FILE
                        reference file
  -lf LONGREADS_FASTA, --longreads_fasta LONGREADS_FASTA
                        long reads fasta file
  -sf1 SHORTREADS_1_FASTQ, --shortreads_1_fastq SHORTREADS_1_FASTQ
                        first pair fastq file
  -sf2 SHORTREADS_2_FASTQ, --shortreads_2_fastq SHORTREADS_2_FASTQ
                        second pair fastq file
  -th TRUE_HAPLOTYPES, --true_haplotypes TRUE_HAPLOTYPES
                        the correct haplotypes file
  -ma MULTIPLE_GENOME_ALIGNMENT, --multiple_genome_alignment MULTIPLE_GENOME_ALIGNMENT
                        Multiple genome alignment file of haplotypes to the
                        reference
  -ha HAPLOTYPE_ASSEMBLY, --haplotype_assembly HAPLOTYPE_ASSEMBLY
                        Assembly of the haplotype sequences
```

