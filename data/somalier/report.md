# somalier CWL Generation Report

## somalier_extract

### Tool Description
extract genotype-like information for a single-sample at selected sites

### Metadata
- **Docker Image**: quay.io/biocontainers/somalier:0.3.1--hc78c8e0_0
- **Homepage**: https://github.com/brentp/somalier
- **Package**: https://anaconda.org/channels/bioconda/packages/somalier/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/somalier/overview
- **Total Downloads**: 6.7K
- **Last updated**: 2025-10-06
- **GitHub**: https://github.com/brentp/somalier
- **Stars**: N/A
### Original Help Text
```text
somalier extract

extract genotype-like information for a single-sample at selected sites

Usage:
  somalier extract [options] sample_file

Arguments:
  sample_file      single-sample CRAM/BAM/GVCF file or multi/single-sample VCF from which to extract

Options:
  -s, --sites=SITES          sites vcf file of variants to extract
  -f, --fasta=FASTA          path to reference fasta file
  -d, --out-dir=OUT_DIR      path to output directory (default: .)
  --sample-prefix=SAMPLE_PREFIX
                             prefix for the sample name stored inside the digest
  -h, --help                 Show this help
```


## somalier_relate

### Tool Description
calculate relatedness among samples from extracted, genotype-like information

### Metadata
- **Docker Image**: quay.io/biocontainers/somalier:0.3.1--hc78c8e0_0
- **Homepage**: https://github.com/brentp/somalier
- **Package**: https://anaconda.org/channels/bioconda/packages/somalier/overview
- **Validation**: PASS

### Original Help Text
```text
somalier relate

calculate relatedness among samples from extracted, genotype-like information

Usage:
  somalier relate [options] [extracted ...]

Arguments:
  [extracted ...]  $sample.somalier files for each sample. the first 10 are tested as a glob patterns

Options:
  -g, --groups=GROUPS        optional path  to expected groups of samples (e.g. tumor normal pairs).
                             A group file is specified as comma-separated groups per line e.g.:
                                 normal1,tumor1a,tumor1b
                                 normal2,tumor2a
  --sample-prefix=SAMPLE_PREFIX
                             optional sample prefixes that can be removed to find identical samples. e.g. batch1-sampleA batch2-sampleA
  -p, --ped=PED              optional path to a ped/fam file indicating the expected relationships among samples.
  -d, --min-depth=MIN_DEPTH  only genotype sites with at least this depth. (default: 7)
  --min-ab=MIN_AB            hets sites must be between min-ab and 1 - min_ab. set this to 0.2 for RNA-Seq data (default: 0.3)
  -u, --unknown              set unknown genotypes to hom-ref. it is often preferable to use this with VCF samples that were not jointly called
  -i, --infer                infer relationships (https://github.com/brentp/somalier/wiki/pedigree-inference)
  -o, --output-prefix=OUTPUT_PREFIX
                             output prefix for results. (default: somalier)
  -h, --help                 Show this help
```


## somalier_ancestry

### Tool Description
dimensionality reduction

### Metadata
- **Docker Image**: quay.io/biocontainers/somalier:0.3.1--hc78c8e0_0
- **Homepage**: https://github.com/brentp/somalier
- **Package**: https://anaconda.org/channels/bioconda/packages/somalier/overview
- **Validation**: PASS

### Original Help Text
```text
somalier pca

dimensionality reduction

Usage:
  somalier pca [options] [extracted ...]

Arguments:
  [extracted ...]  $sample.somalier files for each sample. place labelled samples first followed by '++' then *.somalier for query samples

Options:
  --labels=LABELS            file with ancestry labels
  -o, --output-prefix=OUTPUT_PREFIX
                             prefix for output files (default: somalier-ancestry)
  --n-pcs=N_PCS              number of principal components to use in the reduced dataset (default: 5)
  --nn-hidden-size=NN_HIDDEN_SIZE
                             shape of hidden layer in neural network (default: 16)
  --nn-batch-size=NN_BATCH_SIZE
                             batch size fo training neural network (default: 32)
  --nn-test-samples=NN_TEST_SAMPLES
                             number of labeled samples to test for NN convergence (default: 101)
  -h, --help                 Show this help
```


## somalier_find-sites

### Tool Description
Finds sites from a VCF file based on various criteria.

### Metadata
- **Docker Image**: quay.io/biocontainers/somalier:0.3.1--hc78c8e0_0
- **Homepage**: https://github.com/brentp/somalier
- **Package**: https://anaconda.org/channels/bioconda/packages/somalier/overview
- **Validation**: PASS

### Original Help Text
```text
somalier find-sites

Usage:
  somalier find-sites [options] vcf

Arguments:
  vcf              population VCF to use to find sites

Options:
  -x, --exclude=EXCLUDE      optional exclude files
  -i, --include=INCLUDE      optional include file. only consider variants that fall in ranges within this file
  --gnotate-exclude=GNOTATE_EXCLUDE
                             sites in slivar gnotation (zip) format to exclude
  --snp-dist=SNP_DIST        minimum distance between autosomal SNPs to avoid linkage (default: 10000)
  --min-AN=MIN_AN            minimum number of alleles (AN) at the site. (must be less than twice number of samples in the cohort) (default: 115_000)
  --min-AF=MIN_AF            minimum allele frequency for a site (default: 0.15)
  --AN-field=AN_FIELD        info field in the vcf that contains the allele number (default: AN)
  --AF-field=AF_FIELD        info field in the vcf that contains the allele frequency (default: AF)
  --output-vcf=OUTPUT_VCF    path to output vcf containing sites (default: sites.vcf.gz)
  -h, --help                 Show this help
```


## somalier_pedrel

### Tool Description
report pairwise relationships from pedigree file

### Metadata
- **Docker Image**: quay.io/biocontainers/somalier:0.3.1--hc78c8e0_0
- **Homepage**: https://github.com/brentp/somalier
- **Package**: https://anaconda.org/channels/bioconda/packages/somalier/overview
- **Validation**: PASS

### Original Help Text
```text
somalier pedrel

report pairwise relationships from pedigree file

Usage:
  somalier pedrel [options] pedfile

Arguments:
  pedfile          pedigry (fam) file path

Options:
  -o, --output=OUTPUT        output file path (default: stdout)
  -m, --min-relatedness=MIN_RELATEDNESS
                             minimum relatedness to report (default: 0.01)
  -h, --help                 Show this help
```


## Metadata
- **Skill**: generated
