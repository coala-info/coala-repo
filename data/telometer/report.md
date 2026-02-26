# telometer CWL Generation Report

## telometer

### Tool Description
Calculate telomere length from a BAM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/telometer:1.1--pyhdfd78af_0
- **Homepage**: https://github.com/santiago-es/Telometer
- **Package**: https://anaconda.org/channels/bioconda/packages/telometer/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/telometer/overview
- **Total Downloads**: 2.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/santiago-es/Telometer
- **Stars**: N/A
### Original Help Text
```text
usage: telometer [-h] -b BAM -o OUTPUT [-m MINREADLEN] [-g MAXGAPLEN]
                 [-t THREADS] [-l MEMLIMIT]

Calculate telomere length from a BAM file.

options:
  -h, --help            show this help message and exit
  -b BAM, --bam BAM     The path to the sorted BAM file.
  -o OUTPUT, --output OUTPUT
                        The path to the output file.
  -m MINREADLEN, --minreadlen MINREADLEN
                        Minimum read length to consider (Default: 1000 for
                        telomere capture, use 4000 for WGS). Optional
  -g MAXGAPLEN, --maxgaplen MAXGAPLEN
                        Maximum allowed gap length between telomere regions.
                        Optional
  -t THREADS, --threads THREADS
                        Number of processing threads to use. Optional
  -l MEMLIMIT, --memlimit MEMLIMIT
                        Maximum amount of memory to commit per batch of reads
                        while processing. Optional, default = 8 Gb
```

