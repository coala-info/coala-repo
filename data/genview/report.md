# genview CWL Generation Report

## genview_genview-makedb

### Tool Description
Creates sqlite3 database with genetic environment from genomes containing the provided reference gene(s).

### Metadata
- **Docker Image**: quay.io/biocontainers/genview:0.2--pyhdfd78af_0
- **Homepage**: https://github.com/EbmeyerSt/GEnView.git
- **Package**: https://anaconda.org/channels/bioconda/packages/genview/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/genview/overview
- **Total Downloads**: 7.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/EbmeyerSt/GEnView
- **Stars**: N/A
### Original Help Text
```text
usage: genview-makedb [-h] -d TARGET_DIRECTORY -db DATABASE [-p PROCESSES]
                      [-id IDENTITY] [-scov SUBJECT_COVERAGE] [--update]
                      [--uniprot_db UNIPROT_DB]
                      [--uniprot_cutoff UNIPROT_CUTOFF]
                      [--taxa TAXA [TAXA ...]] [--assemblies] [--plasmids]
                      [--local LOCAL] [--save_tmps] [--accessions ACCESSIONS]
                      [--flanking_length FLANKING_LENGTH] [--kraken2 KRAKEN2]
                      [--log] [--clean]

Creates sqlite3 database with genetic environment from genomes containing the provided reference gene(s).

options:
  -h, --help            show this help message and exit
  -d TARGET_DIRECTORY, --target_directory TARGET_DIRECTORY
                        path to output directory
  -db DATABASE, --database DATABASE
                        fasta/multifasta file containing amino acid sequences of translated genes to be annotated
  -p PROCESSES, --processes PROCESSES
                        number of cores to run the script on
  -id IDENTITY, --identity IDENTITY
                        identity cutoff for hits to be saved to the database (e.g 80 for 80% cutoff)
  -scov SUBJECT_COVERAGE, --subject_coverage SUBJECT_COVERAGE
                        minimum coverage for a hit to be saved to db (e.g 80 for 80% cutoff)
  --update              update an existing genview database with new genomes
  --uniprot_db UNIPROT_DB
                        Path to uniprotKB database
  --uniprot_cutoff UNIPROT_CUTOFF
                        % identity threshold for annotating orfs aurrounding the target sequence, default 60
  --taxa TAXA [TAXA ...]
                        taxon/taxa names to download genomes for - use "all" do download all available genomes, cannot be specified at the same time as --accessions
  --assemblies          Search NCBI Assembly database 
  --plasmids            Search NCBI Refseq plasmid database
  --local LOCAL         path to local genomes
  --save_tmps           keep temporary files
  --accessions ACCESSIONS
                        csv file containing one genome accession number per row, cannot be specied at the same time as --taxa
  --flanking_length FLANKING_LENGTH
                        Max length of flanking regions to annotate
  --kraken2 KRAKEN2     Path to kraken2 database. Uses kraken2 to classify metagenomic long-reads.
  --log                 Write log file for debugging
  --clean               Erase files from previous genview runs from target directory
```


## genview_genview-visualize

### Tool Description
Extract, visualize and annotate genes and genetic environments from genview database

### Metadata
- **Docker Image**: quay.io/biocontainers/genview:0.2--pyhdfd78af_0
- **Homepage**: https://github.com/EbmeyerSt/GEnView.git
- **Package**: https://anaconda.org/channels/bioconda/packages/genview/overview
- **Validation**: PASS

### Original Help Text
```text
usage: genview-visualize [-h] -gene GENE -db DB -id ID [-nodes NODES]
                         [-taxa TAXA [TAXA ...]] [--force] [--compressed]
                         [--custom_colors CUSTOM_COLORS] [--log]

Extract, visualize and annotate genes and genetic environments from genview database

options:
  -h, --help            show this help message and exit
  -gene GENE            name of gene/orf to extract and visualize
  -db DB                genview database created by genview-create-db
  -id ID                percent identity threshold for genes to extract
  -nodes NODES          should nodes be connected to genome with solid line (solid), connected by dashed line (dash) or no connection (none)
  -taxa TAXA [TAXA ...]
                        list of genera and/or species to extract
                        By default all taxa are extracted
  --force               Force new alignment and phylogeny
  --compressed          Compress number of displayed sequences, helpful with large number of identical sequences
  --custom_colors CUSTOM_COLORS
                        path to file containing RGB color codes for gene color customization
  --log                 Write log file
```


## Metadata
- **Skill**: generated
