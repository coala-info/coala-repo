# prodigal CWL Generation Report

## prodigal

### Tool Description
PRODIGAL: fast, reliable protein-coding gene prediction for prokaryotic genomes

### Metadata
- **Docker Image**: quay.io/biocontainers/prodigal:2.60--1
- **Homepage**: https://github.com/hyattpd/Prodigal
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/prodigal/overview
- **Total Downloads**: 577.8K
- **Last updated**: 2025-07-17
- **GitHub**: https://github.com/hyattpd/Prodigal
- **Stars**: N/A
### Original Help Text
```text
WARNING: Skipping mount /etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
-------------------------------------
PRODIGAL v2.60 [October, 2011]         
Univ of Tenn / Oak Ridge National Lab
Doug Hyatt, Loren Hauser, et al.     
-------------------------------------

Usage:  prodigal [-a trans_file] [-c] [-d nuc_file] [-f output_type]
                 [-g tr_table] [-h] [-i input_file] [-m] [-n] [-o output_file]
                 [-p mode] [-q] [-s start_file] [-t training_file] [-v]

         -a:  Write protein translations to the selected file.
         -c:  Closed ends.  Do not allow genes to run off edges.
         -d:  Write nucleotide sequences of genes to the selected file.
         -f:  Select output format (gbk, gff, or sco).  Default is gbk.
         -g:  Specify a translation table to use (default 11).
         -h:  Print help menu and exit.
         -i:  Specify input file (default reads from stdin).
         -m:  Treat runs of n's as masked sequence and do not build genes across 
              them.
         -n:  Bypass the Shine-Dalgarno trainer and force the program to scan
              for motifs.
         -o:  Specify output file (default writes to stdout).
         -p:  Select procedure (single or meta).  Default is single.
         -q:  Run quietly (suppress normal stderr output).
         -s:  Write all potential genes (with scores) to the selected file.
         -t:  Write a training file (if none exists); otherwise, read and use
              the specified training file.
         -v:  Print version number and exit.
```
