# epa-ng CWL Generation Report

## epa-ng

### Tool Description
Massively-Parallel Evolutionary Placement Algorithm

### Metadata
- **Docker Image**: quay.io/biocontainers/epa-ng:0.3.8--h077b44d_7
- **Homepage**: https://github.com/Pbdas/epa-ng
- **Package**: https://anaconda.org/channels/bioconda/packages/epa-ng/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/epa-ng/overview
- **Total Downloads**: 72.2K
- **Last updated**: 2025-12-04
- **GitHub**: https://github.com/Pbdas/epa-ng
- **Stars**: N/A
### Original Help Text
```text
epa-ng - Massively-Parallel Evolutionary Placement Algorithm
Usage: epa-ng [OPTIONS]

Options:
  -h,--help                   Print this help message and exit
  -v,--version                Display version.
  --verbose                   Display debug output.


Convert:
  -c,--bfast TEXT:FILE        Convert the given fasta file to bfast format.
  -B,--dump-binary            Binary Dump mode: write ref. tree in binary format then exit. NOTE: not compatible with premasking!
  --split TEXT:FILE ...       Takes a reference MSA (phylip/fasta/fasta.gz) and combined ref + query MSA(s) (phylip/fasta/fasta.gz) and outputs a monolithic query file (fasta), as well as a reference file (fasta), ready for use. Usage: epa-ng --split ref_alignment query_alignments+


Input:
  -t,--tree TEXT:FILE Excludes: --binary
                              Path to Reference Tree file.
  -s,--ref-msa,--msa TEXT:FILE Excludes: --binary
                              Path to Reference MSA file.
  -b,--binary TEXT:FILE Excludes: --tree --ref-msa
                              Path to binary reference file, as created using --dump-binary.
  -q,--query TEXT:FILE        Path to Query MSA file.
  -m,--model TEXT=GTR+G       Description string of the model to be used, or a RAxML_info file. --model STRING | FILE See: https://github.com/amkozlov/raxml-ng/wiki/Input-data#evolutionary-model


Output:
  -w,--outdir,--out-dir TEXT:DIR=./
                              Path to output directory.
  --filter-acc-lwr FLOAT:FLOAT in [0 - 1] Excludes: --filter-min-lwr
                              Accumulated likelihood weight after which further placements are discarded.
  --filter-min-lwr FLOAT:FLOAT in [0 - 1]=0.01 Excludes: --filter-acc-lwr
                              Minimum likelihood weight below which a placement is discarded.
  --filter-min UINT=1         Minimum number of placements per sequence to include in final output.
  --filter-max UINT=7         Maximum number of placements per sequence to include in final output.
  --precision UINT=10         Output decimal point precision for floating point numbers.
  --redo                      Overwrite existing files.
  --preserve-rooting TEXT:{off,on}
                              Preserve the rooting of rooted trees. When disabled, EPA-ng will print the result as an unrooted tree.


Compute:
  -g,--dyn-heur FLOAT:FLOAT in [0 - 1]=0.99999 Excludes: --fix-heur --baseball-heur --no-heur
                              Two-phase heuristic, determination of candidate edges using accumulative threshold. Enabled by default! See --no-heur for disabling it
  -G,--fix-heur FLOAT:FLOAT in [0 - 1] Excludes: --dyn-heur --baseball-heur --no-heur
                              Two-phase heuristic, determination of candidate edges by specified percentage of total edges.
  --baseball-heur Excludes: --dyn-heur --fix-heur --no-heur
                              Baseball heuristic as known from pplacer. strike_box=3,max_strikes=6,max_pitches=40.
  --no-heur Excludes: --dyn-heur --fix-heur --baseball-heur
                              Disables heuristic preplacement completely. Overrides all other heuristic flags.
  --chunk-size UINT=5000      Number of query sequences to be read in at a time. May influence performance.
  --raxml-blo                 Employ old style of branch length optimization during thorough insertion as opposed to sliding approach. WARNING: may significantly slow down computation.
  --no-pre-mask               Do NOT pre-mask sequences. Enables repeats unless --no-repeats is also specified.
  --rate-scalers TEXT:{off,on,auto}
                              Use individual rate scalers. Important to avoid numerical underflow in taxa rich trees.
  -T,--threads UINT=0         Number of threads to use. If 0 is passed as argument,program will run with the maximum number of threads available.
```

