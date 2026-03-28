# emu CWL Generation Report

## emu_abundance

### Tool Description
Calculate species abundance from sequence data.

### Metadata
- **Docker Image**: quay.io/biocontainers/emu:3.6.1--hdfd78af_0
- **Homepage**: https://gitlab.com/treangenlab/emu
- **Package**: https://anaconda.org/channels/bioconda/packages/emu/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/emu/overview
- **Total Downloads**: 46.0K
- **Last updated**: 2026-02-13
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: emu abundance [-h]
                     [--type {map-ont,map-pb,sr,lr:hq,map-hifi,splice:hq}]
                     [--min-abundance MIN_ABUNDANCE] [--db DB] [--N N] [--K K]
                     [--mm2-forward-only] [--output-dir OUTPUT_DIR]
                     [--output-basename OUTPUT_BASENAME] [--keep-files]
                     [--keep-counts] [--keep-read-assignments]
                     [--output-unclassified] [--threads THREADS]
                     [--min-pid MIN_PID] [--min-align-len MIN_ALIGN_LEN]
                     [--max-align-len MAX_ALIGN_LEN]
                     input_file [input_file ...]

positional arguments:
  input_file            filepath to input nt sequence file

options:
  -h, --help            show this help message and exit
  --type, -x {map-ont,map-pb,sr,lr:hq,map-hifi,splice:hq}
                        short-read: sr, Pac-Bio:map-pb, ONT:map-ont, ... [map-
                        ont]
  --min-abundance, -a MIN_ABUNDANCE
                        min species abundance in results [0.0001]
  --db DB               path to emu database containing: names_df.tsv,
                        nodes_df.tsv, species_taxid.fasta, unqiue_taxids.tsv
                        [$EMU_DATABASE_DIR]
  --N, -N N             minimap max number of secondary alignments per read
                        [50]
  --K, -K K             minibatch size for minimap2 mapping [500M]
  --mm2-forward-only    force minimap2 to consider the forward transcript
                        strand only
  --output-dir OUTPUT_DIR
                        output directory name [./results]
  --output-basename OUTPUT_BASENAME
                        basename for all emu output files [{input_file}]
  --keep-files          keep working files in output-dir
  --keep-counts         include estimated read counts in output
  --keep-read-assignments
                        output file of read assignment distribution
  --output-unclassified
                        output unclassified sequences
  --threads THREADS     threads utilized by minimap [3]
  --min-pid MIN_PID     Minimum percent identity (PID) based on NM tag [0%]
  --min-align-len MIN_ALIGN_LEN
                        Minimum aligned query length (excludes soft/hard
                        clipping [0]
  --max-align-len MAX_ALIGN_LEN
                        Maximum aligned query length (excludes soft/hard
                        clipping) [2000]
```


## emu_build-database

### Tool Description
Builds a custom database for EMU.

### Metadata
- **Docker Image**: quay.io/biocontainers/emu:3.6.1--hdfd78af_0
- **Homepage**: https://gitlab.com/treangenlab/emu
- **Package**: https://anaconda.org/channels/bioconda/packages/emu/overview
- **Validation**: PASS

### Original Help Text
```text
usage: emu build-database [-h] --sequences SEQUENCES --seq2tax SEQ2TAX
                          (--ncbi-taxonomy NCBI_TAXONOMY |
                          --taxonomy-list TAXONOMY_LIST)
                          db_name

positional arguments:
  db_name               custom database name

options:
  -h, --help            show this help message and exit
  --sequences SEQUENCES
                        path to fasta of database sequences
  --seq2tax SEQ2TAX     path to tsv mapping species tax id to fasta sequence
                        headers
  --ncbi-taxonomy NCBI_TAXONOMY
                        path to directory containing both a names.dmp and
                        nodes.dmp file
  --taxonomy-list TAXONOMY_LIST
                        path to .tsv file mapping full lineage to
                        corresponding taxid
```


## emu_collapse-taxonomy

### Tool Description
Collapse taxonomic ranks in emu output.

### Metadata
- **Docker Image**: quay.io/biocontainers/emu:3.6.1--hdfd78af_0
- **Homepage**: https://gitlab.com/treangenlab/emu
- **Package**: https://anaconda.org/channels/bioconda/packages/emu/overview
- **Validation**: PASS

### Original Help Text
```text
usage: emu collapse-taxonomy [-h] input_path rank

positional arguments:
  input_path  emu output filepath
  rank        collapsed taxonomic rank

options:
  -h, --help  show this help message and exit
```


## emu_combine-outputs

### Tool Description
Combines Emu output files into a single table.

### Metadata
- **Docker Image**: quay.io/biocontainers/emu:3.6.1--hdfd78af_0
- **Homepage**: https://gitlab.com/treangenlab/emu
- **Package**: https://anaconda.org/channels/bioconda/packages/emu/overview
- **Validation**: PASS

### Original Help Text
```text
usage: emu combine-outputs [-h] [--split-tables] [--counts] dir_path rank

positional arguments:
  dir_path        path to directory containing Emu output files
  rank            taxonomic rank to include in combined table

options:
  -h, --help      show this help message and exit
  --split-tables  two output tables:abundances and taxonomy lineages
  --counts        counts rather than abundances in output table
```


## Metadata
- **Skill**: generated
