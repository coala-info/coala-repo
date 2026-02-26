# hpcblast CWL Generation Report

## hpcblast_hpc-blast

### Tool Description
hpc-blast <OPTIONS> <blast command>

### Metadata
- **Docker Image**: quay.io/biocontainers/hpcblast:1.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/yodeng/hpc-blast
- **Package**: https://anaconda.org/channels/bioconda/packages/hpcblast/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/hpcblast/overview
- **Total Downloads**: 1.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/yodeng/hpc-blast
- **Stars**: N/A
### Original Help Text
```text
usage: hpc-blast [--split <int> | --size <int>] [--num <int>]
                 [--tempdir <dir>] [--log <file>] [--local] [--version] [-h]
                 [--queue [<str> ...]] [--cpu <int>] [--memory <int>]
                 <blast command>

hpc-blast <OPTIONS> <blast command>

positional arguments:
  <blast command>      blast command, required

options:
  --split <int>        split query into num of chunks, 10 by default
  --size <int>         split query into multi chunks with N sequences
  --num <int>          max number of chunks run parallelly, all chunks by
                       default
  --tempdir <dir>      hpc blast temp directory
  --log <file>         append hpc-blast log info to file, sys.stdout by
                       default
  --local              run blast in localhost instead of sge
  --version            show program's version number and exit
  -h, --help           show this help message and exit

sge arguments:
  --queue [<str> ...]  sge queue, multi-queue can be sepreated by whitespace,
                       all access queue by default
  --cpu <int>          cpu usage for sge, 1 by default, max(--cpu,
                       -num_threads) will be used
  --memory <int>       memory (GB) usage for sge, 1 by default
```

