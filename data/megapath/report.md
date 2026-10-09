# megapath CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| megapath_runMegaPath-Amplicon.sh | Not completed | pipeline, skipped (also needs the large MegaPath databases, not in the image) |
| megapath_runMegaPath.sh | Not completed | pipeline, skipped (also needs the large MegaPath databases, not in the image) |

## megapath_runMegaPath.sh

### Tool Description
Runs the MegaPath pipeline for sequence analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/megapath:2--h43eeafb_4
- **Homepage**: https://github.com/edwwlui/MegaPath
- **Package**: https://anaconda.org/channels/bioconda/packages/megapath/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/megapath/overview
- **Total Downloads**: 6.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/edwwlui/MegaPath
- **Stars**: N/A
### Original Help Text
```text
Usage: /usr/local/bin/runMegaPath.sh -1 <read1.fq> -2 <read2.fq> [options]
    -p  output prefix [megapath]
    -t  number of threads [24]
    -c  NT alignment score cutoff [40]
    -s  SPIKE filter number of stdev [60]
    -o  SPIKE overlap [0.5]
    -L  max read length [150]
    -d  database directory [/usr/local/MegaPath/db]
    -S  Perform ribosome filtering
    -H  skip human filtering
    -A  Perform assembly & protein alignment
```


## megapath_runMegaPath-Amplicon.sh

### Tool Description
Run MegaPath for amplicon sequencing.

### Metadata
- **Docker Image**: quay.io/biocontainers/megapath:2--h43eeafb_4
- **Homepage**: https://github.com/edwwlui/MegaPath
- **Package**: https://anaconda.org/channels/bioconda/packages/megapath/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/runMegaPath-Amplicon.sh -1 <read1.fq> -2 <read2.fq> [options]
    -p  output prefix [megapath-amplicon]
    -t  number of threads [45]
    -L  max read length [250]
    -d  database directory [/usr/local/MegaPath/db]
```


## Metadata
- **Skill**: generated
