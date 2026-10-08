# geno2phenotb CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| geno2phenotb_run | PASS |  |

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
