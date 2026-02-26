# genefuse CWL Generation Report

## genefuse

### Tool Description
genefuse --read1=string --fusion=string --ref=string [options] ...

### Metadata
- **Docker Image**: quay.io/biocontainers/genefuse:0.8.0--h5ca1c30_4
- **Homepage**: https://github.com/OpenGene/genefuse
- **Package**: https://anaconda.org/channels/bioconda/packages/genefuse/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/genefuse/overview
- **Total Downloads**: 9.6K
- **Last updated**: 2025-07-24
- **GitHub**: https://github.com/OpenGene/genefuse
- **Stars**: N/A
### Original Help Text
```text
option needs value: --html
usage: genefuse --read1=string --fusion=string --ref=string [options] ... 
options:
  -1, --read1                          read1 file name (string)
  -2, --read2                          read2 file name (string [=])
  -f, --fusion                         fusion file name, in CSV format (string)
  -r, --ref                            reference fasta file name (string)
  -u, --unique                         specify the least supporting read number is required to report a fusion, default is 2 (int [=2])
  -h, --html                           file name to store HTML report, default is genefuse.html (string [=genefuse.html])
  -j, --json                           file name to store JSON report, default is genefuse.json (string [=genefuse.json])
  -t, --thread                         worker thread number, default is 4 (int [=4])
  -d, --deletion                       specify the least deletion length of a intra-gene deletion to report, default is 50 (int [=50])
  -D, --output_deletions               long deletions are not output by default, enable this option to output them
  -U, --output_untranslated_fusions    the fusions that cannot be transcribed or translated are not output by default, enable this option to output them
  -?, --help                           print this message
```

