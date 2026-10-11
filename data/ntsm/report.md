# ntsm CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| ntsm_ntsmCount | PASS | counts file written to stdout; 1544 chr21 sites covered by real chr21 reads |
| ntsm_ntsmEval | PASS | two halves of one real chr21 read set compared: relatedness 0.87, homozygous concordance 0.93 |
| ntsm_ntsmSiteGen | PASS | generate-sites on 1000 Genomes chr22 SNPs; sites FASTA files written; generate-pca-rot-mat not tested |
| ntsm_ntsmVCF | Failed | tool bug: ntsmVCF segfaults (exit 139) right after opening the sites file on two real multi-sample VCFs |

## ntsm_ntsmCount

### Tool Description
Count k-mers for SNP sites

### Metadata
- **Docker Image**: quay.io/biocontainers/ntsm:1.2.1--h077b44d_1
- **Homepage**: https://github.com/JustinChu/ntsm
- **Package**: https://anaconda.org/channels/bioconda/packages/ntsm/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ntsmCount -s [FASTA] [OPTION]... [FILES...]
  -t, --threads = INT    Number of threads to run.[1]
  -m, --maxCov = INT     k-mer coverage threshold for early
                         termination. [inf]
  -o, --output = STR     Output for summary file.
  -d, --dupes            Allow shared k-mers between sites to
                         be counted.
  -s, --snp = STR        Interleaved fasta of SNP sites to
                         k-merize. [required]
  -k, --kmer = INT       k-mer size used. [19]
  -h, --help             Display this dialog.
  -v, --verbose          Display verbose output.
      --version          Print version information.
```


## ntsm_ntsmEval

### Tool Description
Processes sets of counts files and compares their similarity. If only a single file is provided general QC information returned.

### Metadata
- **Docker Image**: quay.io/biocontainers/ntsm:1.2.1--h077b44d_1
- **Homepage**: https://github.com/JustinChu/ntsm
- **Package**: https://anaconda.org/channels/bioconda/packages/ntsm/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ntsmEval [FILES...]
Processes sets of counts files and compares their similarity.
If only a single file is provided general QC information returned.
  -t, --threads              Number of threads to run.[1]
  -s, --score_thresh = FLOAT Score threshold [0.500000]
  -a, --all                  Output results of all tests tried, not just those that
                             pass the score threshold.
  -w, --skew = FLOAT         Divides the score by coverage. Formula: (cov1*cov2)^skew
                             Set to zero for no skew.[0.200000]
  -c, --min_cov = INT        Keep only sites with this coverage and above.[1]
  -g, --genome_size = INT    Diploid genome size for error rate estimation.
                             [6200000000]
  -e, --merge = STR          After analysis merge counts and output to file.
  -o, --only_merge           Do not perform an analysis. Only functions when
                             -e (--merge) option is specified.
  -p, --pca = STR            Use PCA information to speed up analysis. Input is a
                             set of rotational values from a PCA.
  -d, --dim = INT            Number of dimensions to consider in PCA. [20]
  -n, --norm = STR           Set of values use to center the data before rotation
                             during PCA. [Required if -p is enabled]
  -r, --error_rate = FLOAT   Error rate threshold for PCA based search [0.010000]
  -1, --miss_small = FLOAT   Missing site threshold small for PCA based search [0.010000]
  -2, --miss_large = FLOAT   Missing site threshold large PCA based search [0.300000]
  -S, --small = FLOAT        Search radius for small PCA based search [2.000000]
  -l, --large = FLOAT        Search radius for large PCA based search [15.000000]
  -h, --help                 Display this dialog.
  -v, --verbose              Display verbose output.
      --version              Print version information.
```


## ntsm_ntsmVCF

### Tool Description
Converts a multi vcf file to a set of counts files, or creates a matrix for PCA.

### Metadata
- **Docker Image**: quay.io/biocontainers/ntsm:1.2.1--h077b44d_1
- **Homepage**: https://github.com/JustinChu/ntsm
- **Package**: https://anaconda.org/channels/bioconda/packages/ntsm/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ntsmVCF -s [FASTA] -r [FASTA] [VCF]
Converts a multi vcf file to a set of counts files.
Alternatively, you may also create a matrix to be used for PCA.
  -t, --threads = INT    Number of threads to run.[1]
  -d, --dupes            Allow shared k-mers between sites to
                         be counted.
  -s, --snp = STR        Interleaved fasta of SNP sites to
                         k-merize. [required]
  -p, --pca = STR        With multivcf generate rotation and
                         centering files with this prefix.
  -k, --kmer = INT       k-mer size used. [19]
  -m, --multi = INT      Value to multiply base counts [20]
  -w, --window = INT     Window size used. [31]
  -r, --ref = STR        Reference fasta. [required]
  -h, --help             Display this dialog.
  -v, --verbose          Display verbose output.
      --version          Print version information.
```


## ntsm_ntsmSiteGen

### Tool Description
Generate k-mer sites or a PCA rotation matrix (makefile driver with key=value parameters).

### Metadata
- **Docker Image**: quay.io/biocontainers/ntsm:1.2.1--h077b44d_1
- **Homepage**: https://github.com/JustinChu/ntsm
- **Package**: https://anaconda.org/channels/bioconda/packages/ntsm/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ntsmSiteGen generate-sites name=PREFIX ref=REF.fa vcf=SNPS.vcf [w=31] [k=19] [t=4]
       ntsmSiteGen generate-pca-rot-mat name=PREFIX sites=SITES.fa multivcf=MULTI.vcf [dims=20]
```


## Metadata
- **Skill**: generated
