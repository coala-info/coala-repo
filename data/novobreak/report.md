# novobreak CWL Generation Report

## novobreak_run_novoBreak.sh

### Tool Description
Runs the novoBreak pipeline.

### Metadata
- **Docker Image**: quay.io/biocontainers/novobreak:1.1.3rc--h7132678_8
- **Homepage**: https://github.com/czc/nb_distribution
- **Package**: https://anaconda.org/channels/bioconda/packages/novobreak/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/novobreak/overview
- **Total Downloads**: 8.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/czc/nb_distribution
- **Stars**: N/A
### Original Help Text
```text
/usr/local/bin/run_novoBreak.sh <novoBreak_exe_dir> <ref> <tumor_bam> <normal_bam> <n_CPUs:INT> [outputdir:-PWD]
```


## novobreak_novoBreak

### Tool Description
a tool for discovering somatic sv breakpoints

### Metadata
- **Docker Image**: quay.io/biocontainers/novobreak:1.1.3rc--h7132678_8
- **Homepage**: https://github.com/czc/nb_distribution
- **Package**: https://anaconda.org/channels/bioconda/packages/novobreak/overview
- **Validation**: PASS

### Original Help Text
```text
novoBreak - a tool for discovering somatic sv breakpoints
Auther: Zechen Chong <zchong@mdanderson.org> 
Version: 1.1 (r20151007)
Usage:
  novoBreak -i <tumorbam> -c <normalbam> -r <reference> -o <output.kmer> [options]
Options:
  -h             This help
  -i <string>    Tumor bam file
  -c <string>    Normal bam file
  -r <string>    Reference file in fasta format
  -k <int>       Kmer size, <=31 [31]
  -o <string>    Output kmer
  -g <int>       Output germline events [0]
  -m <int>       Minimum kmer count regarded as novo kmers [3]
```


## Metadata
- **Skill**: generated
