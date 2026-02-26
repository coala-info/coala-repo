# yass CWL Generation Report

## yass

### Tool Description
YASS (Yet Another Sequence Searcher) is a tool for finding similarities between sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/yass:1.16--h7b50bb2_0
- **Homepage**: https://bioinfo.lifl.fr/yass
- **Package**: https://anaconda.org/channels/bioconda/packages/yass/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/yass/overview
- **Total Downloads**: 8.8K
- **Last updated**: 2025-09-16
- **GitHub**: https://github.com/laurentnoe/yass
- **Stars**: N/A
### Original Help Text
```text
* Error : " No file found ... give at least one file ... "
* Usage :
  yass [options] { file.mfas | file1.mfas file2.mfas }
      -h       display this Help screen
      -d <int>    0 : Display alignment positions (kept for compatibility)
                  1 : Display alignment positions + alignments + stats (default)
                  2 : Display blast-like tabular output
                  3 : Display light tabular output (better for post-processing)
                  4 : Display BED file output
                  5 : Display PSL file output
      -r <int>    0 : process forward (query) strand
                  1 : process Reverse complement strand
                  2 : process both forward and Reverse complement strands (default)
      -o <str> Output file
      -l       mask Lowercase regions (seed algorithm only)
      -s <int> Sort according to
                  0 : alignment scores
                  1 : entropy
                  2 : mutual information (experimental)
                  3 : both entropy and score
                  4 : positions on the 1st file
                  5 : positions on the 2nd file
                  6 : alignment % id
                  7 : 1st file sequence % id
                  8 : 2nd file sequence % id
                  10-18 : (0-8) + sort by "first fasta-chunk order"
                  20-28 : (0-8) + sort by "second fasta-chunk order"
                  30-38 : (0-8) + sort by "both first/second chunks order"
                  40-48 : equivalent to (10-18) where "best score for fst fasta-chunk" replaces "..."
                  50-58 : equivalent to (20-28) where "best score for snd fasta-chunk" replaces "..."
                  60-68 : equivalent to (70-78), where "sort by best score of fst fasta-chunk" replaces "..."
                  70-78 : BLAST-like behavior : "keep fst fasta-chunk order", then trigger all hits for all good snd fasta-chunk
                  80-88 : equivalent to (30-38) where "best score for fst/snd fasta-chunk"" replaces "..."
      -v       display the current Version
                                                                               
      -M <int> select a scoring Matrix (default 3):
               [Match,Transversion,Transition],(Gopen,Gext)
                0 : [  1, -3, -2],( -8, -2)   1 : [  2, -3, -2],(-12, -4)
                2 : [  3, -3, -2],(-16, -4)   3 : [  5, -4, -3],(-16, -4)
                4 : [  5, -4, -2],(-16, -4)
      -C <int>[,<int>[,<int>[,<int>]]]
               reset match/mismatch/transistion/other Costs (penalties)
               you can also give the 16 values of matrix (ACGT order)
      -G <int>,<int> reset Gap opening/extension penalties
      -L <real>,<real> reset Lambda and K parameters of Gumbel law
      -X <int>  Xdrop threshold score (default 25)
      -E <int>  E-value threshold (default 10)
      -e <real> low complexity filter :
                minimal allowed Entropy of trinucleotide distribution
                ranging between 0 (no filter) and 6 (default 2.80)
                                                                               
      -O <int> memory limit of the number of ungapped alignments (default 1000000)
      -S <int> Select sequence from the first multi-fasta file (default 0)
                 * use 0 to select the full first multi-fasta file
      -T <int> forbid aligning too close regions (e.g. Tandem repeats)
               valid for single sequence comparison only (default 16 bp)
                                                                               
      -p <str> seed Pattern(s)
                 * use '#' for match
                 * use '@' for match or transition
                 * use '-' or '_' for joker
                 * use ',' for seed separator (max: 32 seeds)
                 - example with one seed :
                    yass file.fas -p  "#@#--##--#-##@#"
                 - example with two complementary seeds :
                    yass file.fas -p "##-#-#@#-##@-##,##@#--@--##-#--###"
                 - example with a "minimally overlapping word" (for speed only) :
                    yass file.fas -p "RYNNNNNnnnNNNN"
                 (default  "###-#@-##@##,###--#-#--#-###")
      -c <int> seed hit Criterion : 1 or 2 seeds to consider a hit (default 2)
                                                                               
      -t <real> Trim out over-represented seeds codes
                ranging between 0.0 (no trim) and +inf (default 0.001)
      -a <int> statistical tolerance Alpha (%) (default 5%)
      -i <int> Indel rate (%)                  (default 8%)
      -m <int> Mutation rate (%)               (default 25%)
                                                                               
      -W <int>,<int> Window <min,max> range for post-processing and grouping
                     alignments (default <64,65536>)
      -w <real> Window size coefficient for post-processing and grouping
                alignments (default 16)
                NOTE : -w 0 disables post-processing
```

