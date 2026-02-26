# mameshiba CWL Generation Report

## mameshiba_shiba.py

### Tool Description
Shiba v0.8.1 - Pipeline for identification of differential RNA splicing

### Metadata
- **Docker Image**: quay.io/biocontainers/mameshiba:0.8.1--hdfd78af_1
- **Homepage**: https://github.com/Sika-Zheng-Lab/Shiba
- **Package**: https://anaconda.org/channels/bioconda/packages/mameshiba/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mameshiba/overview
- **Total Downloads**: 1.4K
- **Last updated**: 2026-02-21
- **GitHub**: https://github.com/Sika-Zheng-Lab/Shiba
- **Stars**: N/A
### Original Help Text
```text
usage: shiba.py [-h] [-p PROCESS] [-s START_STEP] [--mame] [-v] config

Shiba v0.8.1 - Pipeline for identification of differential RNA splicing

Step 1: bam2gtf.py
    - Assembles transcript structures based on mapped reads using StringTie2.
Step 2: gtf2event.py
    - Converts GTF files to event format.
Step 3: bam2junc.py
    - Extracts junction reads from BAM files.
Step 4: psi.py
    - Calculates PSI values and performs differential analysis.
Step 5: expression.py
    - Analyzes gene expression.
Step 6: pca.py
    - Performs PCA.
Step 7: plots.py
    - Generates plots from results.

positional arguments:
  config                Config file in yaml format

options:
  -h, --help            show this help message and exit
  -p PROCESS, --process PROCESS
                        Number of processors to use (default: 1)
  -s START_STEP, --start-step START_STEP
                        Start the pipeline from the specified step (default: 0, run all steps)
  --mame                Execute MameShiba, a lightweight version of Shiba, for only splicing analysis. Steps 5-7 will be skipped.
  -v, --verbose         Verbose mode
```

