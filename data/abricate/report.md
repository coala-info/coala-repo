# abricate CWL Generation Report

## abricate

### Tool Description
Find and collate amplicons in assembled contigs

### Metadata
- **Docker Image**: quay.io/biocontainers/abricate:1.2.0--h05cac1d_0
- **Homepage**: https://github.com/tseemann/abricate
- **Package**: https://anaconda.org/channels/bioconda/packages/abricate/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/abricate/overview
- **Total Downloads**: 131.6K
- **Last updated**: 2025-12-05
- **GitHub**: https://github.com/tseemann/abricate
- **Stars**: 480
### Original Help Text
```text
SYNOPSIS
  Find and collate amplicons in assembled contigs
AUTHOR
  Torsten Seemann (@torstenseemann)
USAGE
  % abricate --list
  % abricate [options] <contigs.{fasta,gbk,embl}[.gz] ...> > out.tab
  % abricate [options] --fofn fileOfFilenames.txt > out.tab
  % abricate --summary <out1.tab> <out2.tab> <out3.tab> ... > summary.tab
GENERAL
  --help          This help.
  --debug         Verbose debug output.
  --quiet         Quiet mode, no stderr output.
  --version       Print version and exit.
  --check         Check dependencies are installed.
  --threads [N]   Use this many BLAST+ threads [1].
  --fofn [X]      Run on files listed in this file [].
DATABASES
  --setupdb       Format all the BLAST databases.
  --list          List included databases.
  --datadir [X]   Databases folder [/usr/local/db].
  --db [X]        Database to use [ncbi].
OUTPUT
  --noheader      Suppress column header row.
  --csv           Output CSV instead of TSV.
  --nopath        Strip filename paths from FILE column.
FILTERING
  --minid [n.n]   Minimum DNA %identity [80].
  --mincov [n.n]  Minimum DNA %coverage [80].
MODE
  --summary       Summarize multiple reports into a table.
  --identity      Use %IDENTITY instead of %COVERAGE in summary table.
DOCUMENTATION
  https://github.com/tseemann/abricate
```


## Metadata
- **Skill**: generated

## abricate_abricate-get_db

### Tool Description
Download databases for abricate to use

### Metadata
- **Docker Image**: quay.io/biocontainers/abricate:1.2.0--h05cac1d_0
- **Homepage**: https://github.com/tseemann/abricate
- **Package**: https://anaconda.org/channels/bioconda/packages/abricate/overview
- **Validation**: PASS
### Original Help Text
```text
SYNOPIS
  Download databases for abricate to use
USAGE
  abricate-get_db [options] --db DATABASE
OPTIONS
  --help          This help.
  --debug!        Verbose debug output (default '0').
  --dbdir=s       Parent folder (default '/usr/local/db').
  --db=s          Choices: argannot bacmet2 card ecoh ecoli_vf megares ncbi plasmidfinder resfinder vfdb victors (default '').
  --force!        Force download even if exists (default '0').
```

