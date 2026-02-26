# bioprov CWL Generation Report

## bioprov_genome_annotation

### Tool Description
Genome annotation with Prodigal, Prokka and the COG database.

### Metadata
- **Docker Image**: quay.io/biocontainers/bioprov:0.1.23--pyh5e36f6f_0
- **Homepage**: https://github.com/vinisalazar/BioProv
- **Package**: https://anaconda.org/channels/bioconda/packages/bioprov/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bioprov/overview
- **Total Downloads**: 8.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/vinisalazar/BioProv
- **Stars**: N/A
### Original Help Text
```text
usage: genome_annotation [-h] -i INPUT [-c CPUS] [-v] [-t TAG] [-s SEP]
                         [-l LOG] [--steps STEPS] [--update_db]
                         [--upload_to_provstore] [--write_provn] [--write_pdf]

Genome annotation with Prodigal, Prokka and the COG database.

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        Input file, may be a tab delimited file or a
                        directory. If a file, must contain column 'sample-id'
                        for sample ID and 'assembly' for files. See program
                        help for information. (default: None)
  -c CPUS, --cpus CPUS  Default is set in BioProv config (half of the CPUs).
                        (default: 10)
  -v, --verbose         More verbose output (default: False)
  -t TAG, --tag TAG     A tag for the Project (default: None)
  -s SEP, --sep SEP     Separator for the tab-delimited file. (default: )
  -l LOG, --log LOG     Path to write log file to. If not set, will be defined
                        automatically. (default: None)
  --steps STEPS         A comma-delimited string of which steps will be run in
                        the workflow. Possible steps: ['prodigal'] (default:
                        ['prodigal'])
  --update_db           Whether to update the Project in the BioProvDB.
                        (default: False)
  --upload_to_provstore
                        Whether to upload the Project to ProvStore at the end
                        of the execution. (default: False)
  --write_provn         Whether to write PROVN output at the end of the
                        execution. (default: False)
  --write_pdf           Whether to write graphical output at the end of the
                        execution. (default: False)
```


## bioprov_blastn

### Tool Description
Align nucleotide data to a reference database with BLASTN.

### Metadata
- **Docker Image**: quay.io/biocontainers/bioprov:0.1.23--pyh5e36f6f_0
- **Homepage**: https://github.com/vinisalazar/BioProv
- **Package**: https://anaconda.org/channels/bioconda/packages/bioprov/overview
- **Validation**: PASS

### Original Help Text
```text
usage: blastn [-h] -i INPUT [-c CPUS] [-v] [-t TAG] [-s SEP] [-l LOG]
              [--steps STEPS] [--update_db] [--upload_to_provstore]
              [--write_provn] [--write_pdf] -db DATABASE

Align nucleotide data to a reference database with BLASTN.

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        Input file, may be a tab delimited file or a
                        directory. If a file, must contain column 'sample-id'
                        for sample ID and 'query' for files. See program help
                        for information. (default: None)
  -c CPUS, --cpus CPUS  Default is set in BioProv config (half of the CPUs).
                        (default: 10)
  -v, --verbose         More verbose output (default: False)
  -t TAG, --tag TAG     A tag for the Project (default: None)
  -s SEP, --sep SEP     Separator for the tab-delimited file. (default: )
  -l LOG, --log LOG     Path to write log file to. If not set, will be defined
                        automatically. (default: None)
  --steps STEPS         A comma-delimited string of which steps will be run in
                        the workflow. Possible steps: ['blastn'] (default:
                        ['blastn'])
  --update_db           Whether to update the Project in the BioProvDB.
                        (default: False)
  --upload_to_provstore
                        Whether to upload the Project to ProvStore at the end
                        of the execution. (default: False)
  --write_provn         Whether to write PROVN output at the end of the
                        execution. (default: False)
  --write_pdf           Whether to write graphical output at the end of the
                        execution. (default: False)
  -db DATABASE, --database DATABASE
                        BLASTn reference database. Must be a valid BLAST
                        database created with the `makeblastdb` command.
                        (default: None)
```


## bioprov_kaiju

### Tool Description
Run Kaiju on metagenomic data and create reports for taxonomic ranks.

### Metadata
- **Docker Image**: quay.io/biocontainers/bioprov:0.1.23--pyh5e36f6f_0
- **Homepage**: https://github.com/vinisalazar/BioProv
- **Package**: https://anaconda.org/channels/bioconda/packages/bioprov/overview
- **Validation**: PASS

### Original Help Text
```text
usage: kaiju [-h] -i INPUT [-o OUTPUT_DIRECTORY] -db KAIJU_DB -no NODES -na
             NAMES [--kaiju_params KAIJU_PARAMS]
             [--kaiju2table_params KAIJU2TABLE_PARAMS] [-t TAG] [-v]
             [-p THREADS]

Run Kaiju on metagenomic data and create reports for taxonomic ranks.

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        Input file, a tab delimited file which must contain
                        three columns: 'sample-id', 'R1', and 'R2', containing
                        respectively sample IDs, _path to forward reads and
                        _path to reverse reads.
  -o OUTPUT_DIRECTORY, --output_directory OUTPUT_DIRECTORY
                        Output directory to create Kaiju files. Default is
                        directory of input file.
  -db KAIJU_DB, --kaiju_db KAIJU_DB
                        Kaiju database file.
  -no NODES, --nodes NODES
                        NCBI Taxonomy nodes.dmp file required to run Kaiju.
  -na NAMES, --names NAMES
                        NCBI Taxonomy names.dmp file required to run
                        Kaiju2Table.
  --kaiju_params KAIJU_PARAMS
                        Parameter string to be added to Kaiju command.
  --kaiju2table_params KAIJU2TABLE_PARAMS
                        Parameter string to be added to Kaiju2table command.
  -t TAG, --tag TAG     A tag for the dataset
  -v, --verbose         More verbose output
  -p THREADS, --threads THREADS
                        Number of threads. Default is set in BioProv config
                        (half of the threads).
```

