# sidr CWL Generation Report

## sidr_default

### Tool Description
Runs the default analysis using raw preassembly data.

### Metadata
- **Docker Image**: quay.io/biocontainers/sidr:0.0.2a2--pyh3252c3a_0
- **Homepage**: https://github.com/damurdock/SIDR
- **Package**: https://anaconda.org/channels/bioconda/packages/sidr/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sidr/overview
- **Total Downloads**: 2.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/damurdock/SIDR
- **Stars**: N/A
### Original Help Text
```text
Usage: sidr default [OPTIONS]

  Runs the default analysis using raw preassembly data.

Options:
  -b, --bam PATH           Alignment of reads to preliminary assembly, in BAM
                           format.

  -f, --fasta PATH         Preliminary assembly, in FASTA format.
  -r, --blastresults PATH  Classification of preliminary assembly from BLAST
                           (or similar tools).

  -d, --taxdump PATH       Location of the NCBI Taxonomy dump. Default is
                           $BLASTDB.

  -o, --output PATH
  -k, --tokeep PATH        Location to save the contigs identified as the
                           target organism(optional).

  -x, --toremove PATH      Location to save the contigs identified as not
                           belonging to the target organism (optional).

  --binary                 Use binary target/nontarget classification.
  -t, --target TEXT        The identity of the target organism at the chosen
                           classification level. It is recommended to use the
                           organism's phylum.

  -l, --level TEXT         The classification level to use when constructing
                           the model. Default is 'phylum'.

  -h, --help               Show this message and exit.
```


## sidr_runfile

### Tool Description
Runs a custom analysis using pre-computed data from BBMap or other
sources.

Input data will be read for all variables which will be used to construct
a Decision Tree model.

### Metadata
- **Docker Image**: quay.io/biocontainers/sidr:0.0.2a2--pyh3252c3a_0
- **Homepage**: https://github.com/damurdock/SIDR
- **Package**: https://anaconda.org/channels/bioconda/packages/sidr/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sidr runfile [OPTIONS]

  Runs a custom analysis using pre-computed data from BBMap or other
  sources.

  Input data will be read for all variables which will be used to construct
  a Decision Tree model.

Options:
  -i, --infile PATH    Comma-delimited input file.
  -d, --taxdump PATH   Location of the NCBI Taxonomy dump. Default is
                       $BLASTDB.

  -o, --output PATH
  -k, --tokeep PATH    Location to save the contigs identified as the target
                       organism(optional).

  -x, --toremove PATH  Location to save the contigs identified as not
                       belonging to the target organism (optional).

  -t, --target TEXT    The identity of the target organism at the chosen
                       classification level. It is recommended to use the
                       organism's phylum.

  --binary             Use binary target/nontarget classification.
  -l, --level TEXT     The classification level to use when constructing the
                       model. Default is 'phylum'.

  -h, --help           Show this message and exit.
```

