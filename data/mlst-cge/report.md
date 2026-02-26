# mlst-cge CWL Generation Report

## mlst-cge_mlst.py

### Tool Description
Performs Multi-Locus Sequence Typing (MLST) on input FASTA or FASTQ files.

### Metadata
- **Docker Image**: quay.io/biocontainers/mlst-cge:2.0.9--hdfd78af_0
- **Homepage**: https://bitbucket.org/genomicepidemiology/mlst
- **Package**: https://anaconda.org/channels/bioconda/packages/mlst-cge/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mlst-cge/overview
- **Total Downloads**: 1.8K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: mlst.py [-h] -i INFILE [INFILE ...] [-o OUTDIR] -s SPECIES
               [-p DATABASE] [-t TMP_DIR] [-mp METHOD_PATH] [-x] [-q]
               [-matrix] [-d DEPTH]

optional arguments:
  -h, --help            show this help message and exit
  -i INFILE [INFILE ...], --infile INFILE [INFILE ...]
                        FASTA or FASTQ files to do MLST on.
  -o OUTDIR, --outdir OUTDIR
                        Output directory.
  -s SPECIES, --species SPECIES
                        species database used for MLST prediction
  -p DATABASE, --database DATABASE
                        Directory containing the databases.
  -t TMP_DIR, --tmp_dir TMP_DIR
                        Temporary directory for storage of the results from
                        the external software.
  -mp METHOD_PATH, --method_path METHOD_PATH
                        Path to the method to use (kma or blastn) if assembled
                        contigs are inputted the path to executable blastn
                        should be given, if fastq files are given path to
                        executable kma should be given
  -x, --extented_output
                        Give extented output with allignment files, template
                        and query hits in fasta and a tab seperated file with
                        allele profile results
  -q, --quiet
  -matrix, --matrix     Gives the counts all all called bases at each position
                        in each mapped template. Columns are: reference base,
                        A count, C count, G count, T count, N count, - count.
  -d DEPTH, --depth DEPTH
                        The minimum required depth for a gene to be considered
```

