# bold-identification CWL Generation Report

## bold-identification_bold_identification

### Tool Description
To identify taxa of given sequences from BOLD (http://www.boldsystems.org/).
Some sequences can fail to get taxon information, which can be caused by
TimeoutException if your network to the BOLD server is bad.
Those sequences will be output in the file '*.TimeoutException.fasta'.

You can:
1) run another searching with the same command directly (but add -c option);
2) lengthen the time to wait for each query (-t option);
3) increase submission times (-r option) for a sequence.

Also, the sequences without BOLD matches will be output in the
file '*.NoBoldMatchError.fasta'

### Metadata
- **Docker Image**: quay.io/biocontainers/bold-identification:0.0.27--py_0
- **Homepage**: https://github.com/linzhi2013/bold_identification
- **Package**: https://anaconda.org/channels/bioconda/packages/bold-identification/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bold-identification/overview
- **Total Downloads**: 5.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/linzhi2013/bold_identification
- **Stars**: N/A
### Original Help Text
```text
usage: bold_identification [-h] -i <str> [-f <str>] -o <str>
                           [-d {COX1,COX1_SPECIES,COX1_SPECIES_PUBLIC,COX1_L640bp,ITS,MATK_RBCL}]
                           [-n <int>] [-r <int>] [-c] [-C] [-q <int>] [-D]
                           [--version]

To identify taxa of given sequences from BOLD (http://www.boldsystems.org/).
Some sequences can fail to get taxon information, which can be caused by
TimeoutException if your network to the BOLD server is bad.
Those sequences will be output in the file '*.TimeoutException.fasta'.

You can:
1) run another searching with the same command directly (but add -c option);
2) lengthen the time to wait for each query (-t option);
3) increase submission times (-r option) for a sequence.

Also, the sequences without BOLD matches will be output in the
file '*.NoBoldMatchError.fasta'

By Guanliang Meng.
See https://github.com/linzhi2013/bold_identification.

Citation:
Yang C, Zheng Y, Tan S, Meng G, et al.
Efficient COI barcoding using high throughput single-end 400 bp sequencing.
https://doi.org/10.1186/s12864-020-07255-w

version: 0.0.27

optional arguments:
  -h, --help            show this help message and exit
  -i <str>              input file name
  -f <str>              input file format [fasta]
  -o <str>              outfile prefix
  -d {COX1,COX1_SPECIES,COX1_SPECIES_PUBLIC,COX1_L640bp,ITS,MATK_RBCL}
                        database to search [COX1]
  -n <int>              how many first top hits will be output. [1]
  -r <int>              Maximum submission time for a sequence, useful for
                        handling TimeOutException. [4]
  -c                    continuous mode, jump over the ones already in "-o"
                        file, will resubmit all the remained. use "-cc" to
                        also jump over the ones in "*.NoBoldMatchError.fasta"
                        file.
  -C                    For chimera check purpose. If set, for each sequence,
                        I will query the BOLD database using the subsequences
                        from 5'- and 3'-ends with a length of '-q <int>' bp,
                        respectively
  -q <int>              The length of subsequences for chimera check [400]
  -D                    debug mode output [False]
  --version             show program's version number and exit
```

