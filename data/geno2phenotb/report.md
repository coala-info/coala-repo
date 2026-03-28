# geno2phenotb CWL Generation Report

## geno2phenotb_test

### Tool Description
Test the installation of geno2phenoTB.

### Metadata
- **Docker Image**: quay.io/biocontainers/geno2phenotb:1.0.1--pyhdfd78af_1
- **Homepage**: https://github.com/msmdev/geno2phenoTB
- **Package**: https://anaconda.org/channels/bioconda/packages/geno2phenotb/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/geno2phenotb/overview
- **Total Downloads**: 3.1K
- **Last updated**: 2025-08-01
- **GitHub**: https://github.com/msmdev/geno2phenoTB
- **Stars**: N/A
### Original Help Text
```text
usage: geno2phenotb test [-h] (-f | -c)

optional arguments:
  -h, --help      show this help message and exit
  -f, --fast      Fast test of installation. This will not test the
                  preprocessing / MTBSeq steps.
  -c, --complete  Complete test of installation. This will download ~ 170mb
                  from the ENA and start a complete run. Depending on your
                  bandwith / hardware this may take a few (5-30) minutes.
```


## geno2phenotb_run

### Tool Description
Run the geno2phenotb pipeline.

### Metadata
- **Docker Image**: quay.io/biocontainers/geno2phenotb:1.0.1--pyhdfd78af_1
- **Homepage**: https://github.com/msmdev/geno2phenoTB
- **Package**: https://anaconda.org/channels/bioconda/packages/geno2phenotb/overview
- **Validation**: PASS

### Original Help Text
```text
usage: geno2phenotb run [-h] [--skip-mtbseq] [-p] -i DIR -o DIR --sample-id
                        SampleID
                        [-d {AMK,CAP,DCS,EMB,ETH,FQ,INH,KAN,PAS,PZA,RIF,STR}]

optional arguments:
  -h, --help            show this help message and exit
  --skip-mtbseq         Skip the MTBseq step. Precomputed output must be
                        present in fastq-dir.
  -p, --preprocess      Run only the preprocessing steps.
  -i DIR, --fastq-dir DIR
                        Path to the directory were the FASTQ files are
                        located.
  -o DIR, --output DIR  Path to the directory were the final output files
                        shall be stored.
  --sample-id SampleID  SampleID (i.e. ERR/SRR run accession).
  -d {AMK,CAP,DCS,EMB,ETH,FQ,INH,KAN,PAS,PZA,RIF,STR}, --drug {AMK,CAP,DCS,EMB,ETH,FQ,INH,KAN,PAS,PZA,RIF,STR}
                        The drug for which resistance should be predicted. If
                        you want predictions for several drugs, use the
                        argument several times,i.e., -d AMK -d DCS -d STR. If
                        the flag is not set, predictions for all drugs will be
                        performed.
```


## Metadata
- **Skill**: generated
