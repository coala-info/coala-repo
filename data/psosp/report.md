# psosp CWL Generation Report

## psosp_test

### Tool Description
A tool for host-virus sequence analysis (psosp)

### Metadata
- **Docker Image**: quay.io/biocontainers/psosp:1.1.2--pyhdfd78af_2
- **Homepage**: https://github.com/mujiezhang/PSOSP
- **Package**: https://anaconda.org/channels/bioconda/packages/psosp/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/psosp/overview
- **Total Downloads**: 881
- **Last updated**: 2025-07-07
- **GitHub**: https://github.com/mujiezhang/PSOSP
- **Stars**: N/A
### Original Help Text
```text
usage: psosp [-h] [-hf HOST_FASTA] [-vf VIRUS_FASTA] [-wd WORKING_DIR]
             [-hfaa HOST_FAA] [-db CHECKV_DB] [-v]
             {test,predict} ...
psosp: error: ambiguous option: --h could match --help, --host_fasta, --host_faa
```


## psosp_predict

### Tool Description
Predict virus-host interactions using psosp

### Metadata
- **Docker Image**: quay.io/biocontainers/psosp:1.1.2--pyhdfd78af_2
- **Homepage**: https://github.com/mujiezhang/PSOSP
- **Package**: https://anaconda.org/channels/bioconda/packages/psosp/overview
- **Validation**: PASS

### Original Help Text
```text
usage: psosp predict [-h] -hf HOST_FASTA -vf VIRUS_FASTA -wd WORKING_DIR
                     [-hfaa HOST_FAA] [-db CHECKV_DB]

options:
  -h, --help            show this help message and exit
  -hf HOST_FASTA, --host_fasta HOST_FASTA
                        Host genome fasta file
  -vf VIRUS_FASTA, --virus_fasta VIRUS_FASTA
                        Virus genome fasta file (can contain multiple viruses)
  -wd WORKING_DIR, --working_dir WORKING_DIR
                        Output directory path
  -hfaa HOST_FAA, --host_faa HOST_FAA
                        Host faa file path (optional, will run prodigal if not
                        provided)
  -db CHECKV_DB, --checkv_db CHECKV_DB
                        checkv reference database path (optional)
```

