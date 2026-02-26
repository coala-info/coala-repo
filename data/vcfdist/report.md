# vcfdist CWL Generation Report

## vcfdist

### Tool Description
Evaluate variant calls in a phased VCF file against a ground truth VCF and reference FASTA.

### Metadata
- **Docker Image**: quay.io/biocontainers/vcfdist:2.6.4--h436c8a6_0
- **Homepage**: https://github.com/TimD1/vcfdist
- **Package**: https://anaconda.org/channels/bioconda/packages/vcfdist/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/vcfdist/overview
- **Total Downloads**: 7.0K
- **Last updated**: 2025-09-17
- **GitHub**: https://github.com/TimD1/vcfdist
- **Stars**: N/A
### Original Help Text
```text
Usage: vcfdist <query.vcf> <truth.vcf> <ref.fasta> [options]

Required:
  <STRING>	query.vcf	phased VCF file containing variant calls to evaluate 
  <STRING>	truth.vcf	phased VCF file containing ground truth variant calls 
  <STRING>	ref.fasta	FASTA file containing draft reference sequence 

Options:

  Inputs/Outputs:
  -b, --bed <STRING>
      BED file containing regions to evaluate
  -v, --verbosity <INTEGER> [1]
      printing verbosity (0: succinct, 1: default, 2:verbose)
  -p, --prefix <STRING> [./]
      prefix for output files (directory needs a trailing slash)
  -n, --no-output-files
      skip writing output files, only print summary to console

  Variant Filtering/Selection:
  -f, --filter <STRING1,STRING2...> [ALL]
      select just variants passing these FILTERs (OR operation)
  -l, --largest-variant <INTEGER> [5000]
      maximum variant size, larger variants ignored
  -sv, --sv-threshold <INTEGER> [50]
      variants of this size or larger are considered SVs, not INDELs
  -mn, --min-qual <INTEGER> [0]
      minimum variant quality, lower qualities ignored
  -mx, --max-qual <INTEGER> [60]
      maximum variant quality, higher qualities kept but thresholded

  Re-Alignment:
  -rq, --realign-query
      realign query variants using Smith-Waterman parameters
  -rt, --realign-truth
      realign truth variants using Smith-Waterman parameters
  -ro, --realign-only
      standardize truth and query variant representations, then exit
  -x, --mismatch-penalty <INTEGER> [5]
      Smith-Waterman mismatch (substitution) penalty
  -o, --gap-open-penalty <INTEGER> [6]
      Smith-Waterman gap opening penalty
  -e, --gap-extend-penalty <INTEGER> [2]
      Smith-Waterman gap extension penalty

  Precision-Recall:
  -ct, --credit-threshold <FLOAT> [0.70]
      minimum partial credit to consider variant a true positive

  Distance:
  -d, --distance
      flag to include alignment distance calculations, skipped by default

  Utilization:
  -t, --max-threads <INTEGER> [64]
      maximum threads to use for clustering and precision/recall alignment
  -r, --max-ram <FLOAT> [64.000GB]
      (approximate) maximum RAM to use for precision/recall alignment

  Miscellaneous:
  -h, --help
      show this help message
  -a, --advanced
      show advanced options, not recommended for most users
  -ci, --citation
      please cite vcfdist if used in your analyses. Thanks :)
  -v, --version
      print vcfdist version (v2.6.4)
```

