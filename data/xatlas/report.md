# xatlas CWL Generation Report

## xatlas

### Tool Description
v0.3

### Metadata
- **Docker Image**: quay.io/biocontainers/xatlas:0.3--he565470_0
- **Homepage**: https://github.com/jfarek/xatlas
- **Package**: https://anaconda.org/channels/bioconda/packages/xatlas/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/xatlas/overview
- **Total Downloads**: 16.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/jfarek/xatlas
- **Stars**: N/A
### Original Help Text
```text
xAtlas v0.3

Required arguments:
    -r, --ref REF           Reference genome in FASTA format
    -i, --in IN             Sorted and indexed input BAM or CRAM file
    -s, --sample-name SN    Sample name to use in the output VCF file
    -p, --prefix PFX        Output VCF file prefix

Options:
    -P, --multithread               Read alignment file and process records in separate threads
    -t, --num-hts-threads NTHREAD   Number of HTSlib decompression threads to spawn
    -c, --capture-bed BED           BED file of regions to process
    -v, --min-p-value               Minimum logit P-value to report variants
    -m, --min-snp-mapq MAPQ         Minimum read mapping quality for calling SNPs
    -n, --min-indel-mapq MAPQ       Minimum read mapping quality for calling indels
    -M, --max-coverage COV          High variant coverage cutoff for filtering variants
    -A, --block-abs-lim LIM         gVCF non-variant block absolute range limit
    -R, --block-rel-lim LIM         gVCF non-variant block relative range limit coefficient
    -g, --gvcf                      Include non-variant gVCF blocks in output VCF file
    -z, --bgzf                      Write output in bgzip-compressed VCF format
    -S, --snp-logit-params FILE     File with intercept and coefficients for SNP logit model
    -I, --indel-logit-params FILE   File with intercept and coefficients for indel logit model
    -F, --enable-strand-filter      Enable SNP filter for single-strandedness
    -h, --help                      Show this help
```

