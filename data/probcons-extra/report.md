# probcons-extra CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| probcons-extra_pc-compare | PASS |  |
| probcons-extra_pc-makegnuplot | Failed | image problem: gnuplot is not installed in the image, so no plot is drawn |
| probcons-extra_pc-project | PASS |  |

## probcons-extra_pc-compare

### Tool Description
Score a test alignment against a reference alignment

### Metadata
- **Docker Image**: biocontainers/probcons-extra:v1.12-12-deb_cv1
- **Homepage**: http://probcons.stanford.edu/
- **Package**: https://anaconda.org/channels/bioconda/packages/probcons-extra/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: score TEST_ALIGNMENT REFERENCE_ALIGNMENT [BALIBASE_ANNOT_FILE] [-col] [-core] [-caps] [-annot FILENAME]
```

## probcons-extra_pc-makegnuplot

### Tool Description
Make a column reliability plot from probcons annotation scores

### Metadata
- **Docker Image**: biocontainers/probcons-extra:v1.12-12-deb_cv1
- **Homepage**: http://probcons.stanford.edu/
- **Package**: https://anaconda.org/channels/bioconda/packages/probcons-extra/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: makegnuplot annotscores [refscores]
```

## probcons-extra_pc-project

### Tool Description
Project a multiple alignment onto pairwise alignments

### Metadata
- **Docker Image**: biocontainers/probcons-extra:v1.12-12-deb_cv1
- **Homepage**: http://probcons.stanford.edu/
- **Package**: https://anaconda.org/channels/bioconda/packages/probcons-extra/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: project ALIGNMENT [-nocompressgaps]
```

