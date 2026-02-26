# viralflye CWL Generation Report

## viralflye_viralFlye.py

### Tool Description
Wrapper script for viralFlye pipeline 

See readme for details

### Metadata
- **Docker Image**: quay.io/biocontainers/viralflye:0.2--pyhdfd78af_0
- **Homepage**: https://github.com/Dmitry-Antipov/viralFlye/
- **Package**: https://anaconda.org/channels/bioconda/packages/viralflye/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/viralflye/overview
- **Total Downloads**: 1.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Dmitry-Antipov/viralFlye
- **Stars**: N/A
### Original Help Text
```text
usage: viralFlye.py [-h] --dir DIR --hmm HMM [--reads READS]
                    [--min_viral_length MIN_VIRAL_LENGTH] [--ill1 ILL1]
                    [--ill2 ILL2] [--outdir OUTDIR]
                    [--completeness COMPLETENESS] [--threads THREADS]
                    [--raven]

Wrapper script for viralFlye pipeline 
 
See readme for details

required arguments:
  --dir DIR             metaFlye output directory
  --hmm HMM             Path to Pfam-A HMM database for viralVerify script
  --reads READS         Path to long reads

optional arguments:
  --min_viral_length MIN_VIRAL_LENGTH
                        minimal limit on the viral length under study, default 5k
  --ill1 ILL1           file with left illumina reads for polishing
  --ill2 ILL2           file with right illumina reads for polishing
  --outdir OUTDIR       output directory, default - the assembler's output dir
  --completeness COMPLETENESS
                        Completeness cutoff for viralComplete,  default - 0.5
  --threads THREADS     Threads used, default - 10
```

