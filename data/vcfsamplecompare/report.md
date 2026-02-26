# vcfsamplecompare CWL Generation Report

## vcfsamplecompare_vcfSampleCompare.pl

### Tool Description
This script answers the question "What's different?" between my samples. It does this by sorting and filtering the variant records of a VCF file (containing data for 2 or more samples) based on the differences in the variant data between samples. The end result is a file containing the variants that show the biggest difference at the top and variants with no or little difference at the bottom or filtered out. Think of it as the genetic variant analog of a differential gene expression analysis. It solves the problem of finding "what's different" (for example) between wildtype and mutant samples.

### Metadata
- **Docker Image**: quay.io/biocontainers/vcfsamplecompare:2.013--pl526_0
- **Homepage**: https://github.com/hepcat72/vcfSampleCompare
- **Package**: https://anaconda.org/channels/bioconda/packages/vcfsamplecompare/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/vcfsamplecompare/overview
- **Total Downloads**: 13.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/hepcat72/vcfSampleCompare
- **Stars**: N/A
### Original Help Text
```text
vcfSampleCompare.pl version 2.013
Created: 6/22/2017
Last Modified: Fri Dec  6 17:10:22 2019

* WHAT IS THIS:   This script answers the question "What's different?" between
                  my samples. It does this by sorting and filtering the variant
                  records of a VCF file (containing data for 2 or more samples)
                  based on the differences in the variant data between samples.
                  The end result is a file containing the variants that show the
                  biggest difference at the top and variants with no or little
                  difference at the bottom or filtered out. Think of it as the
                  genetic variant analog of a differential gene expression
                  analysis. It solves the problem of finding "what's different"
                  (for example) between wildtype and mutant samples.

                  Note, this tool does not perform a statistical analysis.  It
                  is only meant to highlight whether differences exist between
                  sample groups of interest.  It is not intended to be used as
                  "proof" that differences between samples are "real" or
                  biologically relevant.

                  Degree of "difference" between sample groups is determined by
                  either genotype calls or the difference in the observation
                  ratios (i.e. allelic frequencies "AO/DP") of a particular
                  variant state (e.g. the number of times an 'A' is observed for
                  a variant position over the number of reads that mapped over
                  that position) between each sample group.  Run with `--help
                  --extended` for more details on "degree of difference".

                  The variant state used to determine the difference between
                  sample groups is the one leading to the greatest difference.
                  If there is a tie between reference (REF) and an alternate
                  (ALT) variant states when computing the difference, the
                  alternate state is the default selected variant state.

                  If multiple pairs of sample groups are provided, the pair used
                  to represent the difference for a variant row is the one
                  leading to the greatest degree of difference in genotype calls
                  or observation ratios between sample groups.

                  If sample groups are not specified, the pair of sample groups
                  leading to the greatest difference is greedily generated.

                  The sort is intended to bring variants whose degree of
                  difference in genotype calls or allelic frequencies between
                  sample groups to the top.

                  See --help --extended for more details.

* INPUT FORMAT:   A VCF file is a plain text, tab-delimited file.  The format is
  -i              generally described here: http://bit.ly/2sulKcZ and described
                  in detail here: http://bit.ly/2gKP5bN

                  However, the important parts that this script relies on are:

                  1. The column header line (in particular - looking for the
                  FORMAT and sample name columns).
                  2. The colon-delimited codes in the FORMAT column values,
                  specifically (for SNP data produced by freeBayes and
                  Structural Variant data produced by SVTyper) AO (the number of
                  reads supporting the variant), RO (the number of reads
                  supporting the reference), and DP (the number of reads that
                  map at or over the variant position).
                  3. The colon-delimited values in the sample columns that
                  correspond to the positions defined in the FORMAT column.

                  The file may otherwise be a standard VCF file containing
                  header lines preceded by '##'.  Empty lines are OK and will be
                  printed regardless of parameters supplied to this script.
                  Note, the --header and --no-header flags of this script do not
                  refer to the VCF file's header, but rather the run info header
                  of this script.

* OUTPUT FORMAT:  The output file is the same format as the input VCF files,
  -o              except sorted differently and possibly filtered.

* OUTPUT FORMAT:  Tab delimited file of variants that are sorted by and
  --outfile,-u    optionally filtered on degree of difference between 2 pairs of
                  sample groups.  Sorting and filtering is based on the values
                  in the BEST_GT_SCORE, BEST_OR_SCORE, and BEST_DP_SCORE
                  columns.  The columns of the file are:

                  * CHROM - Chromosome - The chromosome on which the variant is
                  located.
                  * POS - Position - The position starting from 1 where the
                  variant is located.
                  * REF - Reference Value - The value the reference has in the
                  variant position.
                  * ALT - Alternate Value(s) - The value(s) observed in the
                  samples in the variant position.
                  * BEST_PAIR - Best Sample Group Pair ID - The sample group
                  pair's number (numbered from left to right, as they were
                  supplied on the command line) for the pair that resulted in
                  the biggest difference in variant states between the sample
                  groups.  A sub-ID (appended with a dot) is applied for each
                  unique set of samples included in a pair.  If -s was not used
                  to pre-define sample groups, this value will always be 0,
                  though each row's pair of sample groups selected will be
                  independent.
                  * BEST_GT_SCORE - Best Genotype Score - The maximum
                  PAIR_GT_SCORE.  Values are between 0 and 1.  A score of 1
                  means that all members of both sample groups have genotype
                  calls and there are no common genotype calls between the
                  members of the pair of sample groups.  See `--help --extended`
                  for an explanation  of lesser scores.
                  * BEST_OR_SCORE - Best Observation Ratio Score - The maximum
                  PAIR_OR_SCORE.  Values are between 0 and 1 (when --gap-measure
                  is "mean") or -1 and 1 (when --gap-measure is "edge").  See
                  `--help --extended` for more details.
                  * BEST_DP_SCORE - Best Depth Score - The read depth score of
                  the best sample group pair.  The read depth score of the best
                  pair is based on the lower average read depth of the 2 sample
                  groups in the pair.  See the usage for -x and -l to see how
                  the score is calculated.
                  * PAIR_ID - Pair ID - A colon-delimited list of IDs indicating
                  the pair of sample groups the sort and filtering is based on
                  (numbered from left to right, as they were supplied on the
                  command line), with a dot-appended sub-ID indicating the
                  unique set of samples included in the pair.  Each unique set
                  of samples gets its own ID, assigned in the order encountered.
                  The sub-ID is independent of the parent pair ID.
                  * PAIR_GT_SCORE - Pair Genotype Score - A colon-delimited list
                  of each sample group pair's maximum GT score.
                  * PAIR_OR_SCORE - Pair Observation Ratio Score - A colon-
                  delimited list of each sample group pair's maximum observation
                  ratio score.
                  * PAIR_DP_SCORE - Pair Read Depth Score - A colon-delimited
                  list of each sample group pair's read depth score.  The read
                  depth score for each pair is based on the lower average read
                  depth of the 2 sample groups in the pair.  See the usage for -
                  x and -l to see how the score is calculated.
                  * STATES_USED_GT - Genotype Calls Used - The genotype calls
                  used to calculate the BEST_GT_SCORE.  There will be at least 2
                  genotype calls separated by a semicolon.  If there are
                  multiple genotype calls present in 1 sample group, they will
                  be delimited with a "+".
                  * STATE_USED_OR - Variant State Used to Calculate Observation
                  Ratios - The state used can be 0 (the value of the variant at
                  the variant position in the reference), or a number indicating
                  which of the ALT observations produced the BEST_OR_SCORE.
                  E.g. if the state '0' was used to compute the scores
                  (indicating the REF state), then (by default) the average
                  observation ratio of each group will be close to either N/N
                  (i.e. the same as the reference) and the other group will be
                  close to 0/N (i.e. different from the reference).
                  * GROUP1_SAMPLES - Sample Group 1 Members - A comma-delimited
                  list of sample names belonging to group 1.  Lists of group 1
                  samples from multiple pairs of sample groups will be colon-
                  delimited.  E.g. For 2 pairs, the value might be: "s1,s2:s6,
                  s7".
                  * GROUP1_GTS - Sample Group 1 Genotype Calls - A list of
                  comma-delimited genotype calls.  Lists of group 1 genotype
                  calls from multiple pairs of sample groups will be colon-
                  delimited.
                  * GROUP1_ORS - Sample Group 1 Observation Ratios - A list of
                  comma-delimited observation ratios based on the variant state
                  in STATE_USED_OR.  Lists of group 1 observation ratios from
                  multiple pairs of sample groups will be colon-delimited.
                  * GROUP2_SAMPLES - Sample Group 2 Members - A comma-delimited
                  list of sample names belonging to group 2.  Lists of group 2
                  samples from multiple pairs of sample groups will be colon-
                  delimited.  E.g. For 2 pairs, the value might be: "s1,s2:s6,
                  s7".
                  * GROUP2_GTS - Sample Group 2 Genotype Calls - A list of
                  comma-delimited genotype calls.  Lists of group 2 genotype
                  calls from multiple pairs of sample groups will be colon-
                  delimited.
                  * GROUP2_ORS - Sample Group 2 Observation Ratios - A list of
                  comma-delimited observation ratios based on the variant state
                  in STATE_USED_OR.  Lists of group 2 observation ratios from
                  multiple pairs of sample groups will be colon-delimited.

                  Example:

                  #CHROM	POS	ID	REF	ALT	BEST_PAIR	BEST_GT_SCORE	BEST_OR_SCORE
                  	BEST_DP_SCORE	PAIR_ID	PAIR_GT_SCORE	PAIR_OR_SCORE
                  	PAIR_DP_SCORE	STATES_USED_GT	STATE_USED_OR	GROUP1_SAMPLES
                  	GROUP1_GTS	GROUP1_ORS	GROUP2_SAMPLES	GROUP2_GTS	GROUP2_ORS
                  Chromosome	6610	.	C	G	1	1	1	408	1	1	1	408	1;0	1	sample1	1
                  	254/254	sample2,sample3	0,0	0/407,0/564
                  Chromosome	10723	.	C	G	1	1	1	111	1	1	1	111	1;0	1	sample1	1
                  	39/39	sample2,sample3	0,0	0/78,0/216
                  Chromosome	10843	.	T	C	1	1	1	33	1	1	1	33	1;0	1	sample1	1	8/8
                  	sample2,sample3	0,0	0/25,0/67
                  Chromosome	10855	.	T	G	1	1	1	24	1	1	1	24	1;0	1	sample1	1	9/9
                  	sample2,sample3	0,0	0/17,0/47
                  Chromosome	10866	.	TCCTG	CCCTA	1	1	1	21	1	1	1	21	1;0	1
                  	sample1	1	6/6	sample2,sample3	0,0	0/15,0/42
                  Chromosome	10876	.	C	G	1	1	1	20	1	1	1	20	1;0	1	sample1	1	8/8
                  	sample2,sample3	0,0	0/13,0/38
                  Chromosome	10888	.	G	C	1	1	1	19	1	1	1	19	1;0	1	sample1	1	8/8
                  	sample2,sample3	0,0	0/11,0/37



Supply `--help --extended` for advanced help.
```

