# haploclique CWL Generation Report

## haploclique_clever

### Tool Description
predicts haplotypes from NGS reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/haploclique:1.3.1--h2b6358e_4
- **Homepage**: https://github.com/cbg-ethz/haploclique
- **Package**: https://anaconda.org/channels/bioconda/packages/haploclique/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/haploclique/overview
- **Total Downloads**: 7.6K
- **Last updated**: 2025-09-04
- **GitHub**: https://github.com/cbg-ethz/haploclique
- **Stars**: N/A
### Original Help Text
```text
haploclique predicts haplotypes from NGS reads.

Usage:
  haploclique bronkerbosch [options] [--] <bamfile> [<output>]
  haploclique [options] [--] <bamfile> [<output>]

  clever        use the original clever clique finder
  bronkerbosch  use the Bron-Kerbosch based clique finder

Options:
  -q NUM --edge_quasi_cutoff_cliques=NUM  edge calculator option
                                              [default: 0.99]
  -k NUM --edge_quasi_cutoff_mixed=NUM    edge calculator option
                                              [default: 0.97]
  -g NUM --edge_quasi_cutoff_single=NUM   edge calculator option
                                              [default: 0.95]
  -Q NUM --random_overlap_quality=NUM     edge calculator option
                                              [default: 0.9]
  -m --frame_shift_merge                      Reads will be clustered with 
                                              single nucleotide insertions or
                                              deletions. Use for PacBio data.
  -o NUM --min_overlap_cliques=NUM        edge calculator option
                                              [default: 0.9]
  -j NUM --min_overlap_single=NUM         edge calculator option
                                              [default: 0.6]
  -A FILE --allel_frequencies=FILE
  -I FILE --call_indels=FILE              variant calling is not supported
                                              yet.
  -M FILE --mean_and_sd_filename=FILE     Required for option -I
  -p NUM --indel_edge_sig_level=NUM       [default: 0.2]
  -i NUM --iterations=NUM                 Number of iterations.
                                              haploclique will stop if the 
                                              superreads converge.
                                              [default: -1]
  -f NUM --filter=NUM                     Filter out reads with low
                                              frequency at the end.
                                              [default: 0.0]
  -n --no_singletons                          Filter out single read cliques
                                              after first iteration.
  -s NUM --significance=NUM               Filter out reads witch are below
                                              <num> standard deviations.
                                              [default: 3.0]
  -L FILE --log=FILE                       Write log to <file>.
  -d NUM --doc_haplotypes=NUM              Used in simulation studies with known
                                           haplotypes to document which reads
                                           contributed to which final cliques (3 or 5).
  -p0 --no_prob0                            ignore the tail probabilites during edge
                                           calculation in <output>.
  -gff --gff                               Option to create GFF File from output. <output> is used as prefix.
  -bam --bam                               Option to create BAM File from output. <output> is used as prefix.
  -mc NUM --max_cliques=NUM                Set a threshold for the maximal number of cliques which
                                           should be considered in the next iteration.
  -lc NUM --limit_clique_size=NUM          Set a threshold to limit the size of cliques.

  -h --help                                Display this help text
  -v --version                             Display version
```


## haploclique_bronkerbosch

### Tool Description
predicts haplotypes from NGS reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/haploclique:1.3.1--h2b6358e_4
- **Homepage**: https://github.com/cbg-ethz/haploclique
- **Package**: https://anaconda.org/channels/bioconda/packages/haploclique/overview
- **Validation**: PASS

### Original Help Text
```text
haploclique predicts haplotypes from NGS reads.

Usage:
  haploclique bronkerbosch [options] [--] <bamfile> [<output>]
  haploclique [options] [--] <bamfile> [<output>]

  clever        use the original clever clique finder
  bronkerbosch  use the Bron-Kerbosch based clique finder

Options:
  -q NUM --edge_quasi_cutoff_cliques=NUM  edge calculator option
                                              [default: 0.99]
  -k NUM --edge_quasi_cutoff_mixed=NUM    edge calculator option
                                              [default: 0.97]
  -g NUM --edge_quasi_cutoff_single=NUM   edge calculator option
                                              [default: 0.95]
  -Q NUM --random_overlap_quality=NUM     edge calculator option
                                              [default: 0.9]
  -m --frame_shift_merge                      Reads will be clustered with 
                                              single nucleotide insertions or
                                              deletions. Use for PacBio data.
  -o NUM --min_overlap_cliques=NUM        edge calculator option
                                              [default: 0.9]
  -j NUM --min_overlap_single=NUM         edge calculator option
                                              [default: 0.6]
  -A FILE --allel_frequencies=FILE
  -I FILE --call_indels=FILE              variant calling is not supported
                                              yet.
  -M FILE --mean_and_sd_filename=FILE     Required for option -I
  -p NUM --indel_edge_sig_level=NUM       [default: 0.2]
  -i NUM --iterations=NUM                 Number of iterations.
                                              haploclique will stop if the 
                                              superreads converge.
                                              [default: -1]
  -f NUM --filter=NUM                     Filter out reads with low
                                              frequency at the end.
                                              [default: 0.0]
  -n --no_singletons                          Filter out single read cliques
                                              after first iteration.
  -s NUM --significance=NUM               Filter out reads witch are below
                                              <num> standard deviations.
                                              [default: 3.0]
  -L FILE --log=FILE                       Write log to <file>.
  -d NUM --doc_haplotypes=NUM              Used in simulation studies with known
                                           haplotypes to document which reads
                                           contributed to which final cliques (3 or 5).
  -p0 --no_prob0                            ignore the tail probabilites during edge
                                           calculation in <output>.
  -gff --gff                               Option to create GFF File from output. <output> is used as prefix.
  -bam --bam                               Option to create BAM File from output. <output> is used as prefix.
  -mc NUM --max_cliques=NUM                Set a threshold for the maximal number of cliques which
                                           should be considered in the next iteration.
  -lc NUM --limit_clique_size=NUM          Set a threshold to limit the size of cliques.

  -h --help                                Display this help text
  -v --version                             Display version
```


## Metadata
- **Skill**: not generated
