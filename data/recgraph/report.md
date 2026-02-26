# recgraph CWL Generation Report

## recgraph

### Tool Description
RecGraph

### Metadata
- **Docker Image**: quay.io/biocontainers/recgraph:1.0.0--h7b50bb2_1
- **Homepage**: https://github.com/AlgoLab/RecGraph
- **Package**: https://anaconda.org/channels/bioconda/packages/recgraph/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/recgraph/overview
- **Total Downloads**: 2.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/AlgoLab/RecGraph
- **Stars**: N/A
### Original Help Text
```text
recgraph 1.0.0
Davide Monti <d.monti11@campus.unimib.it>
RecGraph

USAGE:
    recgraph [OPTIONS] <SEQUENCE_PATH> <GRAPH_PATH>

OPTIONS:
    -h, --help       Print help information
    -V, --version    Print version information

I/O:
    -o, --out_file <OUT_FILE>    Output alignment file [default: "standard output"]
    <GRAPH_PATH>             Input graph (in .gfa format)
    <SEQUENCE_PATH>          Input sequences (in .fasta format)

Alignment:
    -B, --rec-band-width <REC_BAND_WIDTH>
            Recombination band width [default: 1]

    -E, --gap-ext <GAP_EXTENSION>
            Gap extension penalty [default: 2]

    -m, --aln-mode <ALIGNMENT_MODE>
            0: global POA, 1: local POA, 2: affine gap POA, 3: local gap POA,
            4: global pathwise alignment, 5: semiglobal pathwise alignment,
            6: global pathwise alignment with affine gap (EXPERIMENTAL),
            7: semiglobal pathwise alignment with affine gap (EXPERIMENTAL),
            8: global recombination alignment, 9: semiglobal recombination alignment [default: 0]

    -M, --match <MATCH_SCORE>
            Match score [default: 2]

    -O, --gap-open <GAP_OPEN>
            Gap opening penalty [default: 4]

    -r, --multi-rec-cost <MULTI_REC_COST>
            Displacement multiplier [default: 0.1]

    -R, --base-rec-cost <BASE_REC_COST>
            Recombination cost, determined with -r as R + r*(displacement_length) [default: 4]

    -s, --amb-strand <AMB_STRAND>
            Ambigous strand mode (experimental): try reverse complement if alignment score is too
            low [default: false] [possible values: true, false]

    -t, --matrix <MATRIX>
            Scoring matrix file, if '-t' is used, '-M' and '-X' are not used and you should set gap
            penalties in this case [default: none]

    -X, --mismatch <MISMATCH_SCORE>
            Mismatch penalty [default: 4]

Adaptive banded:
    -b, --extra-b <EXTRA_B>    First adaptive banding par, set < 0 to disable adaptive banded
                               [default: 1]
    -f, --extra-f <EXTRA_F>    Second adaptive banding par, number of basis added to both side of
                               the band = b+f*L, l = length of the sequence [default: 0.01]
```

