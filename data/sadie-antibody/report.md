# sadie-antibody CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| sadie-antibody_sadie_airr | Failed | image problem: bundled igblastn cannot start (libbz2.so.1 missing in the image) |
| sadie-antibody_sadie_make-all | Failed | tool bug: crashes with UnboundLocalError on Path before doing any work |
| sadie-antibody_sadie_reference_make | Not completed | needs the remote server g3.jordanrwillis.com, which does not resolve |
| sadie-antibody_sadie_renumbering | Not completed | needs the remote server g3.jordanrwillis.com, which does not resolve |

## sadie-antibody_sadie_airr

### Tool Description
Run the AIRR annotation pipeline from the command line on a single file or a directory of abi files.

  if you give a directory of abi files, it will combine all the records into a
  single file and annotate that.

  if you do not provide an output, the default is airr .tsv file

### Metadata
- **Docker Image**: quay.io/biocontainers/sadie-antibody:2.0.0--pyhdfd78af_0
- **Homepage**: https://sadie.jordanrwillis.com
- **Package**: https://anaconda.org/channels/bioconda/packages/sadie-antibody/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sadie airr [OPTIONS] INPUT_PATH [OUTPUT_PATH]

  Run the AIRR annotation pipeline from the command line on a single file or a
  directory of abi files.

  if you give a directory of abi files, it will combine all the records into a
  single file and annotate that.

  if you do not provide an output, the default is airr .tsv file

Options:
  -n, --name [se09|rat|human|macaque|dog|rabbit|clk|mouse]
                                  Species to annotate
  --skip-igl                      Skip the igl assignment
  --skip-mutation                 Skip the somewhat time instansive mutational
                                  analysis
  --help                          Show this message and exit.
```


## sadie-antibody_sadie_renumbering

### Tool Description
Renumber antibody sequences based on specified schemes and regions.

### Metadata
- **Docker Image**: quay.io/biocontainers/sadie-antibody:2.0.0--pyhdfd78af_0
- **Homepage**: https://sadie.jordanrwillis.com
- **Package**: https://anaconda.org/channels/bioconda/packages/sadie-antibody/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sadie renumbering [OPTIONS]

Options:
  -v, --verbose                   Vebosity level, ex. -vvvvv for debug level
                                  logging
  -q, --query PATH                The input file can be compressed or
                                  uncompressed file of fasta
  -i, --seq TEXT                  The input seq
  -s, --scheme [imgt|kabat|chothia]
                                  The numbering scheme to use.  [default:
                                  imgt]
  -r, --region [imgt|kabat|chothia|abm|contact|scdr]
                                  The framework and cdr defition to use
                                  [default: imgt]
  -a, --allowed-species TEXT      A comma seperated list of species to align
                                  against  [default: human,mouse,rat,rabbit,rh
                                  esus,pig,alpaca,dog,cat]
  -c, --allowed-chains TEXT       A comma seperated list of species to align
                                  against  [default: H,K,L,A,B,G,D]
  -o, --out PATH                  The output file, type is inferred from
                                  extensions
  -z, --compress [gz|bz2]         opitonal file compression on output
  -f, --file-format [json|csv|feather]
                                  output file type format
  --help                          Show this message and exit.
```


## sadie-antibody_sadie_make-all

### Tool Description
Comprehensive database generation for SADIE AIRR analysis

### Metadata
- **Docker Image**: quay.io/biocontainers/sadie-antibody:2.0.0--pyhdfd78af_0
- **Homepage**: https://sadie.jordanrwillis.com
- **Package**: https://anaconda.org/channels/bioconda/packages/sadie-antibody/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sadie make-all [OPTIONS]

  Comprehensive database generation for SADIE AIRR analysis

  This command performs all necessary steps to set up a complete AIRR analysis
  environment:

  1. Generates or updates reference.yml configuration (if needed) 2. Downloads
  IMGT germline sequences (if needed) 3. Generates IgBLAST reference databases
  4. Creates auxiliary files for IgBLAST 5. Generates internal annotation
  files (ndm.imgt) 6. Optionally regenerates CATNAP and IGL references 7.
  Creates reference index files

  The process creates the following directory structure:

  outpath/
  ├── reference.yml            # Reference configuration (if generated)
  ├── Ig/
  │   ├── blastdb/         # BLAST databases
  │   │   ├── human/
  │   │   ├── mouse/
  │   │   └── ...
  │   └── internal_data/   # Internal annotation files
  │       ├── human/
  │       ├── mouse/
  │       └── ...
  ├── aux_db/              # Auxiliary files
  │   └── imgt/
  │       ├── human_gl.aux
  │       ├── mouse_gl.aux
  │       └── ...
  └── .references_dataframe.csv.gz  # Reference index

Options:
  -o, --outpath DIRECTORY  Output path for all generated files
  -r, --reference PATH     Path to reference.yml file  [default:
                           /usr/local/lib/python3.13/site-
                           packages/sadie/reference/data/reference.yml]
  -s, --species TEXT       Comma-separated list of species to build databases
                           for (default: all)  [default: all]
  --regenerate-catnap      Regenerate CATNAP references from FASTA files
  --regenerate-igl         Regenerate IGL references from FASTA files
  --generate-reference     Generate reference.yml file interactively or
                           regenerate if missing
  --skip-blast             Skip BLAST database generation
  --skip-aux               Skip auxiliary file generation
  --skip-internal          Skip internal annotation file generation
  -v, --verbose            Vebosity level, ex. -vvvvv for debug level logging
  --help                   Show this message and exit.
```

## sadie-antibody_sadie_reference_make

### Tool Description
make the igblast reference files

### Metadata
- **Docker Image**: quay.io/biocontainers/sadie-antibody:2.0.0--pyhdfd78af_0
- **Homepage**: https://sadie.jordanrwillis.com
- **Package**: https://anaconda.org/channels/bioconda/packages/sadie-antibody/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sadie reference make [OPTIONS]

  make the igblast reference files

  This script will make the imgt reference files used by igblast or airr,
  including internal data, the blast the blast database, and the auxillary
  files. It uses the reference.yml to configure select genes and species. If
  you update the reference.yml file, run this again.

Options:
  -v, --verbose         Vebosity level, ex. -vvvvv for debug level logging
  -o, --outpath PATH    Output path to generate blast_db, internal_data and
                        auxillary files  [default:
                        /usr/local/lib/python3.13/site-
                        packages/sadie/airr/data/germlines]
  -d, --reference PATH  Path to reference.yml  [default:
                        /usr/local/lib/python3.13/site-
                        packages/sadie/reference/data/reference.yml]
  --help                Show this message and exit.
```

## Metadata
- **Skill**: generated
