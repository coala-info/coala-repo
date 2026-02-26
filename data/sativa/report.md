# sativa CWL Generation Report

## sativa_sativa.py

### Tool Description
SATIVA v0.9.1, released on 2023-08-16. Last version: https://github.com/amkozlov/sativa 
By A.Kozlov and J.Zhang, the Exelixis Lab. Based on RAxML 8.2.3 by A.Stamatakis.

### Metadata
- **Docker Image**: quay.io/biocontainers/sativa:0.9.3--py312h031d066_0
- **Homepage**: https://github.com/amkozlov/sativa
- **Package**: https://anaconda.org/channels/bioconda/packages/sativa/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sativa/overview
- **Total Downloads**: 2.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/amkozlov/sativa
- **Stars**: N/A
### Original Help Text
```text
usage: sativa.py -s ALIGNMENT -t TAXONOMY -x {BAC,BOT,ZOO,VIR} [options]

SATIVA v0.9.1, released on 2023-08-16. Last version: https://github.com/amkozlov/sativa 
By A.Kozlov and J.Zhang, the Exelixis Lab. Based on RAxML 8.2.3 by A.Stamatakis.

optional arguments:
  -h, --help            show this help message and exit
  -s ALIGN_FNAME        Reference alignment file (PHYLIP or FASTA). Sequences
                        must be aligned, their IDs must correspond to those in
                        taxonomy file.
  -t TAXONOMY_FNAME     Reference taxonomy file.
  -x {bac,bot,zoo,vir}  Taxonomic code: BAC(teriological), BOT(anical),
                        ZOO(logical), VIR(ological)
  -n OUTPUT_NAME        Job name, will be used as a prefix for output file
                        names (default: taxonomy file name without extension)
  -o OUTPUT_DIR         Output directory (default: current).
  -T NUM_THREADS        Specify the number of CPUs (default: 20)
  -N REP_NUM            Number of RAxML tree searches (with distinct random
                        seeds) to resolve multifurcation. Default: 1
  -v                    Print additional info messages to the console.
  -R                    Resume execution after a premature termination (e.g.,
                        due to expired job time limit). Run name of the
                        previous (terminated) job must be specified via -n
                        option.
  -c CONFIG_FNAME       Config file name.
  -r REF_FNAME          Specify the reference alignment and taxonomy in
                        refjson format.
  -j JPLACE_FNAME       Do not call RAxML to perform EPA leave-one-out test,
                        use existing .jplace file as input instead. This could
                        be also a directory with *.jplace files.
  -J FINAL_JPLACE_FNAME
                        Do not call RAxML to perform final EPA classification,
                        use existing .jplace file as input instead. This could
                        be also a directory with *.jplace files.
  -p RAND_SEED          Random seed to be used with RAxML. Default: 12345
  -C CONF_CUTOFF        Confidence cut-off between 0 and 1. Default: 0
  -P BRLEN_PV           P-value for branch length Erlang test. Default: 0=off
  -l MIN_LHW            A value between 0 and 1, the minimal sum of likelihood
                        weight of an assignment to a specific rank. This value
                        represents a confidence measure of the assignment,
                        assignments below this value will be discarded.
                        Default: 0 to output all possbile assignments.
  -m {thorough,fast,ultrafast}
                        Method of multifurcation resolution: thorough use
                        stardard constrainted RAxML tree search (default) fast
                        use RF distance as search convergence criterion (RAxML
                        -D option) ultrafast optimize model+branch lengths
                        only (RAxML -f e option)
  -S                    Enable RAxML memory saving (useful for large and gappy
                        alignments).
  -Y SYNONYM_FNAME      File listing synonymous rank names, which will be
                        considered equivalent. Please enter one name per line;
                        separate groups with an empty line.
  -debug                Debug mode, intermediate files will not be cleaned up.
  -ranktest             Test for misplaced higher ranks.
  -tmpdir TEMP_DIR      Directory for temporary files.

Example: sativa.py -s example/test.phy -t example/test.tax -x BAC
```

