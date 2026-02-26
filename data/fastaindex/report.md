# fastaindex CWL Generation Report

## fastaindex_FastaIndex

### Tool Description
Create an index for a FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastaindex:0.11c--py36_0
- **Homepage**: https://github.com/lpryszcz/FastaIndex
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/fastaindex/overview
- **Total Downloads**: 7.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/lpryszcz/FastaIndex
- **Stars**: N/A
### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/FastaIndex", line 11, in <module>
    load_entry_point('FastaIndex==0.11rc7', 'console_scripts', 'FastaIndex')()
  File "/usr/local/lib/python3.6/site-packages/FastaIndex-0.11rc7-py3.6.egg/FastaIndex.py", line 358, in main
NameError: name 'file' is not defined
```


## fastaindex_fasta_stats

### Tool Description
Report FASTA statistics. Support gzipped files.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastaindex:0.11c--py36_0
- **Homepage**: https://github.com/lpryszcz/FastaIndex
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: fasta_stats [-h] [--version] [-v] [-i FASTA [FASTA ...]] [-o OUT]

Report FASTA statistics. Support gzipped files.

Statistics are stored as .fai formatted file (http://www.htslib.org/doc/faidx.html),
with 4 extended columns, storing counts for A, C, G & T for each sequence. 

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -v, --verbose         verbose
  -i FASTA [FASTA ...], --fasta FASTA [FASTA ...]
                        FASTA file(s)
  -o OUT, --out OUT     output stream	 [stdout]

Author: l.p.pryszcz+git@gmail.com
Mizerow/Bratislava, 26/08/2014
```

