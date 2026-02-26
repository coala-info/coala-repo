# plasmidfinder CWL Generation Report

## plasmidfinder_plasmidfinder.py

### Tool Description
PlasmidFinder is a tool for identifying plasmids in bacterial genomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/plasmidfinder:2.1.6--hdfd78af_0
- **Homepage**: https://bitbucket.org/genomicepidemiology/plasmidfinder
- **Package**: https://anaconda.org/channels/bioconda/packages/plasmidfinder/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/plasmidfinder/overview
- **Total Downloads**: 16.8K
- **Last updated**: 2025-11-06
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: plasmidfinder.py [-h] -i INFILE [INFILE ...] [-o OUTDIR] [-tmp TMP_DIR]
                        [-mp METHOD_PATH] [-p DB_PATH] [-d DATABASES]
                        [-l MIN_COV] [-t THRESHOLD] [-x]
                        [--speciesinfo_json SPECIESINFO_JSON] [-q]

options:
  -h, --help            show this help message and exit
  -i INFILE [INFILE ...], --infile INFILE [INFILE ...]
                        FASTA or FASTQ input files.
  -o OUTDIR, --outputPath OUTDIR
                        Path to blast output
  -tmp TMP_DIR, --tmp_dir TMP_DIR
                        Temporary directory for storage of the results from
                        the external software.
  -mp METHOD_PATH, --methodPath METHOD_PATH
                        Path to method to use (kma or blastn)
  -p DB_PATH, --databasePath DB_PATH
                        Path to the databases
  -d DATABASES, --databases DATABASES
                        Databases chosen to search in - if non is specified
                        all is used
  -l MIN_COV, --mincov MIN_COV
                        Minimum coverage
  -t THRESHOLD, --threshold THRESHOLD
                        Minimum hreshold for identity
  -x, --extented_output
                        Give extented output with allignment files, template
                        and query hits in fasta and a tab seperated file with
                        gene profile results
  --speciesinfo_json SPECIESINFO_JSON
                        Argument used by the cge pipeline. It takes a list in
                        json format consisting of taxonomy, from domain ->
                        species. A database is chosen based on the taxonomy.
  -q, --quiet
```

