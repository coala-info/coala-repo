# tbvcfreport CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| tbvcfreport_generate | Not completed | needs the COMBAT-TB NeoDB server (neodb.sanbi.ac.za:7687); it accepts the connection but every query hangs, so no report is written (real Galaxy test VCF and TB-Profiler JSON) |

## tbvcfreport_generate

### Tool Description
Generate an interactive HTML-based VCF report.

### Metadata
- **Docker Image**: quay.io/biocontainers/tbvcfreport:1.0.1--pyhdfd78af_0
- **Homepage**: http://github.com/COMBAT-TB/tbvcfreport
- **Package**: https://anaconda.org/channels/bioconda/packages/tbvcfreport/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/tbvcfreport/overview
- **Total Downloads**: 9.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/COMBAT-TB/tbvcfreport
- **Stars**: N/A
### Original Help Text
```text
Usage: tbvcfreport generate [OPTIONS] VCF_DIR

  Generate an interactive HTML-based VCF report.

Options:
  -t, --tbprofiler-report FILENAME
                                  TBProfiler json report.
  -f, --filter-udi / -nf, --no-filter-udi
                                  Filter upstream, downstream and intergenic
                                  variants.  [default: f]
  --db_url TEXT                   URL to connect to COMBAT TB eXplorer NeoDB
  --help                          Show this message and exit.
```

