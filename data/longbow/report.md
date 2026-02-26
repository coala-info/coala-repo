# longbow CWL Generation Report

## longbow

### Tool Description
longbow is a tool for processing fastq files.

### Metadata
- **Docker Image**: quay.io/biocontainers/longbow:2.3.1--py313hdfd78af_0
- **Homepage**: https://github.com/JMencius/longbow
- **Package**: https://anaconda.org/channels/bioconda/packages/longbow/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/longbow/overview
- **Total Downloads**: 598
- **Last updated**: 2025-05-20
- **GitHub**: https://github.com/JMencius/longbow
- **Stars**: N/A
### Original Help Text
```text
usage: longbow [-h] -i INPUT [-o OUTPUT] [-t THREADS] [-q QSCORE] [-m MODEL]
               [-a AR] [-b] [-c RC] [--stdout] [-v]

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        Path to the input fastq/fastq.gz file (required)
  -o OUTPUT, --output OUTPUT
                        Path to the output json file [default : None]
  -t THREADS, --threads THREADS
                        Number of parallel threads to use [default: 12]
  -q QSCORE, --qscore QSCORE
                        Minimum read QV to filter reads [default: 0]
  -m MODEL, --model MODEL
                        Path to the trained model [default:
                        {longbow_code_base}/model]
  -a AR, --ar AR        Enable autocorrelation for basecalling mode prediction
                        HAC/SUP(hs) or FAST/HAC/SUP (fhs) (Options: hs, fhs,
                        off) [default: fhs]
  -b, --buf             Output intermediate QV, autocorrelation results, and
                        detailed run info to output json file
  -c RC, --rc RC        Enable read QV cutoff for mode correction in Guppy5/6
                        [default: on]
  --stdout              Print results to standard output
  -v, --version         Print software version info and exit
```

