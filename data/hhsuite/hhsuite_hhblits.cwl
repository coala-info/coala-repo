cwlVersion: v1.2
class: CommandLineTool
baseCommand: hhblits
label: hhsuite_hhblits
doc: "HMM-HMM-based lightning-fast iterative sequence search\nHHblits is a sensitive,
  general-purpose, iterative sequence search tool that represents\nboth query and
  database sequences by HMMs. You can search HHblits databases starting\nwith a single
  query sequence, a multiple sequence alignment (MSA), or an HMM. HHblits\nprints
  out a ranked list of database HMMs/MSAs and can also generate an MSA by merging\n\
  the significant database HMMs/MSAs onto the query MSA.\n\nTool homepage: https://github.com/soedinglab/hh-suite"
inputs:
  - id: alignment_columns_per_line
    type:
      - 'null'
      - int
    doc: number of columns per line in alignment list (default=80)
    inputBinding:
      position: 101
      prefix: -aliw
  - id: amino_acid_score_mode
    type:
      - 'null'
      - int
    doc: "amino acid score         (tja: template HMM at column j) (def=1)\n     \
      \         0       = log2 Sum(tja*qia/pa)   (pa: aa background frequencies) \
      \   \n              1       = log2 Sum(tja*qia/pqa)  (pqa = 1/2*(pa+ta) )  \
      \             \n              2       = log2 Sum(tja*qia/ta)   (ta: av. aa freqs
      in template)     \n              3       = log2 Sum(tja*qia/qa)   (qa: av. aa
      freqs in query)        \n              5       local amino acid composition
      correction                     "
    inputBinding:
      position: 101
      prefix: -sc
  - id: banded_alignment_overlap
    type:
      - 'null'
      - int
    doc: 'banded alignment: forbid <ovlp> largest diagonals |i-j| of DP matrix (def=0)'
    inputBinding:
      position: 101
      prefix: -ovlp
  - id: context_file
    type:
      - 'null'
      - File
    doc: context file for computing context-specific pseudocounts (default=)
    inputBinding:
      position: 101
      prefix: -contxt
  - id: cs_pseudocount_central_weight
    type:
      - 'null'
      - float
    doc: weight of central position in cs pseudocount mode (def=1.6)
    inputBinding:
      position: 101
      prefix: -csw
  - id: cs_pseudocount_weight_decay
    type:
      - 'null'
      - float
    doc: weight decay parameter for positions in cs pc mode (def=0.9)
    inputBinding:
      position: 101
      prefix: -csb
  - id: database_name
    type:
      - 'null'
      - type: array
        items: string
    doc: "database name (e.g. uniprot20_29Feb2012)\nMultiple databases may be specified
      with '-d <db1> -d <db2> ...'"
    inputBinding:
      position: 101
      prefix: -d
  - id: disable_add_filter
    type:
      - 'null'
      - boolean
    doc: disable all filter steps (except for fast prefiltering)
    inputBinding:
      position: 101
      prefix: -noaddfilter
  - id: disable_prefilter
    type:
      - 'null'
      - boolean
    doc: disable all filter steps
    inputBinding:
      position: 101
      prefix: -noprefilt
  - id: end_gap_penalty_query_residues
    type:
      - 'null'
      - float
    doc: penalty (bits) for end gaps aligned to query residues (def=0.00)
    inputBinding:
      position: 101
      prefix: -egq
  - id: end_gap_penalty_template_residues
    type:
      - 'null'
      - float
    doc: penalty (bits) for end gaps aligned to template residues (def=0.00)
    inputBinding:
      position: 101
      prefix: -egt
  - id: evalue_cutoff
    type:
      - 'null'
      - float
    doc: E-value cutoff for inclusion in result alignment (def=0.001)
    inputBinding:
      position: 101
      prefix: -e
  - id: filter_matrices
    type:
      - 'null'
      - boolean
    doc: filter matrices for similarity to output at most 100 matrices
    inputBinding:
      position: 101
      prefix: -filter_matrices
  - id: gap_extend_penalty_factor_deletes
    type:
      - 'null'
      - float
    doc: factor to increase/reduce gap extend penalty for deletes(def=0.60)
    inputBinding:
      position: 101
      prefix: -gaph
  - id: gap_extend_penalty_factor_inserts
    type:
      - 'null'
      - float
    doc: factor to increase/reduce gap extend penalty for inserts(def=0.60)
    inputBinding:
      position: 101
      prefix: -gapi
  - id: gap_extend_transition_pseudocount_admixture
    type:
      - 'null'
      - float
    doc: Transition pseudocount admixture for extend gap (def=1.00)
    inputBinding:
      position: 101
      prefix: -gape
  - id: gap_open_penalty_factor_deletes
    type:
      - 'null'
      - float
    doc: factor to increase/reduce gap open penalty for deletes (def=0.60)
    inputBinding:
      position: 101
      prefix: -gapf
  - id: gap_open_penalty_factor_inserts
    type:
      - 'null'
      - float
    doc: factor to increase/reduce gap open penalty for inserts (def=0.60)
    inputBinding:
      position: 101
      prefix: -gapg
  - id: gap_open_transition_pseudocount_admixture
    type:
      - 'null'
      - float
    doc: Transition pseudocount admixture for open gap (default=0.15)
    inputBinding:
      position: 101
      prefix: -gapd
  - id: gap_transition_pseudocount_admixture
    type:
      - 'null'
      - float
    doc: Transition pseudocount admixture (def=1.00)
    inputBinding:
      position: 101
      prefix: -gapb
  - id: generate_consensus
    type:
      - 'null'
      - boolean
    doc: generate consensus sequence as master sequence of query MSA 
      (default=don't)
    inputBinding:
      position: 101
      prefix: -add_cons
  - id: global_alignment_mode
    type:
      - 'null'
      - boolean
    doc: use global/local alignment mode for searching/ranking (def=local)
    inputBinding:
      position: 101
      prefix: -glob
  - id: hide_consensus
    type:
      - 'null'
      - boolean
    doc: don't show consensus sequence in alignments (default=show)
    inputBinding:
      position: 101
      prefix: -hide_cons
  - id: hide_dssp_ss
    type:
      - 'null'
      - boolean
    doc: don't show DSSP 2ndary structure in alignments (default=show)
    inputBinding:
      position: 101
      prefix: -hide_dssp
  - id: hide_predicted_ss
    type:
      - 'null'
      - boolean
    doc: don't show predicted 2ndary structure in alignments (default=show)
    inputBinding:
      position: 101
      prefix: -hide_pred
  - id: input_alignment_format
    type:
      - 'null'
      - string
    doc: "use A2M/A3M (default): upper case = Match; lower case = Insert;\n' -' =
      Delete; '.' = gaps aligned to inserts (may be omitted)\nuse FASTA: columns with
      residue in 1st sequence are match states\nuse FASTA: columns with fewer than
      X% gaps are match states"
    inputBinding:
      position: 101
      prefix: -M
  - id: input_query
    type: File
    doc: "input/query: single sequence or multiple sequence alignment (MSA)\nin a3m,
      a2m, or FASTA format, or HMM in hhm format"
    inputBinding:
      position: 101
      prefix: -i
  - id: interim_filter_mode
    type:
      - 'null'
      - string
    doc: "filter sequences of query MSA during merging to avoid early stop (default:
      FULL)\n                  NONE: disables the intermediate filter \n         \
      \         FULL: if an early stop occurs compare filter seqs in an all vs. all
      comparison"
    inputBinding:
      position: 101
      prefix: -interim_filter
  - id: local_alignment_mode
    type:
      - 'null'
      - boolean
    doc: use global/local alignment mode for searching/ranking (def=local)
    inputBinding:
      position: 101
      prefix: -loc
  - id: mac_realign_prob_threshold
    type:
      - 'null'
      - float
    doc: "posterior prob threshold for MAC realignment controlling greedi-\n     \
      \                 ness at alignment ends: 0:global >0.1:local (default=0.35)"
    inputBinding:
      position: 101
      prefix: -mact
  - id: mark_sequences
    type:
      - 'null'
      - boolean
    doc: do not filter out sequences marked by ">@"in their name line
    inputBinding:
      position: 101
      prefix: -mark
  - id: max_alignment_list
    type:
      - 'null'
      - int
    doc: maximum number of alignments in alignment list (default=500)
    inputBinding:
      position: 101
      prefix: -B
  - id: max_alternative_alignments
    type:
      - 'null'
      - int
    doc: show up to this many alternative alignments with raw score > 
      smin(def=4)
    inputBinding:
      position: 101
      prefix: -alt
  - id: max_diversity_neff
    type:
      - 'null'
      - float
    doc: "skip further search iterations when diversity Neff of query MSA \n     \
      \           becomes larger than neffmax (default=20.0)"
    inputBinding:
      position: 101
      prefix: -neffmax
  - id: max_evalue_summary
    type:
      - 'null'
      - float
    doc: maximum E-value in summary and alignment list (default=1E+06)
    inputBinding:
      position: 101
      prefix: -E
  - id: max_hits_to_realign
    type:
      - 'null'
      - int
    doc: realign max. <int> hits (default=500)
    inputBinding:
      position: 101
      prefix: -realign_max
  - id: max_hmm_columns
    type:
      - 'null'
      - int
    doc: max number of HMM columns (def=20001)
    inputBinding:
      position: 101
      prefix: -maxres
  - id: max_input_sequences
    type:
      - 'null'
      - int
    doc: max number of input rows (def=65535)
    inputBinding:
      position: 101
      prefix: -maxseq
  - id: max_pairwise_identity
    type:
      - 'null'
      - int
    doc: maximum pairwise sequence identity (def=90)
    inputBinding:
      position: 101
      prefix: -id
  - id: max_prefilter_hits
    type:
      - 'null'
      - int
    doc: max number of hits allowed to pass 2nd prefilter (default=20000)
    inputBinding:
      position: 101
      prefix: -maxfilt
  - id: max_realign_memory_gb
    type:
      - 'null'
      - float
    doc: limit memory for realignment (in GB) (def=3.0)
    inputBinding:
      position: 101
      prefix: -maxmem
  - id: max_sequences_displayed
    type:
      - 'null'
      - int
    doc: max. number of query/template sequences displayed (default=1)
    inputBinding:
      position: 101
      prefix: -seq
  - id: max_summary_hits
    type:
      - 'null'
      - int
    doc: maximum number of lines in summary hit list (default=500)
    inputBinding:
      position: 101
      prefix: -Z
  - id: min_alignment_list
    type:
      - 'null'
      - int
    doc: minimum number of alignments in alignment list (default=10)
    inputBinding:
      position: 101
      prefix: -b
  - id: min_coverage_master
    type:
      - 'null'
      - int
    doc: minimum coverage with master sequence (%) (def=0)
    inputBinding:
      position: 101
      prefix: -cov
  - id: min_diverse_sequences
    type:
      - 'null'
      - int
    doc: "filter MSAs by selecting most diverse set of sequences, keeping \n     \
      \           at least this many seqs in each MSA block of length 50 \n      \
      \          Zero and non-numerical values turn off the filtering. (def=1000)"
    inputBinding:
      position: 101
      prefix: -diff
  - id: min_identity_master
    type:
      - 'null'
      - int
    doc: minimum sequence identity with master sequence (%) (def=0)
    inputBinding:
      position: 101
      prefix: -qid
  - id: min_prefilter_hits
    type:
      - 'null'
      - int
    doc: min number of hits to pass prefilter (default=100)
    inputBinding:
      position: 101
      prefix: -min_prefilter_hits
  - id: min_probability_summary
    type:
      - 'null'
      - int
    doc: minimum probability in summary and alignment list (default=20)
    inputBinding:
      position: 101
      prefix: -p
  - id: min_raw_score_alt_alignments
    type:
      - 'null'
      - float
    doc: minimum raw score for alternative alignments (def=20.0)
    inputBinding:
      position: 101
      prefix: -smin
  - id: min_score_per_column_master
    type:
      - 'null'
      - float
    doc: minimum score per column with master sequence (default=-20.0)
    inputBinding:
      position: 101
      prefix: -qsc
  - id: min_summary_hits
    type:
      - 'null'
      - int
    doc: minimum number of lines in summary hit list (default=10)
    inputBinding:
      position: 101
      prefix: -z
  - id: neutralize_tags
    type:
      - 'null'
      - boolean
    doc: "do NOT neutralize His-, C-myc-, FLAG-tags, and trypsin\nrecognition sequence
      to background distribution (def=-notags)"
    inputBinding:
      position: 101
      prefix: -tags
  - id: no_neutralize_tags
    type:
      - 'null'
      - boolean
    doc: "do NOT neutralize His-, C-myc-, FLAG-tags, and trypsin\nrecognition sequence
      to background distribution (def=-notags)"
    inputBinding:
      position: 101
      prefix: -notags
  - id: no_realign
    type:
      - 'null'
      - boolean
    doc: do NOT realign displayed hits with MAC algorithm (def=realign)
    inputBinding:
      position: 101
      prefix: -norealign
  - id: num_cpus
    type:
      - 'null'
      - int
    doc: number of CPUs to use (for shared memory SMPs) (default=2)
    inputBinding:
      position: 101
      prefix: -cpu
  - id: num_iterations
    type:
      - 'null'
      - int
    doc: number of iterations (default=2)
    inputBinding:
      position: 101
      prefix: -n
  - id: pair_correlations_weight
    type:
      - 'null'
      - float
    doc: weight of term for pair correlations (def=0.10)
    inputBinding:
      position: 101
      prefix: -corr
  - id: pc_hhm_contxt_a
    type:
      - 'null'
      - float
    doc: overall pseudocount admixture (def=0.9)
    inputBinding:
      position: 101
      prefix: -pc_hhm_contxt_a
  - id: pc_hhm_contxt_b
    type:
      - 'null'
      - float
    doc: Neff threshold value for mode 2 (def=4.0)
    inputBinding:
      position: 101
      prefix: -pc_hhm_contxt_b
  - id: pc_hhm_contxt_c
    type:
      - 'null'
      - float
    doc: extinction exponent c for mode 2 (def=1.0)
    inputBinding:
      position: 101
      prefix: -pc_hhm_contxt_c
  - id: pc_hhm_contxt_mode
    type:
      - 'null'
      - int
    doc: "position dependence of pc admixture 'tau' (pc mode, default=2)\n       \
      \        0: no pseudo counts:    tau = 0                                  \n\
      \               1: constant             tau = a                            \
      \      \n               2: diversity-dependent: tau = a/(1+((Neff[i]-1)/b)^c)\
      \            \n               3: CSBlast admixture:   tau = a(1+b)/(Neff[i]+b)\
      \                 \n               (Neff[i]: number of effective seqs in local
      MSA around column i)"
    inputBinding:
      position: 101
      prefix: -pc_hhm_contxt_mode
  - id: pc_hhm_nocontxt_a
    type:
      - 'null'
      - float
    doc: overall pseudocount admixture (def=1.0)
    inputBinding:
      position: 101
      prefix: -pc_hhm_nocontxt_a
  - id: pc_hhm_nocontxt_b
    type:
      - 'null'
      - float
    doc: Neff threshold value for mode 2 (def=1.5)
    inputBinding:
      position: 101
      prefix: -pc_hhm_nocontxt_b
  - id: pc_hhm_nocontxt_c
    type:
      - 'null'
      - float
    doc: extinction exponent c for mode 2 (def=1.0)
    inputBinding:
      position: 101
      prefix: -pc_hhm_nocontxt_c
  - id: pc_hhm_nocontxt_mode
    type:
      - 'null'
      - int
    doc: "position dependence of pc admixture 'tau' (pc mode, default=2)\n       \
      \        0: no pseudo counts:    tau = 0                                  \n\
      \               1: constant             tau = a                            \
      \      \n               2: diversity-dependent: tau = a/(1+((Neff[i]-1)/b)^c)\
      \            \n               (Neff[i]: number of effective seqs in local MSA
      around column i)"
    inputBinding:
      position: 101
      prefix: -pc_hhm_nocontxt_mode
  - id: pc_prefilter_contxt_a
    type:
      - 'null'
      - float
    doc: overall pseudocount admixture (def=0.8)
    inputBinding:
      position: 101
      prefix: -pc_prefilter_contxt_a
  - id: pc_prefilter_contxt_b
    type:
      - 'null'
      - float
    doc: Neff threshold value for mode 2 (def=2.0)
    inputBinding:
      position: 101
      prefix: -pc_prefilter_contxt_b
  - id: pc_prefilter_contxt_c
    type:
      - 'null'
      - float
    doc: extinction exponent c for mode 2 (def=1.0)
    inputBinding:
      position: 101
      prefix: -pc_prefilter_contxt_c
  - id: pc_prefilter_contxt_mode
    type:
      - 'null'
      - int
    doc: "position dependence of pc admixture 'tau' (pc mode, default=3)\n       \
      \        0: no pseudo counts:    tau = 0                                  \n\
      \               1: constant             tau = a                            \
      \      \n               2: diversity-dependent: tau = a/(1+((Neff[i]-1)/b)^c)\
      \            \n               3: CSBlast admixture:   tau = a(1+b)/(Neff[i]+b)\
      \                 \n               (Neff[i]: number of effective seqs in local
      MSA around column i)"
    inputBinding:
      position: 101
      prefix: -pc_prefilter_contxt_mode
  - id: pc_prefilter_nocontxt_a
    type:
      - 'null'
      - float
    doc: overall pseudocount admixture (def=1.0)
    inputBinding:
      position: 101
      prefix: -pc_prefilter_nocontxt_a
  - id: pc_prefilter_nocontxt_b
    type:
      - 'null'
      - float
    doc: Neff threshold value for mode 2 (def=1.5)
    inputBinding:
      position: 101
      prefix: -pc_prefilter_nocontxt_b
  - id: pc_prefilter_nocontxt_c
    type:
      - 'null'
      - float
    doc: extinction exponent c for mode 2 (def=1.0)
    inputBinding:
      position: 101
      prefix: -pc_prefilter_nocontxt_c
  - id: pc_prefilter_nocontxt_mode
    type:
      - 'null'
      - int
    doc: "position dependence of pc admixture 'tau' (pc mode, default=2)\n       \
      \        0: no pseudo counts:    tau = 0                                  \n\
      \               1: constant             tau = a                            \
      \      \n               2: diversity-dependent: tau = a/(1+((Neff[i]-1)/b)^c)\
      \            \n               (Neff[i]: number of effective seqs in local MSA
      around column i)"
    inputBinding:
      position: 101
      prefix: -pc_prefilter_nocontxt_mode
  - id: prefilter_bitfactor
    type:
      - 'null'
      - float
    doc: prefilter scores are in units of 1 bit / pre_bitfactor (default=4)
    inputBinding:
      position: 101
      prefix: -pre_bitfactor
  - id: prefilter_gap_extend_penalty
    type:
      - 'null'
      - int
    doc: gap extend penalty in prefilter Smith-Waterman alignment (default=4)
    inputBinding:
      position: 101
      prefix: -pre_gap_extend
  - id: prefilter_gap_open_penalty
    type:
      - 'null'
      - int
    doc: gap open penalty in prefilter Smith-Waterman alignment (default=20)
    inputBinding:
      position: 101
      prefix: -pre_gap_open
  - id: prefilter_score_offset
    type:
      - 'null'
      - int
    doc: offset on sequence profile scores in prefilter S-W alignment 
      (default=50)
    inputBinding:
      position: 101
      prefix: -pre_score_offset
  - id: prefilter_smith_waterman_evalue_threshold
    type:
      - 'null'
      - float
    doc: max E-value threshold of Smith-Waterman prefilter score 
      (default=1000.0)
    inputBinding:
      position: 101
      prefix: -pre_evalue_thresh
  - id: prefilter_ungapped_score_threshold
    type:
      - 'null'
      - int
    doc: min score threshold of ungapped prefilter (default=10)
    inputBinding:
      position: 101
      prefix: -prepre_smax_thresh
  - id: premerge_hits
    type:
      - 'null'
      - int
    doc: merge <int> hits to query MSA before aligning remaining hits (def=3)
    inputBinding:
      position: 101
      prefix: -premerge
  - id: profile_profile_score_offset
    type:
      - 'null'
      - float
    doc: profile-profile score offset (def=-0.03)
    inputBinding:
      position: 101
      prefix: -shift
  - id: realign_hits
    type:
      - 'null'
      - boolean
    doc: realign displayed hits with max. accuracy (MAC) algorithm
    inputBinding:
      position: 101
      prefix: -realign
  - id: realign_old_hits
    type:
      - 'null'
      - boolean
    doc: realign hits from previous iterations
    inputBinding:
      position: 101
      prefix: -realign_old_hits
  - id: show_all_sequences
    type:
      - 'null'
      - boolean
    doc: show all sequences in result MSA; do not filter result MSA
    inputBinding:
      position: 101
      prefix: -all
  - id: show_ss_confidence
    type:
      - 'null'
      - boolean
    doc: show confidences for predicted 2ndary structure in alignments
    inputBinding:
      position: 101
      prefix: -show_ssconf
  - id: ss_confusion_matrix_weight
    type:
      - 'null'
      - float
    doc: ss confusion matrix = (1-ssa)*I + ssa*psipred-confusion-matrix 
      [def=1.00)
    inputBinding:
      position: 101
      prefix: -ssa
  - id: ss_score_weight
    type:
      - 'null'
      - float
    doc: weight of ss score  (def=0.11)
    inputBinding:
      position: 101
      prefix: -ssw
  - id: ss_scoring_mode
    type:
      - 'null'
      - int
    doc: "0:   no ss scoring                                             \n      \
      \                1,2: ss scoring after or during alignment  [default=2]    \
      \     \n                      3,4: ss scoring after or during alignment, predicted
      vs. predicted"
    inputBinding:
      position: 101
      prefix: -ssm
  - id: target_diversity_msa
    type:
      - 'null'
      - int
    doc: target diversity of multiple sequence alignment (default=off)
    inputBinding:
      position: 101
      prefix: -neff
  - id: use_global_sequence_weighting
    type:
      - 'null'
      - boolean
    doc: use global sequence weighting for realignment!
    inputBinding:
      position: 101
      prefix: -wg
  - id: use_substitution_matrix
    type:
      - 'null'
      - boolean
    doc: use substitution-matrix instead of context-specific pseudocounts
    inputBinding:
      position: 101
      prefix: -nocontxt
  - id: verbose_mode
    type:
      - 'null'
      - int
    doc: 'verbose mode: 0:no screen output  1:only warings  2: verbose (def=2)'
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: output_standard
    type:
      - 'null'
      - File
    doc: write results in standard format to file (default=<infile.hhr>)
    outputBinding:
      glob: $(inputs.output_standard)
  - id: output_a3m
    type:
      - 'null'
      - File
    doc: write result MSA with significant matches in a3m format
    outputBinding:
      glob: $(inputs.output_a3m)
  - id: output_psi
    type:
      - 'null'
      - File
    doc: write result MSA of significant matches in PSI-BLAST format
    outputBinding:
      glob: $(inputs.output_psi)
  - id: output_hhm
    type:
      - 'null'
      - File
    doc: write HHM file for result MSA of significant matches
    outputBinding:
      glob: $(inputs.output_hhm)
  - id: output_alis
    type:
      - 'null'
      - File
    doc: write MSAs in A3M format after each iteration
    outputBinding:
      glob: $(inputs.output_alis)
  - id: output_blasttab
    type:
      - 'null'
      - File
    doc: "write result in tabular BLAST format (compatible to -m 8 or -outfmt 6 output)\n\
      \                  1      2      3           4         5        6      8   \
      \ 9      10   11   12\n                  'query target #match/tLen #mismatch
      #gapOpen qstart qend tstart tend eval score'"
    outputBinding:
      glob: $(inputs.output_blasttab)
  - id: output_fasta
    type:
      - 'null'
      - File
    doc: write pairwise alignments in FASTA xor A2M (-Oa2m) xor A3M (-Oa3m) 
      format
    outputBinding:
      glob: $(inputs.output_fasta)
  - id: scores_file
    type:
      - 'null'
      - File
    doc: write scores for all pairwise comparisons to file
    outputBinding:
      glob: $(inputs.scores_file)
  - id: output_tabular_alignments
    type:
      - 'null'
      - File
    doc: write all alignments in tabular layout to file
    outputBinding:
      glob: $(inputs.output_tabular_alignments)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hhsuite:3.3.0--h503566f_15
