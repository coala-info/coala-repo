# decoypyrat CWL Generation Report

## decoypyrat

### Tool Description
Create decoy protein sequences. Each protein is reversed and the cleavage
sites switched with preceding amino acid. Peptides are checked for existence
in target sequences if found the tool will attempt to shuffle them.

### Metadata
- **Docker Image**: quay.io/biocontainers/decoypyrat:1.0.1--py_0
- **Homepage**: https://github.com/tdido/DecoyPYrat
- **Package**: https://anaconda.org/channels/bioconda/packages/decoypyrat/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/decoypyrat/overview
- **Total Downloads**: 3.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/tdido/DecoyPYrat
- **Stars**: N/A
### Original Help Text
```text
usage: decoypyrat [-h] [--cleavage_sites CSITES] [--anti_cleavage_sites NOC]
                  [--cleavage_position {c,n}] [--min_peptide_length MINLEN]
                  [--max_iterations MAXIT] [--do_not_shuffle]
                  [--do_not_switch] [--decoy_prefix DPREFIX]
                  [--output_fasta DOUT] [--temp_file TOUT] [--no_isobaric]
                  [--memory_save] [--keep_names]
                  *.fasta|*.fa

Create decoy protein sequences. Each protein is reversed and the cleavage
sites switched with preceding amino acid. Peptides are checked for existence
in target sequences if found the tool will attempt to shuffle them.
James.Wright@sanger.ac.uk 2015

positional arguments:
  *.fasta|*.fa          FASTA file of target proteins sequences for which to
                        create decoys

optional arguments:
  -h, --help            show this help message and exit
  --cleavage_sites CSITES, -c CSITES
                        A list of amino acids at which to cleave during
                        digestion. Default = KR
  --anti_cleavage_sites NOC, -a NOC
                        A list of amino acids at which not to cleave if
                        following cleavage site ie. Proline. Default = none
  --cleavage_position {c,n}, -p {c,n}
                        Set cleavage to be c or n terminal of specified
                        cleavage sites. Default = c
  --min_peptide_length MINLEN, -l MINLEN
                        Set minimum length of peptides to compare between
                        target and decoy. Default = 5
  --max_iterations MAXIT, -n MAXIT
                        Set maximum number of times to shuffle a peptide to
                        make it non-target before failing. Default=100
  --do_not_shuffle, -x  Turn OFF shuffling of decoy peptides that are in the
                        target database. Default=false
  --do_not_switch, -s   Turn OFF switching of cleavage site with preceding
                        amino acid. Default=false
  --decoy_prefix DPREFIX, -d DPREFIX
                        Set accesion prefix for decoy proteins in output.
                        Default=XXX
  --output_fasta DOUT, -o DOUT
                        Set file to write decoy proteins to. Default=decoy.fa
  --temp_file TOUT, -t TOUT
                        Set temporary file to write decoys prior to shuffling.
                        Default=tmp.fa
  --no_isobaric, -i     Do not make decoy peptides isobaric. Default=false
  --memory_save, -m     Slower but uses less memory (does not store decoy
                        peptide list). Default=false
  --keep_names, -k      Keep sequence names in the decoy output. Default=false
```

