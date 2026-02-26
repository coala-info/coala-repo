# keggcharter CWL Generation Report

## keggcharter

### Tool Description
KEGGCharter - A tool for representing genomic potential and transcriptomic expression into KEGG pathways

### Metadata
- **Docker Image**: quay.io/biocontainers/keggcharter:1.1.2--hdfd78af_0
- **Homepage**: https://github.com/iquasere/KEGGCharter
- **Package**: https://anaconda.org/channels/bioconda/packages/keggcharter/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/keggcharter/overview
- **Total Downloads**: 55.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/iquasere/KEGGCharter
- **Stars**: N/A
### Original Help Text
```text
usage: keggcharter [-h] [-f FILE] [-o OUTPUT] [-rd RESOURCES_DIRECTORY]
                   [-mm METABOLIC_MAPS] [-qcol QUANTIFICATION_COLUMNS] [-dq]
                   [-tls TAXA_LIST] [-not NUMBER_OF_TAXA] [-keggc KEGG_COLUMN]
                   [-koc KO_COLUMN] [-ecc EC_COLUMN] [-cogc COG_COLUMN]
                   [-tc TAXA_COLUMN] [-iq] [-it INPUT_TAXONOMY] [-t THREADS]
                   [--step STEP] [--map-all] [--include-missing-genomes]
                   [--differential-colormap DIFFERENTIAL_COLORMAP] [--resume]
                   [-v] [--show-available-maps]

KEGGCharter - A tool for representing genomic potential and transcriptomic
expression into KEGG pathways

options:
  -h, --help            show this help message and exit
  -f FILE, --file FILE  TSV or EXCEL table with information to chart
  -o OUTPUT, --output OUTPUT
                        Output directory
  -rd RESOURCES_DIRECTORY, --resources-directory RESOURCES_DIRECTORY
                        Directory for storing KGML and CSV files.
  -mm METABOLIC_MAPS, --metabolic-maps METABOLIC_MAPS
                        IDs of metabolic maps to output
  -qcol QUANTIFICATION_COLUMNS, --quantification-columns QUANTIFICATION_COLUMNS
                        Names of columns with quantification
  -dq, --distribute-quantification
                        Quantification of each enzyme is divided by all KOs
                        identified for it.
  -tls TAXA_LIST, --taxa-list TAXA_LIST
                        List of taxa to represent in genomic potential charts
                        (comma separated)
  -not NUMBER_OF_TAXA, --number-of-taxa NUMBER_OF_TAXA
                        Number of taxa to represent in genomic potential
                        charts (comma separated)
  -keggc KEGG_COLUMN, --kegg-column KEGG_COLUMN
                        Column with KEGG IDs.
  -koc KO_COLUMN, --ko-column KO_COLUMN
                        Column with KOs.
  -ecc EC_COLUMN, --ec-column EC_COLUMN
                        Column with EC numbers.
  -cogc COG_COLUMN, --cog-column COG_COLUMN
                        Column with COG IDs.
  -tc TAXA_COLUMN, --taxa-column TAXA_COLUMN
                        Column with the taxa designations to represent with
                        KEGGCharter. NOTE - for valid taxonomies, check:
                        https://www.genome.jp/kegg/catalog/org_list.html
  -iq, --input-quantification
                        If input table has no quantification, will create a
                        mock quantification column
  -it INPUT_TAXONOMY, --input-taxonomy INPUT_TAXONOMY
                        If no taxonomy column exists and there is only one
                        taxon in question.
  -t THREADS, --threads THREADS
                        Number of threads to run KEGGCharter with [max
                        available]
  --step STEP           Number of IDs to submit per request through the KEGG
                        API [40]
  --map-all             Ignore KEGG taxonomic information. All functions for
                        all KOs will be represented, even if they aren't
                        attributed by KEGG to the specific species.
  --include-missing-genomes
                        Map the functions for KOs identified for organisms not
                        present in KEGG Genomes.
  --differential-colormap DIFFERENTIAL_COLORMAP
                        Matplotlib color map to use for differential maps
                        [viridis]
  --resume              If data inputed has already been analyzed by
                        KEGGCharter.
  -v, --version         show program's version number and exit

Special functions:
  --show-available-maps
                        Outputs KEGG maps IDs and descriptions to the console
                        (so you may pick the ones you want!)

Input file must be specified.
```

