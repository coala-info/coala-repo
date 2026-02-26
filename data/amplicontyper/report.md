# amplicontyper CWL Generation Report

## amplicontyper_train

### Tool Description
Classify reads in BAM file using existing model or train a model from bam files

### Metadata
- **Docker Image**: quay.io/biocontainers/amplicontyper:0.1.34--pyhdfd78af_0
- **Homepage**: https://github.com/AntonS-bio/AmpliconTyper
- **Package**: https://anaconda.org/channels/bioconda/packages/amplicontyper/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/amplicontyper/overview
- **Total Downloads**: 1.1K
- **Last updated**: 2026-01-31
- **GitHub**: https://github.com/AntonS-bio/AmpliconTyper
- **Stars**: N/A
### Original Help Text
```text
usage: train [-h] -t TARGET_REGIONS -r REFERENCE [-p POSITIVE_BAMS]
             [-n NEGATIVE_BAMS] -v VCF [-s SPECIAL_CASES] -o OUTPUT_DIR
             [--cpus CPUS] [-m BAMS_MATRIX]

Classify reads in BAM file using existing model or train a model from bam
files

options:
  -h, --help            show this help message and exit
  -t, --target_regions TARGET_REGIONS
                        Bed file that specifies reference intervals to which
                        reads where mapped
  -r, --reference REFERENCE
                        FASTA file with the reference to which reads where
                        mapped
  -p, --positive_bams POSITIVE_BAMS
                        Directory with or list of NON-target BAM files and
                        corresponding BAM index files (.bai)
  -n, --negative_bams NEGATIVE_BAMS
                        Directory with or list of TARGET BAM files and
                        corresponding BAM index files (.bai)
  -v, --vcf VCF         VCF file containing positions that will be excluded
                        from training as well as genotype defining SNPs (also
                        excluded)
  -s, --special_cases SPECIAL_CASES
                        Tab delimited file specifying amplicon for which
                        presence/absense should be reported
  -o, --output_dir OUTPUT_DIR
                        Directory for output files
  --cpus CPUS           Directory for output files
  -m, --bams_matrix BAMS_MATRIX
                        Matrix with precalculated BAM matrices ()
usage: train [-h] -t TARGET_REGIONS -r REFERENCE [-p POSITIVE_BAMS]
             [-n NEGATIVE_BAMS] -v VCF [-s SPECIAL_CASES] -o OUTPUT_DIR
             [--cpus CPUS] [-m BAMS_MATRIX]

Classify reads in BAM file using existing model or train a model from bam
files

options:
  -h, --help            show this help message and exit
  -t, --target_regions TARGET_REGIONS
                        Bed file that specifies reference intervals to which
                        reads where mapped
  -r, --reference REFERENCE
                        FASTA file with the reference to which reads where
                        mapped
  -p, --positive_bams POSITIVE_BAMS
                        Directory with or list of NON-target BAM files and
                        corresponding BAM index files (.bai)
  -n, --negative_bams NEGATIVE_BAMS
                        Directory with or list of TARGET BAM files and
                        corresponding BAM index files (.bai)
  -v, --vcf VCF         VCF file containing positions that will be excluded
                        from training as well as genotype defining SNPs (also
                        excluded)
  -s, --special_cases SPECIAL_CASES
                        Tab delimited file specifying amplicon for which
                        presence/absense should be reported
  -o, --output_dir OUTPUT_DIR
                        Directory for output files
  --cpus CPUS           Directory for output files
  -m, --bams_matrix BAMS_MATRIX
                        Matrix with precalculated BAM matrices ()
```

