# ampligone CWL Generation Report

## ampligone

### Tool Description
An accurate and efficient tool to remove primers from NGS reads in reference-based experiments

### Metadata
- **Docker Image**: quay.io/biocontainers/ampligone:2.0.2--pyhdfd78af_0
- **Homepage**: https://rivm-bioinformatics.github.io/AmpliGone/
- **Package**: https://anaconda.org/channels/bioconda/packages/ampligone/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ampligone/overview
- **Total Downloads**: 14.5K
- **Last updated**: 2025-11-13
- **GitHub**: https://github.com/RIVM-bioinformatics/AmpliGone
- **Stars**: N/A
### Original Help Text
```text
usage: AmpliGone [required options] [optional arguments]

AmpliGone: An accurate and efficient tool to
remove primers from NGS reads in reference-based experiments

Required Arguments:
  --input, -i File                      Input file with reads in either FastQ
                                        or BAM format.
  --output, -o File                     Output (FastQ) file with cleaned
                                        reads.
  --reference, -ref File                Input Reference genome in FASTA format
  --primers, -pr File                   Used primer sequences in FASTA format
                                        or primer coordinates in BED format.
                                         Note that using bed-files overrides
                                         error-rate and ambiguity
                                         functionality

Optional Arguments:
  --amplicon-type, -at 'end-to-end'/'end-to-mid'/'fragmented'
                                        Define the amplicon-type, either being
                                        'end-to-end',
                                        'end-to-mid', or
                                        'fragmented'. See the
                                        docs for more info 📖
                                          (default: end-to-
                                          end)
  --virtual-primers, -vp                If set, primers closely positioned to
                                        each other in the same orientation
                                        will be virtually combined into a
                                        single primer, ensuring proper removal
                                        of all primer-related data in a
                                        specific region. This is useful for
                                        amplicons that share multiple
                                        (alternative) primers for increased
                                        specificity.
                                          (default:
                                          False)
  --fragment-lookaround-size, -fls N    The number of bases to look around a
                                        primer-site to consider it part of a
                                        fragment. Only used if amplicon-type
                                        is 'fragmented'. Default is 10
  --error-rate, -er N                   The maximum allowed error rate (as a
                                        percentage) for the primer search. Use
                                        0 for exact primer matches. (0.1 = 10%
                                        error rate)
                                         Note that this is only used if the
                                         primer-file is in FASTA format. If
                                         the primer-file is in BED format,
                                         this option is ignored.
                                          (default:
                                          0.1)
  --alignment-preset, -ap 'sr'/'map-ont'/'map-pb'/'splice'
                                        The preset to use for alignment of
                                        reads against the reference. This can
                                        be either 'sr', 'map-ont', 'map-pb',
                                        or 'splice'. The alignment-preset can
                                        be combined with a custom alignment-
                                        scoring matrix. See the docs for more
                                        info 📖
  --alignment-scoring, -as KEY=VALUE [KEY=VALUE ...]
                                        The scoring matrix to use for
                                        alignment of reads. This should be
                                        list of key-value pairs, where the key
                                        is the scoring-parameter and the value
                                        is a positive integer indicating the
                                        scoring-value for that parameter.
                                        Possible parameters are
                                         * (1) match
                                         * (2) mismatch
                                         * (3) gap_o1
                                         * (4) gap_e1
                                         * (5) gap_o2 (Optional: requires
                                           1,2,3,4)
                                         * (6) gap_e2 (Optional, requires
                                           1,2,3,4,5)
                                         * (7) mma (Optional, requires
                                           1,2,3,4,5,6)
                                        For example:
                                         --alignment-scoring match=4
                                         mismatch=3 gap_o1=2 gap_e1=1
                                        See the docs for more info 📖
  --export-primers, -ep File            Output BED file with found primer
                                        coordinates if they are actually cut
                                        from the reads
  --threads, -t N                       Number of threads you wish to use.
                                         Default is the number of available
                                         threads in your system (2)
  -to                                   If set, AmpliGone will always create
                                        the output files even if there is
                                        nothing to output. (for example when
                                        an empty input-file is given)
                                         This is useful in (automated)
                                         pipelines where you want to make sure
                                         that the output files are always
                                         created.
                                          (default:
                                          False)
  --verbose, -V                         Prints more information, like DEBUG
                                        statements, to the terminal
                                          (default:
                                          False)
  --quiet, -q                           Prints less information, like only
                                        WARNING and ERROR statements, to the
                                        terminal
                                          (default:
                                          False)
  --version, -v                         You are using AmpliGone
                                        version 2.0.2
  --help, -h                            Show this help message and exit
```


## Metadata
- **Skill**: not generated
