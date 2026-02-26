# peglit CWL Generation Report

## peglit

### Tool Description
Searches for linker sequences, avoiding complementarity to pegRNA sequence.

### Metadata
- **Docker Image**: quay.io/biocontainers/peglit:1.1.0--pyh7cba7a3_0
- **Homepage**: https://github.com/sshen8/peglit/
- **Package**: https://anaconda.org/channels/bioconda/packages/peglit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/peglit/overview
- **Total Downloads**: 3.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/sshen8/peglit
- **Stars**: N/A
### Original Help Text
```text
usage: peglit (sequence | --batch FILE) [options]

Searches for linker sequences, avoiding complementarity to pegRNA sequence.

pegRNA sequence(s):
  sequence              A single pegRNA sequence, to which linker should avoid
                        complementarity, in 5' -> 3' orientation. Comma-
                        separated subsequences denote: spacer, scaffold,
                        template, PBS, motif.
  --batch FILE          A headered CSV file containing pegRNA sequences. Must
                        contain columns for spacer, scaffold, template, PBS,
                        motif. Output will be written in a CSV with the same
                        name but appended with _linker_designs.

algorithm parameters:
  --linker-pattern LINKER_PATTERN
                        Nucleotides allowed in linker. Default: NNNNNNNN.
  --ac-thresh AC_THRESH
                        Minimum allowed AC content in linker sequence.
                        Default: 0.5.
  --u-thresh U_THRESH   Maximum number of consecutive Us allowed in linker
                        sequence.Default: 3.
  --n-thresh N_THRESH   Maximum number of consecutive any nucleotide
                        allowed.Default: 3.
  --topn TOPN           Keep this many of the best linkers. Small value ->
                        better linker sequences. Large value -> potentially
                        more diverse. Default: 100.
  --epsilon EPSILON     Basepairing probabilities are considered equal if
                        their difference is less than this tolerance value.
                        Default: 0.01.
  --seed SEED           Reproducibly initializes pseudorandom number
                        generator. Default: 2020.

simulated annealing parameters:
  --num-repeats NUM_REPEATS
                        Number of repeats. Default: 10.
  --num-steps NUM_STEPS
                        Number of steps. Default: 250.
  --temp-init TEMP_INIT
                        Initial temperature. Default: 0.15.
  --temp-decay TEMP_DECAY
                        Multiplicative temperature decay per step. Default:
                        0.95.

output options:
  --bottleneck BOTTLENECK
                        Number of sequences to output. Default: 1.
  --verbose             In addition to linker sequences, print MFE structure
                        and top Zucker suboptimal structure with linker
                        complementarity.
  --scaffold-thresh SCAFFOLD_THRESH
                        In verbose output, * indicates predicted structure
                        contains scaffold that interacts with the rest of the
                        pegRNA with probability greater than threshold.
                        Default: 0.15.
  --motif-thresh MOTIF_THRESH
                        In verbose output, + indicates predicted structure
                        contains motif that interacts with the rest of the
                        pegRNA with probability greater than threshold.
                        Default: 0.15.
  --clusters CLUSTERS   Filename to save clusters plot.
  -h, --help            Show this help message and exit

(advanced) set algorithm parameters per pegRNA in CSV:
  --linker-pattern-col LINKER_PATTERN_COL
  --ac-thresh-col AC_THRESH_COL
  --u-thresh-col U_THRESH_COL
  --n-thresh-col N_THRESH_COL
  --topn-col TOPN_COL
  --epsilon-col EPSILON_COL
  --num-repeats-col NUM_REPEATS_COL
  --num-steps-col NUM_STEPS_COL
  --temp-init-col TEMP_INIT_COL
  --temp-decay-col TEMP_DECAY_COL
  --bottleneck-col BOTTLENECK_COL
  --scaffold-thresh-col SCAFFOLD_THRESH_COL
  --motif-thresh-col MOTIF_THRESH_COL
```

