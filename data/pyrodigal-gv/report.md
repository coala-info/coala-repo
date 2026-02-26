# pyrodigal-gv CWL Generation Report

## pyrodigal-gv

### Tool Description
Find genes in nucleotide sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyrodigal-gv:0.3.2--pyh7e72e81_0
- **Homepage**: https://github.com/althonos/pyrodigal-gv
- **Package**: https://anaconda.org/channels/bioconda/packages/pyrodigal-gv/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pyrodigal-gv/overview
- **Total Downloads**: 16.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/althonos/pyrodigal-gv
- **Stars**: N/A
### Original Help Text
```text
usage: pyrodigal-gv [-a trans_file] [-c] [-d nuc_file] [-f output_type]
                    [-g tr_table] [-i input_file] [-m] [-n] [-o output_file]
                    [-p mode] [-s start_file] [-t training_file] [-j jobs]
                    [-h] [-V] [--min-gene MIN_GENE]
                    [--min-edge-gene MIN_EDGE_GENE]
                    [--max-overlap MAX_OVERLAP] [--no-stop-codon]
                    [--pool {thread,process}]

options:
  -a trans_file         Write protein translations to the selected file.
                        (default: None)
  -c                    Closed ends. Do not allow genes to run off edges.
                        (default: False)
  -d nuc_file           Write nucleotide sequences of genes to the selected
                        file. (default: None)
  -f output_type        Select output format. (default: gff)
  -g tr_table           Specify a translation table to use. (default: 11)
  -i input_file         Specify FASTA input file. (default: None)
  -m                    Treat runs of N as masked sequence; don't build genes
                        across them. (default: False)
  -n                    Bypass Shine-Dalgarno trainer and force a full motif
                        scan. (default: False)
  -o output_file        Specify output file. (default: None)
  -p mode               Select procedure. (default: meta)
  -s start_file         Write all potential genes (with scores) to the
                        selected file. (default: None)
  -t training_file      Write a training file (if none exists); otherwise,
                        read and use the specified training file. (default:
                        None)
  -j jobs, --jobs jobs  The number of threads to use if input contains
                        multiple sequences. (default: 1)
  -h, --help            Show this help message and exit.
  -V, --version         Show version number and exit.
  --min-gene MIN_GENE   The minimum gene length. (default: 90)
  --min-edge-gene MIN_EDGE_GENE
                        The minimum edge gene length. (default: 60)
  --max-overlap MAX_OVERLAP
                        The maximum number of nucleotides that can overlap
                        between two genes on the same strand. This must be
                        lower or equal to the minimum gene length. (default:
                        60)
  --no-stop-codon       Disables translation of stop codons into star
                        characters (*) for complete genes. (default: True)
  --pool {thread,process}
                        The sort of pool to use to process genomes in
                        parallel. Processes may be faster than threads on some
                        machines, refer to documentation. (default: thread)
```

