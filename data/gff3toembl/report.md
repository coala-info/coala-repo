# gff3toembl CWL Generation Report

## gff3toembl_gff3_to_embl

### Tool Description
Converts prokaryote GFF3 annotations to EMBL for ENA submission. Cite http://dx.doi.org/10.21105/joss.00080

### Metadata
- **Docker Image**: quay.io/biocontainers/gff3toembl:1.1.4--pyh864c0ab_2
- **Homepage**: https://github.com/sanger-pathogens/gff3toembl/
- **Package**: https://anaconda.org/channels/bioconda/packages/gff3toembl/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gff3toembl/overview
- **Total Downloads**: 7.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/sanger-pathogens/gff3toembl
- **Stars**: N/A
### Original Help Text
```text
usage: gff3_to_embl [-h] [--authors AUTHORS] [--title TITLE]
                    [--publication PUBLICATION] [--genome_type GENOME_TYPE]
                    [--classification CLASSIFICATION]
                    [--output_filename OUTPUT_FILENAME]
                    [--locus_tag LOCUS_TAG]
                    [--translation_table TRANSLATION_TABLE]
                    [--chromosome_list CHROMOSOME_LIST] [--version]
                    organism taxonid project_accession description file

Converts prokaryote GFF3 annotations to EMBL for ENA submission. Cite
http://dx.doi.org/10.21105/joss.00080

positional arguments:
  organism              Organism
  taxonid               Taxon id
  project_accession     Accession number for the project
  description           Genus species subspecies strain of organism
  file                  GFF3 filename

optional arguments:
  -h, --help            show this help message and exit
  --authors AUTHORS, -i AUTHORS
                        Authors (in the EMBL RA line style)
  --title TITLE, -m TITLE
                        Title of paper (in the EMBL RT line style)
  --publication PUBLICATION, -p PUBLICATION
                        Publication or journal name (in the EMBL RL line
                        style)
  --genome_type GENOME_TYPE, -g GENOME_TYPE
                        Genome type (linear/circular)
  --classification CLASSIFICATION, -c CLASSIFICATION
                        Classification (PROK/UNC/..)
  --output_filename OUTPUT_FILENAME, -f OUTPUT_FILENAME
                        Output filename
  --locus_tag LOCUS_TAG, -l LOCUS_TAG
                        Overwrite the locus tag in the annotation file
  --translation_table TRANSLATION_TABLE, -n TRANSLATION_TABLE
                        Translation table
  --chromosome_list CHROMOSOME_LIST, -d CHROMOSOME_LIST
                        Create a chromosome list file, and use the supplied
                        name
  --version             show program's version number and exit
```

