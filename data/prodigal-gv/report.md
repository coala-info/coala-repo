# prodigal-gv CWL Generation Report

## prodigal-gv

### Tool Description
PRODIGAL v2.11.0-gv [March, 2023]
Univ of Tenn / Oak Ridge National Lab
Doug Hyatt, Loren Hauser, et al.

### Metadata
- **Docker Image**: quay.io/biocontainers/prodigal-gv:2.11.0--he4a0461_4
- **Homepage**: https://github.com/apcamargo/prodigal-gv
- **Package**: https://anaconda.org/channels/bioconda/packages/prodigal-gv/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/prodigal-gv/overview
- **Total Downloads**: 30.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/apcamargo/prodigal-gv
- **Stars**: N/A
### Original Help Text
```text
-------------------------------------
PRODIGAL v2.11.0-gv [March, 2023]         
Univ of Tenn / Oak Ridge National Lab
Doug Hyatt, Loren Hauser, et al.     
-------------------------------------

Usage:  prodigal-gv [-a trans_file] [-c] [-d nuc_file] [-f output_type]
                 [-g tr_table] [-h] [-i input_file] [-m] [-n] [-o output_file]
                 [-p mode] [-q] [-s start_file] [-t training_file] [-v]

         -a:  Write protein translations to the selected file.
         -c:  Closed ends. Do not allow genes to run off edges.
         -d:  Write nucleotide sequences of genes to the selected file.
         -f:  Select output format (gbk, gff, or sco).  Default is gbk.
         -g:  Specify a translation table to use (default 11).
         -h:  Print help menu and exit.
         -i:  Specify FASTA/Genbank input file (default reads from stdin).
         -m:  Treat runs of N as masked sequence; don't build genes across them.
         -n:  Bypass Shine-Dalgarno trainer and force a full motif scan.
         -o:  Specify output file (default writes to stdout).
         -p:  Select procedure (single or meta).  Default is single.
         -q:  Run quietly (suppress normal stderr output).
         -s:  Write all potential genes (with scores) to the selected file.
         -t:  Write a training file (if none exists); otherwise, read and use
              the specified training file.
         -v:  Print version number and exit.
```

