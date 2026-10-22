# slimm CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| slimm | PASS | Real nf-core SARS-CoV-2 reads aligned with hisat2: raw table shows 197 reads (100%) on MT192765 as expected; note the profile shows taxid 0* for this 'no rank' taxon, while a Haemophilus species gave taxid 727. |
| slimm_build | PASS | New CWL; built a .sldb from the nf-core SARS-CoV-2 + Haemophilus influenzae genomes with their real accession2taxid and taxdump files; the database holds both accessions and species names. |

## slimm

### Tool Description
Species Level Identification of Microbes from Metagenomes

### Metadata
- **Docker Image**: quay.io/biocontainers/slimm:0.3.4--hd6d6fdc_6
- **Homepage**: https://github.com/seqan/slimm/blob/master/README.md
- **Package**: https://anaconda.org/channels/bioconda/packages/slimm/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/slimm/overview
- **Total Downloads**: 6.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/seqan/slimm
- **Stars**: N/A
### Original Help Text
```text
slimm - Species Level Identification of Microbes from Metagenomes
=================================================================

SYNOPSIS
    slimm [OPTIONS] "DB" "IN"

DESCRIPTION
    SLIMM Species Level Identification of Microbes from Metagenomes

    See  http://www.seqan.de/projects/slimm  for more information.

    (c) Copyright 2014-2017 by Temesgen H. Dadi.

REQUIRED ARGUMENTS
    DB INPUT_FILE
          Valid filetype is: .sldb.
    IN INPUT_PREFIX

OPTIONS
    -h, --help
          Display the help message.
    --version-check BOOL
          Turn this option off to disable version update notifications of the
          application. One of 1, ON, TRUE, T, YES, 0, OFF, FALSE, F, and NO.
          Default: 1.
    --version
          Display version information.
    -o, --output-prefix OUTPUT_PREFIX
          output path prefix.
    -w, --bin-width INTEGER
          Set the width of a single bin in neuclotides. Default: 0.
    -mr, --min-reads INTEGER
          Minimum number of matching reads to consider a reference present.
          Default: 0.
    -r, --rank STRING
          The taxonomic rank of identification One of strains, species, genus,
          family, order, class, phylum, and superkingdom. Default: species.
    -cc, --cov-cut-off DOUBLE
          the quantile of coverages to use as a cutoff smaller value means
          bigger threshold. In range [0.0..1.0]. Default: 0.95.
    -ac, --abundance-cut-off DOUBLE
          do not report abundances below this value In range [0.0..10.0].
          Default: 0.01.
    -d, --directory
          Input is a directory.
    -ro, --raw-output
          Output raw reference statstics
    -co, --coverage-output
          Output raw coverage statstics
    -v, --verbose
          Enable verbose output.

EXAMPLES
    slimm -o slimm_reports/ slimm_db_5K.sldb example.bam
          get taxonomic profile from "example.bam" and write it to a tsv file
          under "slimm_reports/" directory.
    slimm -d -o slimm_reports/ slimm_db_5K.sldb example-dir/
          get taxonomic profiles from individual SAM/BAM files located under
          "example-dir/" and write them to tsv files under "slimm_reports/"
          directory with their corsponding file names.

VERSION
    Last update: Dec 10 2024
    slimm version: 0.3.4
    SeqAn version: 2.4.0
```

## slimm_build

### Tool Description
Build a reduced taxonomic database (.sldb) from a multi-fasta file using accession numbers and the NCBI taxonomy.

### Metadata
- **Docker Image**: quay.io/biocontainers/slimm:0.3.4--hd6d6fdc_6
- **Homepage**: https://github.com/seqan/slimm/blob/master/README.md
- **Package**: https://anaconda.org/channels/bioconda/packages/slimm/overview
- **Validation**: PASS

### Original Help Text
```text
[help] slimm_build: ok via slimm_build --help (--help=ok, -h=ok, -help=ok, (no args)=ok)
slimm-build - gets a reduced taxonomic information given a multi-fasta file using accession numbers
===================================================================================================

SYNOPSIS
    slimm-build -nm "NAMES.dmp" -nd "NODES.dmp" -o "SLIMM.sldb" [OPTIONS]
    "FASTA" "ACCESSION2TAXAID" [ACCESSION2TAXAID_2 ...]

DESCRIPTION
    SLIMM Species Level Identification of Microbes from Metagenomes

    See  http://www.seqan.de/projects/slimm  for more information.

    (c) Copyright 2014-2017 by Temesgen H. Dadi.

REQUIRED ARGUMENTS
    FASTA_FILE INPUT_FILE
          A multi-fasta file used as a reference for mapping Valid filetypes
          are: .sam[.*], .raw[.*], .gbk[.*], .frn[.*], .fq[.*], .fna[.*],
          .ffn[.*], .fastq[.*], .fasta[.*], .faa[.*], .fa[.*], .embl[.*], and
          .bam, where * is any of the following extensions: gz, bz2, and bgzf
          for transparent (de)compression.
    ACCESSION2TAXAID_MAP_FILES List of INPUT_FILE's
          one ore more accession to taxa id mapping files dowloaded from ncbi
          (separated by space.)

OPTIONS
    -h, --help
          Display the help message.
    --version-check BOOL
          Turn this option off to disable version update notifications of the
          application. One of 1, ON, TRUE, T, YES, 0, OFF, FALSE, F, and NO.
          Default: 1.
    --version
          Display version information.
    -o, --output-file OUTPUT_FILE
          The path to the output file (default slimm_db.sldb) Valid filetype
          is: .sldb. Default: slimm_db.sldb.
    -nm, --names INPUT_FILE
          NCBI's names.dmp file which contains the mapping of taxaid to name
    -nd, --nodes INPUT_FILE
          NCBI's nodes.dmp file which contains the taxonomic tree.
    -b, --batch INTEGER
          maximum number of mapping to load to memory. (default=1000000)
          Default: 1000000.
    -v, --verbose
          Enable verbose output.

VERSION
    Last update: Dec 10 2024
    slimm-build version: 0.3.4
    SeqAn version: 2.4.0
```

