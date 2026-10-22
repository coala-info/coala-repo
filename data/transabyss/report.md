# transabyss CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| transabyss | Failed | image problem: transabyss stops with 'environment is not sufficient' because bin/skip_psl_self.awk is missing under site-packages |
| transabyss_transabyss-merge | Failed | image problem: same missing site-packages/bin awk scripts check stops the merge |

## transabyss

### Tool Description
De novo assembly of RNA-Seq data using ABySS at multiple k-mer sizes.

### Metadata
- **Docker Image**: quay.io/biocontainers/transabyss:2.0.1--py27_4
- **Homepage**: http://www.bcgsc.ca/platform/bioinfo/software/trans-abyss
- **Package**: https://anaconda.org/channels/bioconda/packages/transabyss/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/transabyss/overview
- **Total Downloads**: 24.4K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Unable to find image 'quay.io/biocontainers/transabyss:2.0.1--py27_4' locally
2.0.1--py27_4: Pulling from biocontainers/transabyss
a3ed95caeb02: Already exists
77c6c00e8b61: Already exists
3aaade50789a: Already exists
00cf8b9f3d2a: Already exists
7ff999a2256f: Already exists
d2ba336f2e44: Already exists
dfda3e01f2b6: Already exists
a3ed95caeb02: Already exists
10c3bb32200b: Already exists
a8bb499e8327: Pulling fs layer
docker: write /var/lib/docker/tmp/GetImageBlob2812809778: no space left on device

Run 'docker run --help' for more information
```

## transabyss_transabyss-merge

### Tool Description
Merge Trans-ABySS assemblies.

### Metadata
- **Docker Image**: quay.io/biocontainers/transabyss:2.0.1--py27_4
- **Homepage**: http://www.bcgsc.ca/platform/bioinfo/software/trans-abyss
- **Package**: https://anaconda.org/channels/bioconda/packages/transabyss/overview
- **Validation**: PASS

### Original Help Text
```text
[help] transabyss-merge: ok via transabyss-merge --help (--help=ok, -h=ok, -help=ok, (no args)=ok)
usage: transabyss-merge [-h] [--version] --mink INT --maxk INT
                        [--prefixes STR [STR ...]] [--SS] [--force]
                        [--out PATH] [--threads INT] [--length INT]
                        [--no-cleanup] [--abyssmap] [--abyssmap-itr]
                        [--indel INT] [--pid FLOAT]
                        PATH [PATH ...]

Merge Trans-ABySS assemblies.

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit

Input:
  PATH                  assembly FASTA file(s)
  --mink INT            smallest k-mer size
  --maxk INT            largest k-mer size
  --prefixes STR [STR ...]
                        prefixes for the contigs from each assembly
  --SS                  assemblies are strand-specific

Basic Options:
  --force               force overwriting
  --out PATH            output file [/tmp/transabyss-merged.fa]
  --threads INT         number of threads [1]
  --length INT          shortest sequence to report [0]
  --no-cleanup          do not remove intermediate files at completion

Advanced Options:
  --abyssmap            use abyss-map to merge all FASTA files at once (NOTE:
                        faster than BLAT but less sensitive and more memory
                        intensive)
  --abyssmap-itr        use abyss-map to merge one additional FASTA at a time,
                        utilizing less memory.
  --indel INT           indel size tolerance [1]
  --pid FLOAT           minimum percent sequence identity of redundant
                        sequences [0.95]

Written by Ka Ming Nip.
Copyright 2018 Canada's Michael Smith Genome Sciences Centre
Report bugs to <trans-abyss@googlegroups.com>
```

