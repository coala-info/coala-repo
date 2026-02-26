# pmlst CWL Generation Report

## pmlst_pmlst.py

### Tool Description
Perform pMLST prediction on FASTA or FASTQ files.

### Metadata
- **Docker Image**: quay.io/biocontainers/pmlst:2.0.3--hdfd78af_0
- **Homepage**: https://bitbucket.org/genomicepidemiology/pmlst
- **Package**: https://anaconda.org/channels/bioconda/packages/pmlst/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pmlst/overview
- **Total Downloads**: 2.6K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: pmlst.py [-h] -i INFILE [INFILE ...] [-o OUTDIR] -s SCHEME
                [-p DATABASE] [-t TMP_DIR] [-mp METHOD_PATH] [-x] [-q]

optional arguments:
  -h, --help            show this help message and exit
  -i INFILE [INFILE ...], --infile INFILE [INFILE ...]
                        FASTA or FASTQ files to do pMLST on.
  -o OUTDIR, --outdir OUTDIR
                        Output directory.
  -s SCHEME, --scheme SCHEME
                        scheme database used for pMLST prediction
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
```

