cwlVersion: v1.2
class: CommandLineTool
baseCommand: kma
label: kma
doc: "KMA-1.6.8 maps and/or aligns raw reads to a template database.\n\nTool homepage:
  https://bitbucket.org/genomicepidemiology/kma"
inputs:
  - id: base_conclave_on_template_mappings
    type:
      - 'null'
      - boolean
    doc: Base ConClave on template mappings
    default: false
    inputBinding:
      position: 101
      prefix: -mem_mode
  - id: bootstrap_subsequence
    type:
      - 'null'
      - boolean
    doc: Bootstrap sub-sequence
    default: false
    inputBinding:
      position: 101
      prefix: -boot
  - id: circular_alignments
    type:
      - 'null'
      - boolean
    doc: Circular alignments
    default: false
    inputBinding:
      position: 101
      prefix: -ca
  - id: citation
    type:
      - 'null'
      - boolean
    doc: Citation
    inputBinding:
      position: 101
      prefix: -c
  - id: conclave_version
    type:
      - 'null'
      - int
    doc: ConClave version
    default: 1
    inputBinding:
      position: 101
      prefix: -ConClave
  - id: count_kmers_over_pseudo_alignment
    type:
      - 'null'
      - boolean
    doc: Count k-mers over pseudo alignment
    default: false
    inputBinding:
      position: 101
      prefix: -ck
  - id: exhaustive_kmer_search
    type:
      - 'null'
      - boolean
    doc: Searh kmers exhaustively
    default: false
    inputBinding:
      position: 101
      prefix: -ex_mode
  - id: extra_status
    type:
      - 'null'
      - boolean
    doc: Extra status
    default: false
    inputBinding:
      position: 101
      prefix: -status
  - id: indel_calling_ont
    type:
      - 'null'
      - boolean
    doc: Altered indel calling for ONT data
    default: false
    inputBinding:
      position: 101
      prefix: -bcNano
  - id: input_interleaved
    type:
      - 'null'
      - File
    doc: Interleaved input(s)
    inputBinding:
      position: 101
      prefix: -int
  - id: input_paired_end
    type:
      - 'null'
      - type: array
        items: File
    doc: Paired end input(s)
    inputBinding:
      position: 101
      prefix: -ipe
  - id: input_single_end
    type:
      - 'null'
      - File
    doc: Single end input(s)
    default: stdin
    inputBinding:
      position: 101
      prefix: -i
  - id: kmer_size
    type:
      - 'null'
      - string
    doc: K-mersize
    default: DB defined
    inputBinding:
      position: 101
      prefix: -k
  - id: length_corrected_template_chaining
    type:
      - 'null'
      - boolean
    doc: Length corrected template chaining
    default: false
    inputBinding:
      position: 101
      prefix: -lc
  - id: maintain_insignificant_gaps
    type:
      - 'null'
      - boolean
    doc: Maintain insignificant gaps
    default: false
    inputBinding:
      position: 101
      prefix: -bcg
  - id: map_everything_to_one_template
    type:
      - 'null'
      - string
    doc: Map everything to one template
    default: False/0
    inputBinding:
      position: 101
      prefix: -Mt1
  - id: max_fragments_in_memory
    type:
      - 'null'
      - int
    doc: Max number of fragments to store in memory
    default: 1000000
    inputBinding:
      position: 101
      prefix: -mf
  - id: max_length_se
    type:
      - 'null'
      - int
    doc: Maximum length on se
    default: 2147483647
    inputBinding:
      position: 101
      prefix: -xl
  - id: max_overlap_between_templates
    type:
      - 'null'
      - float
    doc: Max overlap between templates
    default: 0.1
    inputBinding:
      position: 101
      prefix: -mct
  - id: memory_map_comp_b
    type:
      - 'null'
      - boolean
    doc: Memory map *.comp.b
    default: false
    inputBinding:
      position: 101
      prefix: -mmap
  - id: min_alignment_length
    type:
      - 'null'
      - int
    doc: Minimum alignment length
    default: 16
    inputBinding:
      position: 101
      prefix: -ml
  - id: min_avg_quality_score
    type:
      - 'null'
      - int
    doc: Minimum avg. quality score
    default: 0
    inputBinding:
      position: 101
      prefix: -eq
  - id: min_consensus_id
    type:
      - 'null'
      - float
    doc: Minimum consensus ID
    default: 1.0%
    inputBinding:
      position: 101
      prefix: -ID
  - id: min_depth
    type:
      - 'null'
      - float
    doc: Minimum depth
    default: 0.0
    inputBinding:
      position: 101
      prefix: -md
  - id: min_depth_call_bases
    type:
      - 'null'
      - int
    doc: Minimum depth to cal bases
    default: 1
    inputBinding:
      position: 101
      prefix: -bcd
  - id: min_internal_phred_score
    type:
      - 'null'
      - int
    doc: Minimum internal phred score
    default: 0
    inputBinding:
      position: 101
      prefix: -mi
  - id: min_length_trimming
    type:
      - 'null'
      - int
    doc: Minimum length
    default: 16
    inputBinding:
      position: 101
      prefix: -ml
  - id: min_mapping_quality_chaining
    type:
      - 'null'
      - int
    doc: Minimum mapping quality
    default: 0
    inputBinding:
      position: 101
      prefix: -mq
  - id: min_phred_score
    type:
      - 'null'
      - int
    doc: Minimum phred score
    default: 20
    inputBinding:
      position: 101
      prefix: -mp
  - id: min_query_coverage
    type:
      - 'null'
      - float
    doc: Minimum query coverage
    default: 0.0
    inputBinding:
      position: 101
      prefix: -mrc
  - id: min_relative_alignment_score
    type:
      - 'null'
      - float
    doc: Minimum relative alignment score
    default: 0.5
    inputBinding:
      position: 101
      prefix: -mrs
  - id: min_support_call_bases
    type:
      - 'null'
      - int
    doc: Minimum support to call bases
    default: 0
    inputBinding:
      position: 101
      prefix: -bc
  - id: no_aln
    type:
      - 'null'
      - boolean
    doc: No aln file
    default: false
    inputBinding:
      position: 101
      prefix: -na
  - id: no_consensus
    type:
      - 'null'
      - boolean
    doc: No consensus file
    default: false
    inputBinding:
      position: 101
      prefix: -nc
  - id: no_frag
    type:
      - 'null'
      - boolean
    doc: No frag file
    default: false
    inputBinding:
      position: 101
      prefix: -nf
  - id: one_query_to_one_template
    type:
      - 'null'
      - boolean
    doc: One query to one template
    default: false
    inputBinding:
      position: 101
      prefix: -1t1
  - id: only_count_kmers
    type:
      - 'null'
      - boolean
    doc: Only count kmers
    default: false
    inputBinding:
      position: 101
      prefix: -Sparse
  - id: output_all_templates
    type:
      - 'null'
      - boolean
    doc: Output all template mappings
    default: false
    inputBinding:
      position: 101
      prefix: -a
  - id: output_features
    type:
      - 'null'
      - boolean
    doc: Output additional features
    default: false
    inputBinding:
      position: 101
      prefix: -ef
  - id: output_matrix
    type:
      - 'null'
      - boolean
    doc: Output assembly matrix
    default: false
    inputBinding:
      position: 101
      prefix: -matrix
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Output prefix
    inputBinding:
      position: 101
      prefix: -o
  - id: output_sam
    type:
      - 'null'
      - boolean
    doc: Output sam, 4/2096 for mapped/aligned
    default: false
    inputBinding:
      position: 101
      prefix: -sam
  - id: output_vcf
    type:
      - 'null'
      - boolean
    doc: Output vcf file, 2 to apply FT
    default: false
    inputBinding:
      position: 101
      prefix: -vcf
  - id: p_value
    type:
      - 'null'
      - float
    doc: P-value
    default: 0.05
    inputBinding:
      position: 101
      prefix: -p
  - id: pairing_method
    type:
      - 'null'
      - string
    doc: Pairing method (p,u,f)
    default: u
    inputBinding:
      position: 101
      prefix: -pm
  - id: pairing_method_chaining
    type:
      - 'null'
      - string
    doc: Pairing method (p,u,f)
    default: u
    inputBinding:
      position: 101
      prefix: -fpm
  - id: penalty_for_gap_extension
    type:
      - 'null'
      - int
    doc: Penalty for gap extension
    default: 1
    inputBinding:
      position: 101
      prefix: -gapextend
  - id: penalty_for_gap_opening
    type:
      - 'null'
      - int
    doc: Penalty for gap opening
    default: 3
    inputBinding:
      position: 101
      prefix: -gapopen
  - id: penalty_for_mismatch
    type:
      - 'null'
      - int
    doc: Penalty for mismatch
    default: 2
    inputBinding:
      position: 101
      prefix: -penalty
  - id: penalty_local_chain_opening
    type:
      - 'null'
      - int
    doc: Penalty for opening a local chain
    default: 6
    inputBinding:
      position: 101
      prefix: -localopen
  - id: penalty_local_opening
    type:
      - 'null'
      - int
    doc: Penalty for local opening
    default: 6
    inputBinding:
      position: 101
      prefix: -localopen
  - id: penalty_matching_n
    type:
      - 'null'
      - int
    doc: Penalty matching N
    default: 0
    inputBinding:
      position: 101
      prefix: -Npenalty
  - id: penalty_transition
    type:
      - 'null'
      - int
    doc: Penalty for transition
    default: 2
    inputBinding:
      position: 101
      prefix: -transition
  - id: penalty_transversion
    type:
      - 'null'
      - int
    doc: Penalty for transversion
    default: 2
    inputBinding:
      position: 101
      prefix: -transversion
  - id: proximity_scoring
    type:
      - 'null'
      - string
    doc: Proximity scoring (negative for soft)
    default: False/1.0
    inputBinding:
      position: 101
      prefix: -proxi
  - id: reassign_consensus
    type:
      - 'null'
      - boolean
    doc: Reassign consensus sequences
    default: false
    inputBinding:
      position: 101
      prefix: -reassign
  - id: remove_contamination
    type:
      - 'null'
      - boolean
    doc: Remove contamination
    default: false
    inputBinding:
      position: 101
      prefix: -deCon
  - id: reward_for_pairing_reads
    type:
      - 'null'
      - int
    doc: Reward for pairing reads
    default: 7
    inputBinding:
      position: 101
      prefix: -per
  - id: score_for_match
    type:
      - 'null'
      - int
    doc: Score for match
    default: 1
    inputBinding:
      position: 101
      prefix: -reward
  - id: seeds_surround_alignments
    type:
      - 'null'
      - boolean
    doc: Seeds soround alignments
    default: false
    inputBinding:
      position: 101
      prefix: -ssa
  - id: set_asm_preset
    type:
      - 'null'
      - boolean
    doc: Set assembly genefinding preset
    default: false
    inputBinding:
      position: 101
      prefix: -asm
  - id: set_cge_penalties
    type:
      - 'null'
      - boolean
    doc: Set CGE penalties and rewards
    default: false
    inputBinding:
      position: 101
      prefix: -cge
  - id: set_ill_preset
    type:
      - 'null'
      - boolean
    doc: Set 2nd gen genefinding preset
    default: false
    inputBinding:
      position: 101
      prefix: -ill
  - id: set_mint2_preset
    type:
      - 'null'
      - boolean
    doc: Set 2nd gen Mintyper preset
    default: false
    inputBinding:
      position: 101
      prefix: -mint2
  - id: set_mint3_preset
    type:
      - 'null'
      - boolean
    doc: Set 3rd gen Mintyper preset
    default: false
    inputBinding:
      position: 101
      prefix: -mint3
  - id: set_ont_preset
    type:
      - 'null'
      - boolean
    doc: Set 3rd gen genefinding preset
    default: false
    inputBinding:
      position: 101
      prefix: -ont
  - id: set_pm_and_fpm
    type:
      - 'null'
      - string
    doc: Sets both pm and fpm
    default: u
    inputBinding:
      position: 101
      prefix: -apm
  - id: skip_alignment
    type:
      - 'null'
      - boolean
    doc: Skip alignment
    default: false
    inputBinding:
      position: 101
      prefix: -sasm
  - id: skip_insertion_in_consensus
    type:
      - 'null'
      - boolean
    doc: Skip insertion in consensus
    default: false
    inputBinding:
      position: 101
      prefix: -dense
  - id: sparse_sorting
    type:
      - 'null'
      - string
    doc: Sparse sorting (q,c,d,n)
    default: q
    inputBinding:
      position: 101
      prefix: -ss
  - id: temp_dir
    type:
      - 'null'
      - Directory
    doc: Set directory for temporary files
    inputBinding:
      position: 101
      prefix: -tmp
  - id: template_db
    type:
      - 'null'
      - string
    doc: Template DB
    inputBinding:
      position: 101
      prefix: -t_db
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 1
    inputBinding:
      position: 101
      prefix: -t
  - id: trim_3_prime
    type:
      - 'null'
      - int
    doc: Trim 3 prime
    default: 0
    inputBinding:
      position: 101
      prefix: -3p
  - id: trim_5_prime
    type:
      - 'null'
      - int
    doc: Trim 5 prime
    default: 0
    inputBinding:
      position: 101
      prefix: -5p
  - id: trim_front_of_seeds
    type:
      - 'null'
      - int
    doc: Trim front of seeds
    default: 0
    inputBinding:
      position: 101
      prefix: -ts
  - id: tsv_flag
    type:
      - 'null'
      - int
    doc: Tsv flag
    default: 0
    inputBinding:
      position: 101
      prefix: -tsv
  - id: tsv_help
    type:
      - 'null'
      - boolean
    doc: Help on -tsv
    inputBinding:
      position: 101
      prefix: -tsvh
  - id: use_hmm_assign_template
    type:
      - 'null'
      - boolean
    doc: Use a HMM to assign template(s)
    default: false
    inputBinding:
      position: 101
      prefix: -hmm
  - id: use_mrs_and_pvalue_on_consensus
    type:
      - 'null'
      - boolean
    doc: Use both mrs and p-value on consensus
    inputBinding:
      position: 101
      prefix: -and
  - id: use_neither_mrs_or_pvalue_on_consensus
    type:
      - 'null'
      - boolean
    doc: Use neither mrs or p-value on consensus
    default: false
    inputBinding:
      position: 101
      prefix: -oa
  - id: use_ns_on_indels
    type:
      - 'null'
      - boolean
    doc: Use n's on indels
    default: false
    inputBinding:
      position: 101
      prefix: -ref_fsa
  - id: use_shm_db
    type:
      - 'null'
      - int
    doc: Use DB in shared memory
    default: 0
    inputBinding:
      position: 101
      prefix: -shm
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Extra verbose
    default: false
    inputBinding:
      position: 101
      prefix: -verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kma:1.6.8--h577a1d6_0
stdout: kma.out
