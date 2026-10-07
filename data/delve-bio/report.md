# delve-bio CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| delve-bio_call | PASS | nf-core ARTIC SARS-CoV-2 BAM on MN908947.3: 24 calls including the known homozygous C241T, C3037T, C14408T and A23403G (D614G). |

## delve-bio_call

### Tool Description
Call variants from a BAM file

### Metadata
- **Docker Image**: quay.io/biocontainers/delve-bio:0.2.0--h4349ce8_0
- **Homepage**: https://github.com/berndbohmeier/delve
- **Package**: https://anaconda.org/channels/bioconda/packages/delve-bio/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/delve-bio/overview
- **Total Downloads**: 893
- **Last updated**: 2025-09-13
- **GitHub**: https://github.com/berndbohmeier/delve
- **Stars**: N/A
### Original Help Text
```text
Call variants from a BAM file

Usage: delve call [OPTIONS] --fasta-ref <FILE> <BAMFILE>

Arguments:
  <BAMFILE>  BAM file

Options:
  -f, --fasta-ref <FILE>
          Reference FASTA file
  -R, --regions-file <FILE>
          Regions file
  -r, --region <REGION>
          Region string
  -s, --sample_name <NAME>
          Sample name [default: sample]
  -o, --output <FILE>
          Output file
  -q, --min-MQ <MIN_MQ>
          Minimum mapping quality [default: 0]
  -Q, --min-BQ <MIN_BQ>
          Minimum base quality [default: 20]
      --min-cov <MIN_COV>
          Minimum coverage [default: 10]
      --max-cov <MAX_COV>
          Maximum coverage [default: 5000]
      --truncate-regions <INT>
          Minimum VAF Truncate regions [default: 0]
      --compute-baq
          Compute BAQ
      --strand-bias-odds-ratio <FLOAT>
          Strand bias odds ratio [default: 7]
      --deletion-filter-threshold <FLOAT>
          Deletion filter threshold. Positions with higher ratio of deletions will be filtered [default: 0.8]
      --low-qual-reads-filter-threshold <FLOAT>
          Too many low quality reads filter threshold. Positions with higher ratio of low quality reads will be filtered [default: 0.8]
      --model-params <LRT_REF,LRT_ALT,H0_VAF>
          Model parameters (comma-separated floats) [default: 8.0,8.0,0.01]
  -v, --variants-only
          Show only variants
      --apply-filters <LIST>
          Apply filters
      --set-failed-GTs <TYPE>
          Set genotypes of failed samples to missing value (.) or reference (0) [possible values: 0, .]
  -h, --help
          Print help
```

