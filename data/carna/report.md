# carna CWL Generation Report

## carna

### Tool Description
A tool for pairwise Alignment of RNA.

### Metadata
- **Docker Image**: quay.io/biocontainers/carna:1.3.3--1
- **Homepage**: https://github.com/Code52/carnac
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/carna/overview
- **Total Downloads**: 36.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Code52/carnac
- **Stars**: N/A
### Original Help Text
```text
carna 1.3.3
A tool for pairwise Alignment of RNA.

USAGE: carna [options] <file 1> <file 2>

Options:

Scoring parameters:
  -m,--match=<score>(50)
    Match score

  -M,--mismatch=<score>(0)
    Mismatch score

  --ribosum-file=<f>(RIBOSUM85_60)
    Ribosum file

  --use-ribosum=<bool>(true)
    Use ribosum scores

  -i,--indel=<score>(-350)
    Indel score

  --indel-opening=<score>(-500)
    Indel opening score

  -s,--struct-weight=<score>(200)
    Maximal weight of 1/2 arc match

  -e,--exp-prob=<prob>
    Expected probability

  -t,--tau=<factor>(0)
    Tau factor in percent


Controlling output:
  --gist
    Use gist for graphical search (feature disabled, recompile to activate).

  -w,--width=<columns>(120)
    Output width

  --clustal=<file>
    Clustal output

  --pp=<file>
    PP output

  --write-structure
    Write guidance structure in output


Heuristics for speed accuracy trade off:
  -p,--min-prob=<prob>(0.01)
    Minimal probability

  --max-bps-length-ratio=<factor>(0.0)
    Maximal ratio of #base pairs divided by sequence length (default: no
    effect)

  -D,--max-diff-am=<diff>(-1)
    Maximal difference for sizes of matched arcs

  -d,--max-diff=<diff>(-1)
    Maximal difference for alignment cuts

  --max-diff-at-am=<diff>(-1)
    Maximal difference for alignment traces, only at arc match positions


Constraints:
  --noLP
    No lonely pairs (only used when predicing ensemble porobabilities and for
    compatibility with locarna; otherwise no effect)

  --maxBPspan=<span>(-1)
    Limit maximum base pair span (default=off)

  --relaxed-anchors
    Relax anchor constraints (default=off)

  --ignore-constraints
    Ignore constraints in pp-file

  --lb=<score>
    Lower score bound

  --ub=<score>
    Upper score bound


Controlling Gecode:
  --c_d=<distance>(1)
    Recomputation distance

  --time-limit=<time>(300000)
    Time limit in ms (always search first solution; turn off by 0).


Standard options:
  -h,--help
    This help

  -V,--version
    Version info

  -v,--verbose
    Verbose


RNA sequences and pair probabilities:

Input_files RNA sequences and pair probabilities:
```

