# metaprokka CWL Generation Report

## metaprokka

### Tool Description
rapid bacterial genome annotation, adapted for large datasets

### Metadata
- **Docker Image**: quay.io/biocontainers/metaprokka:1.15.0--pl5321hdfd78af_0
- **Homepage**: https://github.com/telatin/metaprokka
- **Package**: https://anaconda.org/channels/bioconda/packages/metaprokka/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/metaprokka/overview
- **Total Downloads**: 5.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/telatin/metaprokka
- **Stars**: N/A
### Original Help Text
```text
Option h is ambiguous (help, hmms)
Name:
  Metaprokka 1.15.0
Synopsis:
  rapid bacterial genome annotation, adapted for large datasets
Usage:
  metaprokka [options] <contigs.fasta>
General:
  --help             This help
  --version          Print version and exit
  --citation         Print citation for referencing Prokka
  --quiet            No screen output (default OFF)
  --debug            Debug mode: keep all temporary files (default OFF)
Setup:
  --dbdir [X]        Prokka database root folders (default '/usr/local/db')
  --listdb           List all configured databases
Outputs:
  --outdir [X]       Output folder [auto] (default '')
  --force            Force overwriting existing output folder (default OFF)
  --prefix [X]       Filename output prefix [auto] (default '')
  --locustag [X]     Locus tag prefix [auto] (default '')
  --increment [N]    Locus tag counter increment (default '1')
  --gffver [N]       GFF version (default '3')
Annotations:
  --prodigaltf [X]   Prodigal training file (default '')
  --proteins [X]     FASTA or GBK file to use as 1st priority (default '')
  --hmms [X]         Trusted HMM to first annotate from (default '')
  --rawproduct       Do not clean up /product annotation (default OFF)
  --cdsrnaolap       Allow [tr]RNA to overlap CDS (default OFF)
Matching:
  --evalue [n.n]     Similarity e-value cut-off (default '1e-09')
  --coverage [n.n]   Minimum coverage on query protein (default '80')
Computation:
  --cpus [N]         Number of CPUs to use [0=all] (default '8')
  --fast             Fast mode - only use basic BLASTP databases (default OFF)
  --noanno           For CDS just set /product="unannotated protein" (default OFF)
  --mincontiglen [N] Minimum contig size [NCBI needs 200] (default '1')
  --rfam             Enable searching for ncRNAs with Infernal+Rfam (SLOW!) (default '0')
  --norrna           Don't run rRNA search (default OFF)
  --dotrna           Run tRNA search (default OFF)
  --rnammer          Prefer RNAmmer over Barrnap for rRNA prediction (default OFF)
  --dotbl2asn        Run tbl2asn (default OFF)
```

