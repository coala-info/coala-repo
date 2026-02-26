cwlVersion: v1.2
class: CommandLineTool
baseCommand: hhsearch
label: hhsuite_hhsearch
doc: "Search a database of HMMs with a query alignment or query HMM\n\nTool homepage:
  https://github.com/soedinglab/hh-suite"
inputs:
  - id: alignment_columns_per_line
    type:
      - 'null'
      - int
    doc: number of columns per line in alignment list
    default: 80
    inputBinding:
      position: 101
      prefix: -aliw
  - id: alignment_mode
    type:
      - 'null'
      - boolean
    doc: use global alignment mode for searching/ranking
    inputBinding:
      position: 101
      prefix: -glob
  - id: alignment_mode
    type:
      - 'null'
      - boolean
    doc: use local alignment mode for searching/ranking
    inputBinding:
      position: 101
      prefix: -loc
  - id: amino_acid_score_type
    type:
      - 'null'
      - int
    doc: amino acid score
    default: 1
    inputBinding:
      position: 101
      prefix: -sc
  - id: banded_alignment_diagonals
    type:
      - 'null'
      - int
    doc: 'banded alignment: forbid <ovlp> largest diagonals |i-j| of DP matrix'
    default: 0
    inputBinding:
      position: 101
      prefix: -ovlp
  - id: context_file
    type:
      - 'null'
      - File
    doc: context file for computing context-specific pseudocounts
    inputBinding:
      position: 101
      prefix: -contxt
  - id: cs_pseudocount_central_weight
    type:
      - 'null'
      - float
    doc: weight of central position in cs pseudocount mode
    default: 1.6
    inputBinding:
      position: 101
      prefix: -csw
  - id: cs_pseudocount_decay_weight
    type:
      - 'null'
      - float
    doc: weight decay parameter for positions in cs pc mode
    default: 0.9
    inputBinding:
      position: 101
      prefix: -csb
  - id: database
    type:
      type: array
      items: string
    doc: database name (e.g. uniprot20_29Feb2012)
    inputBinding:
      position: 101
      prefix: -d
  - id: e_value_cutoff
    type:
      - 'null'
      - float
    doc: E-value cutoff for inclusion in result alignment
    default: 0.001
    inputBinding:
      position: 101
      prefix: -e
  - id: end_gap_penalty_query
    type:
      - 'null'
      - float
    doc: penalty (bits) for end gaps aligned to query residues
    default: 0.0
    inputBinding:
      position: 101
      prefix: -egq
  - id: end_gap_penalty_template
    type:
      - 'null'
      - float
    doc: penalty (bits) for end gaps aligned to template residues
    default: 0.0
    inputBinding:
      position: 101
      prefix: -egt
  - id: exclude_query_positions
    type:
      - 'null'
      - string
    doc: exclude query positions from the alignment, e.g. '1-33,97-168'
    inputBinding:
      position: 101
      prefix: -excl
  - id: filter_diverse_sequences
    type:
      - 'null'
      - int
    doc: filter MSAs by selecting most diverse set of sequences, keeping at 
      least this many seqs in each MSA block of length 50
    default: 100
    inputBinding:
      position: 101
      prefix: -diff
  - id: gap_extend_penalty_delete_factor
    type:
      - 'null'
      - float
    doc: factor to increase/reduce gap extend penalty for deletes
    default: 0.6
    inputBinding:
      position: 101
      prefix: -gaph
  - id: gap_extend_penalty_insert_factor
    type:
      - 'null'
      - float
    doc: factor to increase/reduce gap extend penalty for inserts
    default: 0.6
    inputBinding:
      position: 101
      prefix: -gapi
  - id: gap_extend_pseudocount_admixture
    type:
      - 'null'
      - float
    doc: Transition pseudocount admixture for extend gap
    default: 1.0
    inputBinding:
      position: 101
      prefix: -gape
  - id: gap_open_penalty_delete_factor
    type:
      - 'null'
      - float
    doc: factor to increase/reduce gap open penalty for deletes
    default: 0.6
    inputBinding:
      position: 101
      prefix: -gapf
  - id: gap_open_penalty_insert_factor
    type:
      - 'null'
      - float
    doc: factor to increase/reduce gap open penalty for inserts
    default: 0.6
    inputBinding:
      position: 101
      prefix: -gapg
  - id: gap_open_pseudocount_admixture
    type:
      - 'null'
      - float
    doc: Transition pseudocount admixture for open gap
    default: 0.15
    inputBinding:
      position: 101
      prefix: -gapd
  - id: gap_transition_pseudocount_admixture
    type:
      - 'null'
      - float
    doc: Transition pseudocount admixture
    default: 1.0
    inputBinding:
      position: 101
      prefix: -gapb
  - id: generate_consensus
    type:
      - 'null'
      - boolean
    doc: generate consensus sequence as master sequence of query MSA
    inputBinding:
      position: 101
      prefix: -add_cons
  - id: hide_consensus
    type:
      - 'null'
      - boolean
    doc: don't show consensus sequence in alignments
    inputBinding:
      position: 101
      prefix: -hide_cons
  - id: hide_dssp
    type:
      - 'null'
      - boolean
    doc: don't show DSSP 2ndary structure in alignments
    inputBinding:
      position: 101
      prefix: -hide_dssp
  - id: hide_predicted_ss
    type:
      - 'null'
      - boolean
    doc: don't show predicted 2ndary structure in alignments
    inputBinding:
      position: 101
      prefix: -hide_pred
  - id: input_alignment_format
    type:
      - 'null'
      - string
    doc: Input alignment format
    inputBinding:
      position: 101
      prefix: -M
  - id: mac_realignment_threshold
    type:
      - 'null'
      - float
    doc: 'posterior prob threshold for MAC realignment controlling greediness at alignment
      ends: 0:global >0.1:local'
    default: 0.35
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
    doc: maximum number of alignments in alignment list
    default: 500
    inputBinding:
      position: 101
      prefix: -B
  - id: max_alternative_alignments
    type:
      - 'null'
      - int
    doc: show up to this many alternative alignments with raw score > smin
    default: 4
    inputBinding:
      position: 101
      prefix: -alt
  - id: max_e_value_summary
    type:
      - 'null'
      - float
    doc: maximum E-value in summary and alignment list
    default: '1E+06'
    inputBinding:
      position: 101
      prefix: -E
  - id: max_hmm_columns
    type:
      - 'null'
      - int
    doc: max number of HMM columns
    default: 20001
    inputBinding:
      position: 101
      prefix: -maxres
  - id: max_input_sequences
    type:
      - 'null'
      - int
    doc: max number of input rows
    default: 65535
    inputBinding:
      position: 101
      prefix: -maxseq
  - id: max_memory_realignment
    type:
      - 'null'
      - float
    doc: limit memory for realignment (in GB)
    default: 3.0
    inputBinding:
      position: 101
      prefix: -maxmem
  - id: max_pairwise_identity
    type:
      - 'null'
      - float
    doc: maximum pairwise sequence identity
    default: 90.0
    inputBinding:
      position: 101
      prefix: -id
  - id: max_query_template_sequences
    type:
      - 'null'
      - int
    doc: max. number of query/template sequences displayed
    default: 1
    inputBinding:
      position: 101
      prefix: -seq
  - id: max_realign_hits
    type:
      - 'null'
      - int
    doc: realign max. <int> hits
    default: 500
    inputBinding:
      position: 101
      prefix: -realign_max
  - id: max_summary_hits
    type:
      - 'null'
      - int
    doc: maximum number of lines in summary hit list
    default: 500
    inputBinding:
      position: 101
      prefix: -Z
  - id: min_alignment_list
    type:
      - 'null'
      - int
    doc: minimum number of alignments in alignment list
    default: 10
    inputBinding:
      position: 101
      prefix: -b
  - id: min_coverage
    type:
      - 'null'
      - float
    doc: minimum coverage with master sequence (%)
    default: 0.0
    inputBinding:
      position: 101
      prefix: -cov
  - id: min_identity_master
    type:
      - 'null'
      - float
    doc: minimum sequence identity with master sequence (%)
    default: 0.0
    inputBinding:
      position: 101
      prefix: -qid
  - id: min_probability
    type:
      - 'null'
      - float
    doc: minimum probability in summary and alignment list
    default: 20.0
    inputBinding:
      position: 101
      prefix: -p
  - id: min_raw_score_alt_alignments
    type:
      - 'null'
      - float
    doc: minimum raw score for alternative alignments
    default: 20.0
    inputBinding:
      position: 101
      prefix: -smin
  - id: min_score_per_column
    type:
      - 'null'
      - float
    doc: minimum score per column with master sequence
    default: -20.0
    inputBinding:
      position: 101
      prefix: -qsc
  - id: min_summary_hits
    type:
      - 'null'
      - int
    doc: minimum number of lines in summary hit list
    default: 10
    inputBinding:
      position: 101
      prefix: -z
  - id: neutralize_tags
    type:
      - 'null'
      - boolean
    doc: do NOT neutralize His-, C-myc-, FLAG-tags, and trypsin recognition 
      sequence to background distribution
    default: true
    inputBinding:
      position: 101
      prefix: -notags
  - id: neutralize_tags
    type:
      - 'null'
      - boolean
    doc: do neutralize His-, C-myc-, FLAG-tags, and trypsin recognition sequence
      to background distribution
    inputBinding:
      position: 101
      prefix: -tags
  - id: num_cpus
    type:
      - 'null'
      - int
    doc: number of CPUs to use (for shared memory SMPs)
    default: 2
    inputBinding:
      position: 101
      prefix: -cpu
  - id: pair_correlations_weight
    type:
      - 'null'
      - float
    doc: weight of term for pair correlations
    default: 0.1
    inputBinding:
      position: 101
      prefix: -corr
  - id: pc_hhm_contxt_a
    type:
      - 'null'
      - float
    doc: overall pseudocount admixture
    default: 0.9
    inputBinding:
      position: 101
      prefix: -pc_hhm_contxt_a
  - id: pc_hhm_contxt_b
    type:
      - 'null'
      - float
    doc: Neff threshold value for mode 2
    default: 4.0
    inputBinding:
      position: 101
      prefix: -pc_hhm_contxt_b
  - id: pc_hhm_contxt_c
    type:
      - 'null'
      - float
    doc: extinction exponent c for mode 2
    default: 1.0
    inputBinding:
      position: 101
      prefix: -pc_hhm_contxt_c
  - id: pc_hhm_contxt_mode
    type:
      - 'null'
      - int
    doc: position dependence of pc admixture 'tau' (pc mode, default=2)
    default: 2
    inputBinding:
      position: 101
      prefix: -pc_hhm_contxt_mode
  - id: pc_hhm_nocontxt_a
    type:
      - 'null'
      - float
    doc: overall pseudocount admixture
    default: 1.0
    inputBinding:
      position: 101
      prefix: -pc_hhm_nocontxt_a
  - id: pc_hhm_nocontxt_b
    type:
      - 'null'
      - float
    doc: Neff threshold value for mode 2
    default: 1.5
    inputBinding:
      position: 101
      prefix: -pc_hhm_nocontxt_b
  - id: pc_hhm_nocontxt_c
    type:
      - 'null'
      - float
    doc: extinction exponent c for mode 2
    default: 1.0
    inputBinding:
      position: 101
      prefix: -pc_hhm_nocontxt_c
  - id: pc_hhm_nocontxt_mode
    type:
      - 'null'
      - int
    doc: position dependence of pc admixture 'tau' (pc mode, default=2)
    default: 2
    inputBinding:
      position: 101
      prefix: -pc_hhm_nocontxt_mode
  - id: profile_profile_score_offset
    type:
      - 'null'
      - float
    doc: profile-profile score offset
    default: -0.03
    inputBinding:
      position: 101
      prefix: -shift
  - id: query_alignment
    type: File
    doc: input/query multiple sequence alignment (a2m, a3m, FASTA) or HMM
    inputBinding:
      position: 101
      prefix: -i
  - id: realign_displayed_hits
    type:
      - 'null'
      - boolean
    doc: realign displayed hits with max. accuracy (MAC) algorithm
    inputBinding:
      position: 101
      prefix: -realign
  - id: realign_hits
    type:
      - 'null'
      - boolean
    doc: do NOT realign displayed hits with MAC algorithm
    inputBinding:
      position: 101
      prefix: -norealign
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
  - id: ss_score_weight
    type:
      - 'null'
      - float
    doc: weight of ss score
    default: 0.11
    inputBinding:
      position: 101
      prefix: -ssw
  - id: ss_scoring_mode
    type:
      - 'null'
      - int
    doc: ss scoring mode
    default: 2
    inputBinding:
      position: 101
      prefix: -ssm
  - id: ss_substitution_matrix_weight
    type:
      - 'null'
      - float
    doc: SS substitution matrix weight
    default: 1.0
    inputBinding:
      position: 101
      prefix: -ssa
  - id: target_diversity
    type:
      - 'null'
      - int
    doc: target diversity of multiple sequence alignment
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
    doc: 'verbose mode: 0:no screen output 1:only warnings 2: verbose'
    default: 2
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: write results in standard format to file
    outputBinding:
      glob: $(inputs.output_file)
  - id: output_a3m_file
    type:
      - 'null'
      - File
    doc: write result MSA with significant matches in a3m format
    outputBinding:
      glob: $(inputs.output_a3m_file)
  - id: output_blasttab_file
    type:
      - 'null'
      - File
    doc: write result in tabular BLAST format (compatible to -m 8 or -outfmt 6 
      output)
    outputBinding:
      glob: $(inputs.output_blasttab_file)
  - id: output_psi_file
    type:
      - 'null'
      - File
    doc: write result MSA of significant matches in PSI-BLAST format
    outputBinding:
      glob: $(inputs.output_psi_file)
  - id: output_hhm_file
    type:
      - 'null'
      - File
    doc: write HHM file for result MSA of significant matches
    outputBinding:
      glob: $(inputs.output_hhm_file)
  - id: output_fasta_format
    type:
      - 'null'
      - File
    doc: write pairwise alignments in FASTA xor A2M (-Oa2m) xor A3M (-Oa3m) 
      format
    outputBinding:
      glob: $(inputs.output_fasta_format)
  - id: scores_file
    type:
      - 'null'
      - File
    doc: write scores for all pairwise comparisons to file
    outputBinding:
      glob: $(inputs.scores_file)
  - id: all_alignments_tabular_file
    type:
      - 'null'
      - File
    doc: write all alignments in tabular layout to file
    outputBinding:
      glob: $(inputs.all_alignments_tabular_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hhsuite:3.3.0--h503566f_15
