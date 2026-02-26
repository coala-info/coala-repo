# asciigenome CWL Generation Report

## asciigenome_ASCIIGenome

### Tool Description
Genome browser at the command line.

### Metadata
- **Docker Image**: quay.io/biocontainers/asciigenome:1.20.0--hdfd78af_1
- **Homepage**: https://github.com/dariober/ASCIIGenome
- **Package**: https://anaconda.org/channels/bioconda/packages/asciigenome/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/asciigenome/overview
- **Total Downloads**: 67.5K
- **Last updated**: 2026-02-04
- **GitHub**: https://github.com/dariober/ASCIIGenome
- **Stars**: N/A
### Original Help Text
```text
usage: ASCIIGenome [-h] [--batchFile BATCHFILE] [--region REGION]
                   [--fasta FASTA] [--exec EXEC] [--noFormat]
                   [--nonInteractive] [--config CONFIG] [--showMemTime]
                   [--debug {0,1,2}] [--version] [input [input ...]]

DESCRIPTION
Genome browser at the command line.

Full docs at http://asciigenome.readthedocs.io/

positional arguments:
  input                  Input  files  to  be  displayed:  bam,  bed,  gtf,
                         bigwig, bedgraph, etc.

named arguments:
  -h, --help             show this help message and exit
  --batchFile BATCHFILE, -b BATCHFILE
                         Bed or gff file  of  regions  to process in batch.
                         Use - to read from stdin.
                         ASCIIGenome will iterate  through  the  regions in
                         this file
  --region REGION, -r REGION
                         Go to region. Format  1-based as 'chrom:start-end'
                         or 'chrom:start' or 'chrom'.
                         E.g. chr1:1-1000
  --fasta FASTA, -fa FASTA
                         Optional   reference   fasta    file.   If   null,
                         ASCIIGenome will  check  whether  the  input  file
                         list contains a suitable fasta.
  --exec EXEC, -x EXEC   Commands to be executed  at  the  prompt. Either a
                         file with one command per line
                         a single string of  commands,  e.g.  'goto chr1 &&
                         next && seqRegex ACTG'
  --noFormat, -nf        Do  not  format  output   with   non  ascii  chars
                         (colour, bold, etc.) (default: false)
  --nonInteractive, -ni  Non interactive mode: Exit  after having processed
                         cmd line args (default: false)
  --config CONFIG, -c CONFIG
                         Source of  configuration  settings.  It  can  be a
                         local file or a tag matching a
                         built-in     configuration:      'black_on_white',
                         'white_on_black', 'metal'. If null,
                         first try to  read  configuration  from  file '~/.
                         asciigenome_config'. If this
                         file  is  missing  use  a  built-in  setting.  For
                         examples of configuration files
                         see                                https://github.
                         com/dariober/ASCIIGenome/tree/master/src/main/resources/config
                         (default: null)
  --showMemTime, -smt    Show  memory  usage  and  time  spent  to  process
                         input. Typically used for
                         debugging only (default: false)
  --debug {0,1,2}        Set debugging mode.  0:  off;  1:  print exception
                         stack traces; 2: print stack traces
                         and exit. (default: 0)
  --version, -v
```

