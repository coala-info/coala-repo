# emeraldbgc CWL Generation Report

## emeraldbgc

### Tool Description
EMERALD. SMBGC detection tool

### Metadata
- **Docker Image**: quay.io/biocontainers/emeraldbgc:0.2.4.1--pyhdfd78af_0
- **Homepage**: https://github.com/Finn-Lab/emeraldBGC
- **Package**: https://anaconda.org/channels/bioconda/packages/emeraldbgc/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/emeraldbgc/overview
- **Total Downloads**: 7.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Finn-Lab/emeraldBGC
- **Stars**: N/A
### Original Help Text
```text
usage: emeraldbgc [-h] [-v] [--ip-file FILE] [--greed INT] [--score FLOAT]
                  [--meta True|False] [--outdir DIRECTORY] [--outfile FILE]
                  [--minimal True|False] [--antismash_output True|False]
                  [--refined True|False] [--cpu INT]
                  SEQUENCE_FILE

EMERALD. SMBGC detection tool

positional arguments:
  SEQUENCE_FILE         input nucleotide sequence file. FASTA or GBK.
                        mandatory

optional arguments:
  -h, --help            show this help message and exit
  -v, --version         Show the version number and exit.
  --ip-file FILE        Optional, preprocessed InterProScan GFF3 output file.
                        Requires a GBK file as SEQUENCE_FILE. The GBK must
                        have CDS as features, and "protein_id" matching the
                        ids in the InterProScan file. The GBK file can be
                        build with emerald_build_gb tool
  --greed INT           Level of greediness. 0,1,2 [default 1]
  --score FLOAT         validation filter threshold. overrides --greed
  --meta True|False     prodigal option meta [default True]
  --outdir DIRECTORY    output directory [default $PWD/SEQUENCE_FILE.emerald]
  --outfile FILE        output file [default outdir/SEQUENCE_FILE.emerald.gff]
  --minimal True|False  minimal output in a gff3 file [default True]
  --antismash_output True|False
                        write results in antiSMASH 6.0 JSON specification
                        output [default False]
  --refined True|False  annotate high probability borders [default False]
  --cpu INT             cpus for INTERPROSCAN and HMMSCAN
```

