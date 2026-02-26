# minimac4 CWL Generation Report

## minimac4_update-m3vcf

### Tool Description
Performs imputation using reference panels.

### Metadata
- **Docker Image**: quay.io/biocontainers/minimac4:4.1.6--hcb620b3_1
- **Homepage**: https://github.com/statgen/Minimac4
- **Package**: https://anaconda.org/channels/bioconda/packages/minimac4/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/minimac4/overview
- **Total Downloads**: 1.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/statgen/Minimac4
- **Stars**: N/A
### Original Help Text
```text
minimac4: option '--h' is ambiguous; possibilities: '--help' '--haps'
Usage: minimac4 [opts ...] <reference.msav> <target.{sav,bcf,vcf.gz}>
       minimac4 [opts ...] --update-m3vcf <reference.m3vcf.gz>
       minimac4 [opts ...] --compress-reference <reference.{sav,bcf,vcf.gz}>

 -a, --all-typed-sites     Include in the output sites that exist only in target VCF
 -b, --temp-buffer         Number of samples to impute before writing to temporary files (default: 200)
 -c, --chunk               Maximum chunk length in base pairs to impute at once (default: 20000000
 -e, --empirical-output    Output path for empirical dosages
 -h, --help                Print usage
 -f, --format              Comma-separated list of format fields to generate (GT, HDS, DS, GP, or SD; default: HDS)
 -m, --map                 Genetic map file
 -o, --output              Output path (default: /dev/stdout)
 -O, --output-format       Default output file format used for ambiguous filenames (bcf, sav, vcf.gz, ubcf, usav, or vcf; default: sav)
 -r, --region              Genomic region to impute
 -s, --sites               Output path for sites-only file
 -t, --threads             Number of threads (default: 1)
 -v, --version             Print version
 -w, --overlap             Size (in base pairs) of overlap before and after impute region to use as input to HMM (default: 3000000)
     --decay               Decay rate for dosages in flanking regions (default: disabled with 0)
     --min-r2              Minimum estimated r-square for output variants
     --min-ratio           Minimum ratio of number of target sites to reference sites (default: 1e-4)
     --min-ratio-behavior  Behavior for when --min-ratio is not met ("skip" or "fail"; default: fail)
     --match-error         Error parameter for HMM match probabilities (default: 0.01)
     --min-recom           Minimum recombination probability (default: 1e-5)
     --prob-threshold      Probability threshold used for template selection
     --prob-threshold-s1   Probability threshold used for template selection in original state space
     --diff-threshold      Probability diff threshold used in template selection
     --sample-ids          Comma-separated list of sample IDs to subset from reference panel
     --sample-ids-file     Text file containing sample IDs to subset from reference panel (one ID per line)
     --temp-prefix         Prefix path for temporary output files (default: ${TMPDIR}/m4_)
     --update-m3vcf        Converts M3VCF to MVCF (default output: /dev/stdout)
     --compress-reference  Compresses VCF to MVCF (default output: /dev/stdout)
     --min-block-size      Minimium block size for unique haplotype compression (default: 10)
     --max-block-size      Maximum block size for unique haplotype compression (default: 65535)
     --slope-unit          Parameter for unique haplotype compression heuristic (default: 10)
```


## minimac4_compress-reference

### Tool Description
Performs imputation using the minimac4 algorithm.

### Metadata
- **Docker Image**: quay.io/biocontainers/minimac4:4.1.6--hcb620b3_1
- **Homepage**: https://github.com/statgen/Minimac4
- **Package**: https://anaconda.org/channels/bioconda/packages/minimac4/overview
- **Validation**: PASS

### Original Help Text
```text
minimac4: option '--h' is ambiguous; possibilities: '--help' '--haps'
Usage: minimac4 [opts ...] <reference.msav> <target.{sav,bcf,vcf.gz}>
       minimac4 [opts ...] --update-m3vcf <reference.m3vcf.gz>
       minimac4 [opts ...] --compress-reference <reference.{sav,bcf,vcf.gz}>

 -a, --all-typed-sites     Include in the output sites that exist only in target VCF
 -b, --temp-buffer         Number of samples to impute before writing to temporary files (default: 200)
 -c, --chunk               Maximum chunk length in base pairs to impute at once (default: 20000000
 -e, --empirical-output    Output path for empirical dosages
 -h, --help                Print usage
 -f, --format              Comma-separated list of format fields to generate (GT, HDS, DS, GP, or SD; default: HDS)
 -m, --map                 Genetic map file
 -o, --output              Output path (default: /dev/stdout)
 -O, --output-format       Default output file format used for ambiguous filenames (bcf, sav, vcf.gz, ubcf, usav, or vcf; default: sav)
 -r, --region              Genomic region to impute
 -s, --sites               Output path for sites-only file
 -t, --threads             Number of threads (default: 1)
 -v, --version             Print version
 -w, --overlap             Size (in base pairs) of overlap before and after impute region to use as input to HMM (default: 3000000)
     --decay               Decay rate for dosages in flanking regions (default: disabled with 0)
     --min-r2              Minimum estimated r-square for output variants
     --min-ratio           Minimum ratio of number of target sites to reference sites (default: 1e-4)
     --min-ratio-behavior  Behavior for when --min-ratio is not met ("skip" or "fail"; default: fail)
     --match-error         Error parameter for HMM match probabilities (default: 0.01)
     --min-recom           Minimum recombination probability (default: 1e-5)
     --prob-threshold      Probability threshold used for template selection
     --prob-threshold-s1   Probability threshold used for template selection in original state space
     --diff-threshold      Probability diff threshold used in template selection
     --sample-ids          Comma-separated list of sample IDs to subset from reference panel
     --sample-ids-file     Text file containing sample IDs to subset from reference panel (one ID per line)
     --temp-prefix         Prefix path for temporary output files (default: ${TMPDIR}/m4_)
     --update-m3vcf        Converts M3VCF to MVCF (default output: /dev/stdout)
     --compress-reference  Compresses VCF to MVCF (default output: /dev/stdout)
     --min-block-size      Minimium block size for unique haplotype compression (default: 10)
     --max-block-size      Maximum block size for unique haplotype compression (default: 65535)
     --slope-unit          Parameter for unique haplotype compression heuristic (default: 10)
```

