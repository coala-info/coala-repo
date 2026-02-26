# sanntis CWL Generation Report

## sanntis

### Tool Description
SMBGC detection tool

### Metadata
- **Docker Image**: quay.io/biocontainers/sanntis:0.9.4.1--pyhdfd78af_0
- **Homepage**: https://github.com/Finn-Lab/SanntiS
- **Package**: https://anaconda.org/channels/bioconda/packages/sanntis/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sanntis/overview
- **Total Downloads**: 14.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Finn-Lab/SanntiS
- **Stars**: N/A
### Original Help Text
```text
usage: sanntis [-h] [--is_protein] [-v] [--ip-file FILE] [--greed INT]
               [--score FLOAT] [--meta True|False] [--outdir DIRECTORY]
               [--outfile FILE] [--minimal True|False]
               [--antismash_output True|False] [--refined True|False]
               [--cpu INT]
               SEQUENCE_FILE

SanntiS. SMBGC detection tool

positional arguments:
  SEQUENCE_FILE         Input sequence file. Supported formats: nucleotide
                        FASTA, GBK, or protein FASTA. If the file is a protein
                        FASTA, it must use Prodigal output headers and must be
                        accompanied by the --is_protein flag. Mandatory.

optional arguments:
  -h, --help            show this help message and exit
  --is_protein          Specify if the input SEQUENCE_FILE is a protein FASTA
                        file. Will only process sequences with headers
                        formatted like Prodigal protein outputs.
  -v, --version         Show the version number and exit.
  --ip-file FILE        Optional, preprocessed InterProScan GFF3 output file.
                        Requires a GBK file as SEQUENCE_FILE. The GBK must
                        have CDS as features, and "protein_id" matching the
                        ids in the InterProScan file. The GBK file can be
                        build with sanntis_build_gb tool
  --greed INT           Level of greediness. 0,1,2 [default 1]
  --score FLOAT         Validation filter threshold. overrides --greed
  --meta True|False     Prodigal option meta [default True]
  --outdir DIRECTORY    Output directory [default $PWD/SEQUENCE_FILE.sanntis]
  --outfile FILE        Output file [default outdir/SEQUENCE_FILE.sanntis.gff]
  --minimal True|False  Minimal output in a gff3 file [default True]
  --antismash_output True|False
                        Write results in antiSMASH 6.0 JSON specification
                        output [default False]
  --refined True|False  Annotate high probability borders [default False]
  --cpu INT             Cpus for INTERPROSCAN and HMMSCAN
```

