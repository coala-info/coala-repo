# twilight CWL Generation Report

## twilight

### Tool Description
TWILIGHT Command Line Arguments:

### Metadata
- **Docker Image**: quay.io/biocontainers/twilight:0.2.3--h6bb9b41_1
- **Homepage**: https://github.com/TurakhiaLab/TWILIGHT
- **Package**: https://anaconda.org/channels/bioconda/packages/twilight/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/twilight/overview
- **Total Downloads**: 6.4K
- **Last updated**: 2026-01-07
- **GitHub**: https://github.com/TurakhiaLab/TWILIGHT
- **Stars**: N/A
### Original Help Text
```text
TWILIGHT Command Line Arguments:

Inputs
 [1] Build MSA From Unaligned Sequences
 [2] Merge Multiple MSAs
 [3] Add New Sequences to Existing MSA:
  -t [ --tree ] arg                        Guide tree (Newick format): required
                                           for [1]; optional for [3].
  -i [ --sequences ] arg                   Unaligned sequences file (FASTA 
                                           format): required for [1] and [3].
  -a [ --alignment ] arg                   Backbone alignments (FASTA format): 
                                           required for [3].
  -f [ --files ] arg                       Directory containing all MSA files. 
                                           MSA files (FASTA format): required 
                                           for [2].

Output/File Options:
  -o [ --output ] arg                      Output file name (required).
  -d [ --temp-dir ] arg                    Directory for storing temporary 
                                           files.
  -k [ --keep-temp ]                       Keep the temporary directory.
  -c [ --compress ]                        Write output files in compressed 
                                           (.gz) format
  --overwrite                              Force overwriting the output file.

Hardware Usage:
  -C [ --cpu ] arg                         Number of CPU cores. Default: all 
                                           available cores.
  -G [ --gpu ] arg                         Number of GPUs. Default: all 
                                           available GPUs.
  --gpu-index arg                          Specify the GPU to be used, 
                                           separated by commas. Ex. 0,2,3
  --cpu-only                               Run the program only on CPU.

Alignment Options and Parameters:
  --type arg                               Data type. n: nucleotide, p: 
                                           protein. Will be automatically 
                                           inferred if not provided.
  -m [ --max-subtree ] arg                 Maximum number of leaves in a 
                                           subtree.
  -r [ --remove-gappy ] arg (=0.949999988) Threshold for removing gappy 
                                           columns. Set to 1 to disable this 
                                           feature.
  -w [ --wildcard ]                        Treat unknown or ambiguous bases as 
                                           wildcards and align them to usual 
                                           letters.
  --rooted                                 Keep the original tree root (disable
                                           automatic re-rooting for 
                                           parallelism)
  --prune                                  Prune the input guide tree based on 
                                           the presence of unaligned sequences.
  --write-prune                            Write the pruned tree to the output 
                                           directory.

Sequence Filtering Options:
  --length-deviation arg                   Sequences whose lengths deviate from
                                           the median by more than the 
                                           specified fraction will be deferred 
                                           or excluded.
  --max-ambig arg (=0.100000001)           Sequences with an ambiguous 
                                           character proportion exceeding the 
                                           specified threshold will be deferred
                                           or excluded.
  --max-len arg                            Sequences longer than max-len will 
                                           be deferred or excluded.
  --min-len arg                            Sequences shorter than min-len will 
                                           be deferred or excluded.
  --filter                                 Exclude sequences with high 
                                           ambiguity or length deviation.
  --write-filtered                         Write the filtered sequences in 
                                           FASTA format to the output 
                                           directory.

Scoring Parameters:
  --match arg (=18)                        Match score.
  --mismatch arg (=-8)                     Mismatch penalty for transversions.
  --transition arg (=-4)                   Score for transitions.
  --gap-open arg (=-50)                    Gap-Open penalty.
  --gap-extend arg (=-5)                   Gap-Extend penalty.
  --gap-ends arg                           Gap penalty at ends, default set to 
                                           the same as the gap extension 
                                           penalty.
  --xdrop arg (=600)                       X-drop value (scale). The actual 
                                           X-drop will be multiplied by the 
                                           gap-extend penalty.
  -x [ --matrix ] arg                      Use a user-defined substitution 
                                           matrix (only for nucleotide).
  -b [ --blosum ] arg (=62)                BLOSUM matrix to use for protein 
                                           sequences: 45, 62, or 80.

General:
  --check                                  Check the final alignment. Sequences
                                           with no legal alignment will be 
                                           displayed.
  -v [ --verbose ]                         Print out every detail process.
  -h [ --help ]                            Print help messages.
  -V [ --version ]                         Show program version.
```

