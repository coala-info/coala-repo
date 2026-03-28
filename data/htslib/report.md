# htslib CWL Generation Report

## Runtime validation summary

| Tool | Runtime | Data used | Reason (if fail) |
|------|---------|-----------|------------------|
| htslib_bgzip | PASS | plan:callvar_testing.narrowPeak, local:10XGenomics_subset-ba… | — |
| htslib_htsfile | PASS | plan:test.bam | — |
| htslib_tabix | PASS | plan:vcf_file.vcf.gz | — |


## htsfile

### Tool Description
Identify file formats and view or copy HTS files

### Metadata
- **Docker Image**: quay.io/biocontainers/htslib:1.23--h566b1c6_0
- **Homepage**: https://github.com/samtools/htslib
- **Package**: https://anaconda.org/channels/bioconda/packages/htslib/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/htslib/overview
- **Total Downloads**: 7.2M
- **Last updated**: 2025-12-16
- **GitHub**: https://github.com/samtools/htslib
- **Stars**: N/A
### Original Help Text
```text
htsfile: option '--h' is ambiguous; possibilities: '--header-only' '--help'
Usage: htsfile [-chHv] FILE...
       htsfile --copy [-v] FILE DESTFILE
Options:
  -c, --view         Write textual form of FILEs to standard output
  -C, --copy         Copy the exact contents of FILE to DESTFILE
  -h, --header-only  Display only headers in view mode, not records
  -H, --no-header    Suppress header display in view mode
  -v, --verbose      Increase verbosity of warnings and diagnostics
```


### Runtime validation
- **Runtime**: PASS
- **Data used**: plan:test.bam

### Runtime validation
- **Runtime**: PASS
- **Data used**: plan:test.bam

### Runtime validation
- **Runtime**: PASS
- **Data used**: plan:callvar_testing.narrowPeak, local:10XGenomics_subset-ba…

### Runtime validation
- **Runtime**: PASS
- **Data used**: plan:test.bam

### Runtime validation
- **Runtime**: PASS
- **Data used**: plan:vcf_file.vcf.gz
- **Example job**: `htslib_tabix_job.json`

## Metadata
- **Validation-run**: PASS
- **Skill**: generated
