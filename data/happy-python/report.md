# happy-python CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| happy-python_autoest | PASS | real SARS-CoV-2 coverage histogram: one curve, peak at 44x, 29.4 kb of collapsed sequence, haploidy score 1.0; plots written |
| happy-python_coverage | PASS | real SARS-CoV-2 BAM: histogram covers 29467 positions (the genome length); a low-coverage BAM gives an empty histogram by design |
| happy-python_estimate | Not completed | the code looks for a coverage peak of at least 15000 positions with a 41-bin smoothing window, so it needs a deep BAM of a genome over 500 kb; the small real test data crash it with no peak found |

## happy-python_coverage

### Tool Description
Compute coverage histogram for a mapping file.

### Metadata
- **Docker Image**: quay.io/biocontainers/happy-python:0.2.1rc0--pyhdfd78af_0
- **Homepage**: https://github.com/AntoineHo/HapPy
- **Package**: https://anaconda.org/channels/bioconda/packages/happy-python/overview
- **Validation**: PASS

### Original Help Text
```text
Coverage histogram command
    Compute coverage histogram for mapping file.

    usage:
        coverage [--threads=1] --outdir=DIR <mapping.bam>

    arguments:
        mapping.bam              Sorted BAM file after mapping reads to the assembly.

    options:
        -t, --threads=INT        Number of parallel threads allocated for
                                 sambamba [default: 1].
        -d, --outdir=DIR         Path where the .cov and .hist files are written.
```

## happy-python_estimate

### Tool Description
Compute haploidy from a coverage histogram.

### Metadata
- **Docker Image**: quay.io/biocontainers/happy-python:0.2.1rc0--pyhdfd78af_0
- **Homepage**: https://github.com/AntoineHo/HapPy
- **Package**: https://anaconda.org/channels/bioconda/packages/happy-python/overview
- **Validation**: PASS

### Original Help Text
```text
Estimate command
    Compute haploidy from coverage histogram.

    usage:
        estimate [--max-contaminant=INT] [--max-diploid=INT] --size=INT --outstats=FILE [--plot] <coverage.hist>

    arguments:
        coverage.hist               Coverage histogram.

    options:
        -C, --max-contaminant=INT   Maximum coverage of contaminants.
        -D, --max-diploid=INT       Maximum coverage of the diploid peak.
        -S, --size=INT              Estimated haploid genome size.
        -O, --outstats=FILE         Path where haploidy value is written.
        -P, --plot                  Generate histogram plot.
```

## happy-python_autoest

### Tool Description
Detect peaks and compute haploidy metrics from the coverage histogram.

### Metadata
- **Docker Image**: quay.io/biocontainers/happy-python:0.2.1rc0--pyhdfd78af_0
- **Homepage**: https://github.com/AntoineHo/HapPy
- **Package**: https://anaconda.org/channels/bioconda/packages/happy-python/overview
- **Validation**: PASS

### Original Help Text
```text
Auto estimate command
    Detect peaks and computes haploidy metrics from the coverage histogram.

    usage:
        autoest [--min-peak=INT] [--prominence=INT] [--window=FLOAT] [--score=FLOAT] [--plot] [--debug] --size=INT --outstats=FILE <coverage.hist>

    arguments:
        coverage.hist               Coverage histogram.

    options:
        -S, --size=STRING           Estimated haploid genome size
                                    (Recognized modifiers: K,M,G).
        -O, --outstats=FILE         Path to file where the metrics values will be written.
        -M, --min-peak=INT          Minimum peak height
                                    [default: 15000].
        -P, --prominence=INT        Minimum peak prominence (see SciPy docs)
                                    [default: 10000].
        -W, --window=FLOAT          Window size for peak matching modifier
                                    [default: 1.5].
        -sc, --score=FLOAT          Score threshold for outputting to file
                                    [default: 0.75].
        -p, --plot                  Generate plots.
        -d, --debug                 Generate debug histogram plot.
```

