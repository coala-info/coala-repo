# popera CWL Generation Report

## popera

### Tool Description
DNase I hypersensitive site identification

### Metadata
- **Docker Image**: quay.io/biocontainers/popera:1.0.3--py_0
- **Homepage**: https://github.com/forrestzhang/Popera
- **Package**: https://anaconda.org/channels/bioconda/packages/popera/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/popera/overview
- **Total Downloads**: 2.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/forrestzhang/Popera
- **Stars**: N/A
### Original Help Text
```text
Usage: popera <-d datafile> [-n name] [options]
    Example popera -d dh_sample1.bam -n sample1
    

popera DNase I hypersensitive site identification

Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit.
  -d DATAFILE, --data=DATAFILE
                        data file, should be sorted bam format
  -n SAMPLENAME, --name=SAMPLENAME
                        NH sample name default=NH_sample
  -b BW, --bandwidth=BW
                        kernel smooth band width, should >1, default=200
  -t THRESHOLD, --threshold=THRESHOLD
                        Hot spots threshold, default=4.0
  -l MINLENGTH, --minlength=MINLENGTH
                        minimum length of hot spots, default=5
  --threads=NTHREADS    threads number or cpu number, default=4
  --bigwig              whether out put bigwig file, default=False
  -x EXCLUDECHR, --excludechr=EXCLUDECHR
                        Don't count those DHs, example='-x ChrM,ChrC'
```

