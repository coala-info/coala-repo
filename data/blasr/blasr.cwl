cwlVersion: v1.2
class: CommandLineTool
baseCommand: blasr
label: blasr
doc: "A read mapping program that maps reads to positions in a genome by clustering
  short exact matches between the read and the genome, and scoring clusters using
  alignment.\n\nTool homepage: https://github.com/PacificBiosciences/blasr"
inputs:
  - id: reads
    type: File
    doc: PacBio BAM, FASTA, or H5 file of reads.
    inputBinding:
      position: 1
  - id: genome
    type: File
    doc: Reference genome FASTA file.
    inputBinding:
      position: 2
  - id: advance_exact_matches
    type:
      - 'null'
      - int
    doc: Trick for speeding up alignments with match - E fewer anchors.
    default: 0
    inputBinding:
      position: 103
      prefix: --advanceExactMatches
  - id: affine_align
    type:
      - 'null'
      - boolean
    doc: Refine alignment using affine guided align.
    default: false
    inputBinding:
      position: 103
      prefix: --affineAlign
  - id: affine_extend
    type:
      - 'null'
      - int
    doc: Change affine (extension) gap penalty.
    default: 0
    inputBinding:
      position: 103
      prefix: --affineExtend
  - id: affine_open
    type:
      - 'null'
      - int
    doc: Set the penalty for opening an affine alignment.
    default: 10
    inputBinding:
      position: 103
      prefix: --affineOpen
  - id: aggressive_interval_cut
    type:
      - 'null'
      - boolean
    doc: Aggressively filter out non-promising alignment candidates.
    default: false
    inputBinding:
      position: 103
      prefix: --aggressiveIntervalCut
  - id: allow_adjacent_indels
    type:
      - 'null'
      - boolean
    doc: When specified, adjacent insertion or deletions are allowed.
    inputBinding:
      position: 103
      prefix: --allowAdjacentIndels
  - id: bam
    type:
      - 'null'
      - boolean
    doc: Write output in PacBio BAM format.
    inputBinding:
      position: 103
      prefix: --bam
  - id: best_n
    type:
      - 'null'
      - int
    doc: Report the top 'n' alignments.
    default: 10
    inputBinding:
      position: 103
      prefix: --bestn
  - id: clipping
    type:
      - 'null'
      - string
    doc: Use no/hard/subread/soft clipping, ONLY for SAM/BAM output.
    default: none
    inputBinding:
      position: 103
      prefix: --clipping
  - id: concordant
    type:
      - 'null'
      - boolean
    doc: Map all subreads of a zmw to where the longest full pass subread aligned.
    default: false
    inputBinding:
      position: 103
      prefix: --concordant
  - id: fast_max_interval
    type:
      - 'null'
      - boolean
    doc: Fast search maximum increasing intervals as alignment candidates.
    default: false
    inputBinding:
      position: 103
      prefix: --fastMaxInterval
  - id: fast_sdp
    type:
      - 'null'
      - boolean
    doc: Use a fast heuristic algorithm to speed up sparse dynamic programming.
    default: false
    inputBinding:
      position: 103
      prefix: --fastSDP
  - id: header
    type:
      - 'null'
      - boolean
    doc: Print a header as the first line of the output file.
    inputBinding:
      position: 103
      prefix: --header
  - id: hit_policy
    type:
      - 'null'
      - string
    doc: Specify a policy to treat multiple hits from [all, allbest, random, randombest,
      leftmost]
    default: all
    inputBinding:
      position: 103
      prefix: --hitPolicy
  - id: hole_numbers
    type:
      - 'null'
      - string
    doc: When specified, only align reads whose ZMW hole numbers are in LIST.
    inputBinding:
      position: 103
      prefix: --holeNumbers
  - id: ignore_hq_regions
    type:
      - 'null'
      - boolean
    doc: Ignore any hq regions in the region table.
    default: false
    inputBinding:
      position: 103
      prefix: --ignoreHQRegions
  - id: ignore_regions
    type:
      - 'null'
      - boolean
    doc: Ignore any information in the region table.
    default: false
    inputBinding:
      position: 103
      prefix: --ignoreRegions
  - id: max_anchors_per_position
    type:
      - 'null'
      - int
    doc: Do not add anchors from a position if it matches to more than 'm' locations
      in the target.
    default: 10000
    inputBinding:
      position: 103
      prefix: --maxAnchorsPerPosition
  - id: max_lcp_length
    type:
      - 'null'
      - int
    doc: The same as -maxMatch.
    inputBinding:
      position: 103
      prefix: --maxLCPLength
  - id: max_match
    type:
      - 'null'
      - int
    doc: Stop mapping a read to the genome when the lcp length reaches l.
    inputBinding:
      position: 103
      prefix: --maxMatch
  - id: max_score
    type:
      - 'null'
      - int
    doc: Maximum score to output (high is bad, negative good).
    default: -200
    inputBinding:
      position: 103
      prefix: --maxScore
  - id: min_aln_length
    type:
      - 'null'
      - int
    doc: Report alignments only if their lengths are greater than minAlnLength.
    default: 0
    inputBinding:
      position: 103
      prefix: --minAlnLength
  - id: min_match
    type:
      - 'null'
      - int
    doc: Minimum seed length.
    default: 12
    inputBinding:
      position: 103
      prefix: --minMatch
  - id: min_pct_accuracy
    type:
      - 'null'
      - float
    doc: Report alignments only if their percentage accuracy is greater than minAccuracy.
    default: 0
    inputBinding:
      position: 103
      prefix: --minPctAccuracy
  - id: min_pct_similarity
    type:
      - 'null'
      - float
    doc: Report alignments only if their percentage similarity is greater than minPctSimilarity.
    default: 0
    inputBinding:
      position: 103
      prefix: --minPctSimilarity
  - id: min_raw_subread_score
    type:
      - 'null'
      - int
    doc: Do not align subreads whose quality score in region table is less than m.
    default: 0
    inputBinding:
      position: 103
      prefix: --minRawSubreadScore
  - id: min_read_length
    type:
      - 'null'
      - int
    doc: Skip reads that have a full length less than l.
    default: 50
    inputBinding:
      position: 103
      prefix: --minReadLength
  - id: min_subread_length
    type:
      - 'null'
      - int
    doc: Do not align subreads of length less than l.
    default: 0
    inputBinding:
      position: 103
      prefix: --minSubreadLength
  - id: n_candidates
    type:
      - 'null'
      - int
    doc: Keep up to 'n' candidates for the best alignment.
    default: 10
    inputBinding:
      position: 103
      prefix: --nCandidates
  - id: no_print_unaligned_seqs
    type:
      - 'null'
      - boolean
    doc: Must be used together with -unaligned, print unaligned read names only.
    inputBinding:
      position: 103
      prefix: --noPrintUnalignedSeqs
  - id: no_sort_refined_alignments
    type:
      - 'null'
      - boolean
    doc: Do not resort based on local alignment.
    default: false
    inputBinding:
      position: 103
      prefix: --noSortRefinedAlignments
  - id: no_split_subreads
    type:
      - 'null'
      - boolean
    doc: Do not split subreads at adapters.
    inputBinding:
      position: 103
      prefix: --noSplitSubreads
  - id: nproc
    type:
      - 'null'
      - int
    doc: Align using N processes.
    default: 1
    inputBinding:
      position: 103
      prefix: --nproc
  - id: output_mode
    type:
      - 'null'
      - int
    doc: Modify the output format (0-5).
    inputBinding:
      position: 103
      prefix: -m
  - id: place_gap_consistently
    type:
      - 'null'
      - boolean
    doc: Place gaps consistently in alignments of a read as alignments of its reverse
      complementary sequence.
    default: false
    inputBinding:
      position: 103
      prefix: --placeGapConsistently
  - id: place_repeats_randomly
    type:
      - 'null'
      - boolean
    doc: DEPRECATED! If true, equivalent to --hitPolicy randombest.
    default: false
    inputBinding:
      position: 103
      prefix: --placeRepeatsRandomly
  - id: polymerase
    type:
      - 'null'
      - boolean
    doc: Reconstitutes polymerase reads, omitting LQ regions (used with --noSplitSubreads).
    inputBinding:
      position: 103
      prefix: --polymerase
  - id: print_sam_qv
    type:
      - 'null'
      - boolean
    doc: Print quality values to SAM output.
    default: false
    inputBinding:
      position: 103
      prefix: --printSAMQV
  - id: random_seed
    type:
      - 'null'
      - int
    doc: Seed for random number generator.
    default: 0
    inputBinding:
      position: 103
      prefix: --randomSeed
  - id: refine_concordant_alignments
    type:
      - 'null'
      - boolean
    doc: Refine concordant alignments.
    default: false
    inputBinding:
      position: 103
      prefix: --refineConcordantAlignments
  - id: region_table
    type:
      - 'null'
      - File
    doc: Read in a read-region table in HDF format for masking portions of reads (DEPRECATED).
    inputBinding:
      position: 103
      prefix: --regionTable
  - id: sam
    type:
      - 'null'
      - boolean
    doc: Write output in SAM format (no longer supported in v5.2+).
    inputBinding:
      position: 103
      prefix: --sam
  - id: score_matrix
    type:
      - 'null'
      - string
    doc: Specify an alternative score matrix for scoring fasta reads.
    inputBinding:
      position: 103
      prefix: --scoreMatrix
  - id: sdp_tuple_size
    type:
      - 'null'
      - int
    doc: Use matches of length K to speed dynamic programming alignments.
    default: 11
    inputBinding:
      position: 103
      prefix: --sdpTupleSize
  - id: start
    type:
      - 'null'
      - int
    doc: Index of the first read to begin aligning.
    default: 0
    inputBinding:
      position: 103
      prefix: --start
  - id: stride
    type:
      - 'null'
      - int
    doc: Align one read every 'S' reads.
    default: 1
    inputBinding:
      position: 103
      prefix: --stride
  - id: subsample
    type:
      - 'null'
      - float
    doc: Proportion of reads to randomly subsample (expressed as a decimal) and align.
    default: 0
    inputBinding:
      position: 103
      prefix: --subsample
  - id: suffix_array
    type:
      - 'null'
      - File
    doc: Use the suffix array 'sa' for detecting matches between the reads and the
      reference.
    inputBinding:
      position: 103
      prefix: --sa
  - id: title_table
    type:
      - 'null'
      - File
    doc: Construct a table of reference sequence titles.
    inputBinding:
      position: 103
      prefix: --titleTable
  - id: tuple_counts_table
    type:
      - 'null'
      - File
    doc: A table of tuple counts used to estimate match significance.
    inputBinding:
      position: 103
      prefix: --ctab
  - id: use_ccs
    type:
      - 'null'
      - boolean
    doc: Align the circular consensus sequence (ccs).
    inputBinding:
      position: 103
      prefix: --useccs
  - id: use_ccs_all
    type:
      - 'null'
      - boolean
    doc: Similar to --useccs, except all subreads are aligned.
    inputBinding:
      position: 103
      prefix: --useccsall
  - id: use_ccs_denovo
    type:
      - 'null'
      - boolean
    doc: Align the circular consensus, and report only the alignment of the ccs sequence.
    inputBinding:
      position: 103
      prefix: --useccsdenovo
  - id: use_quality
    type:
      - 'null'
      - boolean
    doc: Use quality values to score gap and mismatch penalties.
    default: false
    inputBinding:
      position: 103
      prefix: --useQuality
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: Write output to 'out'.
    outputBinding:
      glob: $(inputs.out)
  - id: unaligned
    type:
      - 'null'
      - File
    doc: Output reads that are not aligned to 'file'
    outputBinding:
      glob: $(inputs.unaligned)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blasr:5.3.5--0
