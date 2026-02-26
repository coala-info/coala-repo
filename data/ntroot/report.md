# ntroot CWL Generation Report

## ntroot

### Tool Description
Ancestry inference from genomic data

### Metadata
- **Docker Image**: quay.io/biocontainers/ntroot:1.1.6--py313pl5321hdfd78af_0
- **Homepage**: https://github.com/bcgsc/ntroot
- **Package**: https://anaconda.org/channels/bioconda/packages/ntroot/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ntroot/overview
- **Total Downloads**: 2.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bcgsc/ntroot
- **Stars**: N/A
### Original Help Text
```text
usage: ntroot [-h] [-r REFERENCE] [--reads READS]
              [--genome GENOME [GENOME ...]] -l L [-k K] [--tile TILE] [--lai]
              [-t T] [-z Z] [-j J] [-Y Y] [--custom_vcf CUSTOM_VCF]
              [--strip_info] [-v] [-V] [-n] [-f]

ntRoot: Ancestry inference from genomic data

options:
  -h, --help            show this help message and exit
  -r REFERENCE, --reference REFERENCE
                        Reference genome (FASTA, Multi-FASTA, and/or gzipped compatible)
  --reads READS         Prefix of input reads file(s) for detecting SNVs. All files in the working directory with the specified prefix will be used. (fastq, fasta, gz, bz, zip)
  --genome GENOME [GENOME ...]
                        Genome assembly file(s) for detecting SNVs compared to --reference
  -l L                  input VCF file with annotated variants (e.g., clinvar.vcf, 1000GP_integrated_snv_v2a_27022019.GRCh38.phased_gt1.vcf.gz)
  -k K                  k-mer size
  --tile TILE           Tile size for ancestry fraction inference (bp) [default=5000000]
  --lai                 Output ancestry predictons per tile in a separate output file
  -t T                  Number of threads [default=4]
  -z Z                  Minimum contig length [default=100]
  -j J                  controls size of k-mer subset. When checking subset of k-mers, check every jth k-mer [default=3]
  -Y Y                  Ratio of number of k-mers in the k subset that should be present to accept an edit (higher=stringent) [default=0.55]
  --custom_vcf CUSTOM_VCF
                        Input VCF for computing ancestry. When specified, ntRoot will skip the ntEdit step, and predict ancestry from the provided VCF.
  --strip_info          When using --custom_vcf, strip the existing INFO field from the input VCF.
  -v, --verbose         Verbose mode [default=False]
  -V, --version         show program's version number and exit
  -n, --dry-run         Print out the commands that will be executed
  -f, --force           Run all ntRoot steps, regardless of existing output files

Note: please specify --reads OR --genome (not both)
If you have any questions about ntRoot, please open an issue at https://github.com/bcgsc/ntRoot
```

