# linkstats CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| linkstats_cov_gap_hist_data | PASS |  |
| linkstats_coverage_data | PASS |  |
| linkstats_mol_len_hist_data | PASS |  |
| linkstats_molecule_data | PASS |  |
| linkstats_sam_data | PASS |  |

## linkstats_sam_data

### Tool Description
Read SAM/BAM/CRAM data from PATH.

### Metadata
- **Docker Image**: quay.io/biocontainers/linkstats:0.1.3--py310h82d6cb0_6
- **Homepage**: https://github.com/wtsi-hpag/LinkStats
- **Package**: https://anaconda.org/channels/bioconda/packages/linkstats/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: LinkStats sam-data [OPTIONS] PATH

  Read SAM/BAM/CRAM data from PATH.

  Creates summary and molecular data-sets for each sample-name (SM:Z tag or RG:Z SAM tag).

  Alignments must have BX:Z (barcode) SAM tags.

Options:
  -r, --reference PATH     FASTA reference for CRAM decoding.
  -n, --name TEXT          Sample name, overrides name from SM or RG tags.
  --mi / --no-mi           Group by MI:I as well as BX:Z SAM tags.
                           Default=False.
  -t, --threshold INTEGER  Maximum allowed separation between alignments
                           grouped to the same molecule.
  --help                   Show this message and exit.
```

## linkstats_molecule_data

### Tool Description
Read in molecular data from a CSV FILE.

### Metadata
- **Docker Image**: quay.io/biocontainers/linkstats:0.1.3--py310h82d6cb0_6
- **Homepage**: https://github.com/wtsi-hpag/LinkStats
- **Package**: https://anaconda.org/channels/bioconda/packages/linkstats/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: LinkStats molecule-data [OPTIONS] FILE

  Read in molecular data from a CSV FILE.

  Use to re-calculate histogram data.

Options:
  --help  Show this message and exit.
```

## linkstats_coverage_data

### Tool Description
Read in coverage gap data from a CSV FILE.

### Metadata
- **Docker Image**: quay.io/biocontainers/linkstats:0.1.3--py310h82d6cb0_6
- **Homepage**: https://github.com/wtsi-hpag/LinkStats
- **Package**: https://anaconda.org/channels/bioconda/packages/linkstats/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: LinkStats coverage-data [OPTIONS] FILE

  Read in coverage gap data from a CSV FILE.

  Use to re-calculate histogram data.

Options:
  --help  Show this message and exit.
```

## linkstats_mol_len_hist_data

### Tool Description
Read in molecule length histogram data from a CSV FILE.

### Metadata
- **Docker Image**: quay.io/biocontainers/linkstats:0.1.3--py310h82d6cb0_6
- **Homepage**: https://github.com/wtsi-hpag/LinkStats
- **Package**: https://anaconda.org/channels/bioconda/packages/linkstats/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: LinkStats mol-len-hist-data [OPTIONS] FILE

  Read in molecule length histogram data from a CSV FILE.

  Use to re-generate or create combined plots.

Options:
  --help  Show this message and exit.
```

## linkstats_cov_gap_hist_data

### Tool Description
Read in coverage gap histogram data from a CSV FILE.

### Metadata
- **Docker Image**: quay.io/biocontainers/linkstats:0.1.3--py310h82d6cb0_6
- **Homepage**: https://github.com/wtsi-hpag/LinkStats
- **Package**: https://anaconda.org/channels/bioconda/packages/linkstats/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: LinkStats cov-gap-hist-data [OPTIONS] FILE

  Read in coverage gap histogram data from a CSV FILE.

  Use to re-generate or create combined plots.

Options:
  --help  Show this message and exit.
```
