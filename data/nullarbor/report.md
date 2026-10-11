# nullarbor CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| nullarbor_nullarbor.pl | Not completed | pipeline, skipped |

## nullarbor_nullarbor.pl

### Tool Description
Reads to reports for public health microbiology

### Metadata
- **Docker Image**: quay.io/biocontainers/nullarbor:2.0.20191013--0
- **Homepage**: https://github.com/tseemann/nullarbor
- **Package**: https://anaconda.org/channels/bioconda/packages/nullarbor/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/nullarbor/overview
- **Total Downloads**: 15.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/tseemann/nullarbor
- **Stars**: N/A
### Original Help Text
```text
NAME
  nullarbor.pl 2.0.20191013
SYNOPSIS
  Reads to reports for public health microbiology
AUTHOR
  Torsten Seemann
USAGE
  nullarbor.pl [options] --name NAME --ref REF.FA/GBK --input INPUT.TAB --outdir DIR
REQUIRED
  --name STR             Job name
  --ref FILE             Reference file in FASTA or GBK format
  --input FILE           Input TSV file with format:  | Isolate_ID | R1.fq.gz | R2.fq.gz |
  --outdir DIR           Output folder
  --mode MODE            Run mode: [all] preview
OPTIONS
  --cpus INT             Maximum number of CPUs to use in total (1)
  --force                Overwrite --outdir (useful for adding samples to existing analysis)
  --quiet                No screen output
  --verbose              More screen output
  --version              Print version and exit
  --check                Check dependencies and exit
  --run                  Immediately launch Makefile
ADVANCED OPTIONS
  --conf FILE            Config file (/usr/local/bin/../conf/nullarbor.conf)
  --gcode INT            Genetic code for prokka (11)
  --trim                 Trim reads of adaptors (0)
  --mlst SCHEME          Force this MLST scheme (AUTO)
  --minctg LEN_BP        Minimum contig length for Prokka and Roary
  --prefill              Use precomputed data as per --conf file. Use --no-prefill to override.
  --link-cmd 'CMD'       Command to symlink/copy FASTQ files into --outdir ('ln -s -f')
  --snippy_opt STR       Options to pass to snippy eg. '--mincov 10 --ram 32' ()
  --roary_opt STR        Options to pass to roary eg. '-iv 1.75 -s -cd 97' ()
  --mask BED | auto      Mask core SNPS in these regions or 'auto' ()
  --auto                 Be lazy and guess --name,--ref,--input,--outdir,--mask
PLUGINS
  --assembler NAME       Assembler to use: megahit shovill skesa skesa_fast spades (skesa)
  --assembler-opt STR    Extra assembler options to pass ()
  --treebuilder NAME     Tree-builder to use: fasttree iqtree iqtree_fast iqtree_slow (iqtree_fast)
  --treebuilder-opt STR  Extra tree-builder options to pass ()
  --taxoner NAME         Species ID tool to use: centrifuge kraken kraken2 (kraken)
  --taxoner-opt STR      Extra species ID builder options to pass ()
  --annotator NAME       Genome annotator to use: prokka_fast (prokka_fast)
  --annotator-opt STR    Extra annotator options to pass ()
DOCUMENTATION
  https://github.com/tseemann/nullarbor
```


## Metadata
- **Skill**: generated
