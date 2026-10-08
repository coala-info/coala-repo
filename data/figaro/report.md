# figaro CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| figaro_figaro.py | PASS |  |

## figaro_figaro.py

### Tool Description
Figaro finds the best trimming positions for paired-end amplicon reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/figaro:1.1.2--hdfd78af_0
- **Homepage**: https://github.com/Zymo-Research/figaro
- **Package**: https://anaconda.org/channels/bioconda/packages/figaro/overview
- **Validation**: PASS

### Original Help Text
```text
usage: figaro.py [-h] [-o OUTPUTDIRECTORY] -a AMPLICONLENGTH -f
                 FORWARDPRIMERLENGTH -r REVERSEPRIMERLENGTH
                 [-i INPUTDIRECTORY] [-n OUTPUTFILENAME] [-m MINIMUMOVERLAP]
                 [-s SUBSAMPLE] [-p PERCENTILE] [-F FILENAMINGSTANDARD]
                 [-l LOGFILE]

optional arguments:
  -h, --help            show this help message and exit
  -o OUTPUTDIRECTORY, --outputDirectory OUTPUTDIRECTORY
                        Directory for outputs
  -a AMPLICONLENGTH, --ampliconLength AMPLICONLENGTH
                        Length of amplicon (not including primers)
  -f FORWARDPRIMERLENGTH, --forwardPrimerLength FORWARDPRIMERLENGTH
                        Length of forward primer
  -r REVERSEPRIMERLENGTH, --reversePrimerLength REVERSEPRIMERLENGTH
                        Length of reverse primer
  -i INPUTDIRECTORY, --inputDirectory INPUTDIRECTORY
                        Directory with Fastq files to analyze
  -n OUTPUTFILENAME, --outputFileName OUTPUTFILENAME
                        Output file for trim site JSON
  -m MINIMUMOVERLAP, --minimumOverlap MINIMUMOVERLAP
                        Minimum overlap between the paired-end reads
  -s SUBSAMPLE, --subsample SUBSAMPLE
                        Subsampling level (will analyze approximately 1/x
                        reads
  -p PERCENTILE, --percentile PERCENTILE
                        Percentile to use for expected error model
  -F FILENAMINGSTANDARD, --fileNamingStandard FILENAMINGSTANDARD
                        File naming standard to use
  -l LOGFILE, --logFile LOGFILE
                        Log file path
```

