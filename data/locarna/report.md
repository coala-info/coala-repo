# locarna CWL Generation Report

## locarna

### Tool Description
pairwise (global and local) alignment of RNA.

### Metadata
- **Docker Image**: quay.io/biocontainers/locarna:2.0.1--pl5321h4ac6f70_0
- **Homepage**: https://s-will.github.io/LocARNA
- **Package**: https://anaconda.org/channels/bioconda/packages/locarna/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/locarna/overview
- **Total Downloads**: 150.5K
- **Last updated**: 2025-09-09
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
locarna - pairwise (global and local) alignment of RNA.

USAGE: locarna [options] <Input 1> <Input 2> 

Options:
  -h, --help                          Print this help.

  --galaxy-xml                        Print galaxy xml wrapper.

  -V, --version                       Print only version string.

  -v, --verbose                       Be verbose. Prints input parameters,
                                      sequences and size information.

  -q, --quiet                         Be quiet.


Scoring parameters:
  -i, --indel=<score>(-150)           Indel score. Score contribution of each
                                      single base insertion or deletion.
                                      Indel opening score and indel score
                                      define the affine scoring of gaps.

  --indel-opening=<score>(-750)       Indel opening score. Score contribution
                                      of opening an insertion or deletion,
                                      i.e. score for a consecutive run of
                                      deletions or insertions. Indel opening 
                                      score and indel score define the affine
                                      scoring of gaps.

  --ribosum-file=<f>(RIBOSUM85_60)    File specifying the Ribosum base and
                                      base-pair similarities. [default: use
                                      RIBOSUM85_60 without requiring a
                                      Ribosum file.]

  --use-ribosum=<bool>(true)          Use ribosum scores for scoring base
                                      matches and base pair matches; note
                                      that tau=0 suppresses any effect on the
                                      latter.

  -m, --match=<score>(50)             Set score contribution of a base match 
                                      (unless ribosum scoring).

  -M, --mismatch=<score>(0)           Set score contribution of a base
                                      mismatch (unless ribosum scoring).

  --unpaired-penalty=<score>(0)       Penalty for unpaired bases

  -s, --struct-weight=<score>(200)    Maximal weight of 1/2 arc match.
                                      Balances structure vs. sequence score
                                      contributions.

  -e, --exp-prob=<prob>               Expected base pair probability. Used as
                                      background probability for base pair
                                      scoring [default: calculated from
                                      sequence length].

  -t, --tau=<factor>(50)              Tau factor. Factor for contribution of 
                                      sequence similarity in an arc match (in
                                      percent). tau=0 does not penalize any
                                      sequence information including
                                      compensatory mutations at arc matches, 
                                      while tau=100 scores sequence
                                      similarity at ends of base matches (if 
                                      a scoring matrix like ribosum is used, 
                                      this adds the contributions for base
                                      pair match from the matrix). [default
                                      tau=0!]

  -E, --exclusion=<score>(0)          Score contribution per exclusion in
                                      structure local alignment. Set to zero 
                                      for unrestricted structure locality.

  --stacking                          Use stacking terms (requires
                                      stack-probs by RNAfold -p2)

  --new-stacking                      Use new stacking terms (requires
                                      stack-probs by RNAfold -p2)


Partition function representation (for sequence envelopes):
  --extended-pf                       Use extended precision for the
                                      computation of sequence envelopes. This
                                      enables handling significantly larger
                                      instances. [default]

  --quad-pf                           Use quad precision for partition
                                      function values. Even more precision
                                      than extended pf, but usually much
                                      slower (overrides extended-pf).


Locality:
  --struct-local=<bool>(false)        Turn on/off structure locality. Allow
                                      exclusions in alignments of connected
                                      substructures.

  --sequ-local=<bool>(false)          Turn on/off sequence locality. Find
                                      best alignment of arbitrary
                                      subsequences of the input sequences.

  --free-endgaps=<spec>(----)         Control where end gaps are allowed for 
                                      free. String of four +/- symbols,
                                      allowing/disallowing free end gaps at
                                      the four sequence ends in the order
                                      left end of first sequence, right end
                                      of first sequence, left end of second
                                      sequence, right end of second sequence.
                                      For example, "+---" allows free end
                                      gaps at the left end of the first
                                      alignment string; "----" forbids free
                                      end gaps [default].

  --normalized=<L>(0)                 Perform normalized local alignment with
                                      parameter L. This causes locarna to
                                      compute the best local alignment
                                      according to 'Score' / ( L + 'length'
                                      ), where length is the sum of the
                                      lengths of the two locally aligned
                                      subsequences. Thus, the larger L, the
                                      larger the local alignment; the size of
                                      value L is in the order of local
                                      alignment lengths. Verbose yields info 
                                      on the iterative optimizations.

  --penalized=<PP>(0)                 Penalized local alignment with penalty 
                                      PP


Output:
  -w, --width=<columns>(120)          Width of alignment output.

  --clustal=<file>                    Write alignment in ClustalW (aln)
                                      format to given file.

  --stockholm=<file>                  Write alignment Stockholm format to
                                      given file.

  --pp=<file>                         Write alignment in PP format to given
                                      file.

  --alifold-consensus-dp              Compute consensus dot plot by alifold
                                      (warning: this may fail for long
                                      sequences).

  --consensus-structure=<type>(none)    Type of consensus structures written to
                                      screen and stockholm output
                                      [alifold|mea|none] (default: none).

  --consensus-gamma=<float>(1.0)      Base pair weight for mea consensus
                                      computation. For MEA, base pairs are
                                      scored by their pair probability times 
                                      2 gamma; unpaired bases, by their
                                      unpaired probability.

  -L, --local-output                  Output only local sub-alignment (to std
                                      out).

  --local-file-output                 Write only local sub-alignment to
                                      output files.

  -P, --pos-output                    Output only local sub-alignment
                                      positions.

  --write-structure                   Write guidance structure in output.

  --score-components                  Output components of the score
                                      (experimental).

  --stopwatch                         Print run time informations.


Heuristics for speed accuracy trade off:
  -p, --min-prob=<probability>(0.001)    Minimal probability. Only base pairs of
                                      at least this probability are taken
                                      into account.

  --max-bps-length-ratio=<factor>(0.0)    Maximal ratio of #base pairs divided by
                                      sequence length. This serves as a
                                      second filter on the "significant" base
                                      pairs. [default: 0.0 = no effect].

  -D, --max-diff-am=<diff>(-1)        Maximal difference for sizes of matched
                                      arcs. [-1=off]

  -d, --max-diff=<diff>(-1)           Maximal difference for positions of
                                      alignment traces (and aligned bases).
                                      [-1=off]

  --max-diff-at-am=<diff>(-1)         Maximal difference for positions of
                                      alignment traces at arc match ends.
                                      [-1=off]

  --max-diff-aln=<aln file>()         Maximal difference relative to given
                                      alignment (file in clustalw format)

  --max-diff-pw-aln=<alignment>()     Maximal difference relative to given
                                      alignment (string, delim=AMPERSAND)

  --max-diff-relax                    Relax deviation constraints in multiple
                                      aligmnent

  --min-trace-probability=<probability>(1e-4)    Minimal sequence alignment
                                      probability of potential traces
                                      (probability-based sequence alignment
                                      envelope) [default=1e-4].


Special sauce options:
  --kbest=<k>(-1)                     Enumerate k-best alignments

  --better=<t>(-1000000)              Enumerate alignments better threshold t


MEA score:
  --mea-alignment                     Perform maximum expected accuracy
                                      alignment (instead of using the default
                                      similarity scoring).

  --match-prob-method=<int>(0)        Select method for computing
                                      sequence-based base match probablities 
                                      (to be used for mea-type alignment
                                      scores). Methods: 1=probcons-style from
                                      HMM, 2=probalign-style from PFs, 3=from
                                      PFs, local

  --probcons-file=<file>              Read parameters for probcons-like
                                      calculation of match probabilities from
                                      probcons parameter file.

  --temperature-alipf=<int>(300)      Temperature for the /sequence
                                      alignment/ partition functions used by 
                                      the probcons-like sequence-based
                                      match/trace probability computation
                                      (this temperature is different from the
                                      'physical' temperature of RNA
                                      folding!).

  --pf-struct-weight=<weight>(200)    Structure weight in PF computations
                                      (for the computation of sequence-based 
                                      match probabilties from partition
                                      functions).

  --mea-gapcost                       Use gap cost in mea alignment

  --mea-alpha=<weight>(0)             Weight alpha for MEA

  --mea-beta=<weight>(200)            Weight beta for MEA

  --mea-gamma=<weight>(100)           Weight gamma for MEA

  --probability-scale=<scale>(10000)    Scale for probabilities/resolution of
                                      mea score

  --write-match-probs=<file>          Write match probs to file (don't
                                      align!).

  --write-trace-probs=<file>          Write trace probs to file (don't
                                      align!).

  --read-match-probs=<file>           Read match probabilities from file.

  --write-arcmatch-scores=<file>      Write arcmatch scores (don't align!)

  --read-arcmatch-scores=<file>       Read arcmatch scores.

  --read-arcmatch-probs=<file>        Read arcmatch probabilities (weighted
                                      by factor mea_beta/100)


Constraints:
  --noLP                              Disallow lonely pairs in prediction and
                                      alignment.

  --maxBPspan=<span>(-1)              Limit maximum base pair span
                                      [default=off].

  --relaxed-anchors                   Use relaxed semantics of anchor
                                      constraints [default=strict semantics].


Input files:
  The tool is called with two input files <Input 1> and <Input 2>, which
  specify the two input sequences or input alignments. Different input
  formats (Fasta, Clustal, Stockholm, LocARNA PP, ViennaRNA postscript
  dotplots) are accepted and automatically recognized (by file content); the 
  two input files can be in different formats. Extended variants of the
  Clustal and Stockholm formats enable specifying anchor and structure
  constraints.


Report bugs to <will (at) informatik.uni-freiburg.de>.
```

