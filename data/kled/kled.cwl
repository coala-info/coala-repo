cwlVersion: v1.2
class: CommandLineTool
baseCommand: kled
label: kled
doc: "kled [Options] Bam1 [Bam2] [Bam3] ...\n\nTool homepage: https://github.com/CoREse/kled"
inputs:
  - id: bam_files
    type:
      type: array
      items: File
    doc: Input BAM files
    inputBinding:
      position: 1
  - id: always_calculate_pos_std
    type:
      - 'null'
      - boolean
    doc: Always calculate Pos STD.
    inputBinding:
      position: 102
      prefix: --PSTD
  - id: calling_contig_by_contig
    type:
      - 'null'
      - boolean
    doc: Calling contig by contig, cost less memory.
    default: false
    inputBinding:
      position: 102
      prefix: --BC
  - id: cigar_merge
    type:
      - 'null'
      - int
    doc: CigarMergeType, 0 for Omni.B, 1 for simple, 2 for simple regional.
    default: 0
    inputBinding:
      position: 102
      prefix: --CigarMerge
  - id: clustering_batch_size
    type:
      - 'null'
      - int
    doc: Batch size of multihreading when clustering.
    default: 10000
    inputBinding:
      position: 102
      prefix: --ClusteringBatchSize
  - id: contig_name
    type:
      - 'null'
      - type: array
        items: string
    doc: Only call variants in Contig(s), can occur multiple times
    inputBinding:
      position: 102
      prefix: -C
  - id: coverage_window_size
    type:
      - 'null'
      - int
    doc: Coverage window size.
    default: 100
    inputBinding:
      position: 102
      prefix: -c
  - id: del_cluster_fixed
    type:
      - 'null'
      - int
    doc: Fixed distance clustering parameter for deletions.
    default: 50
    inputBinding:
      position: 102
      prefix: --DelClusterFixed
  - id: del_cluster_fixed2
    type:
      - 'null'
      - int
    doc: Fixed distance 2 clustering parameter for deletions.
    default: 10
    inputBinding:
      position: 102
      prefix: --DelClusterFixed2
  - id: del_cluster_length_ratio
    type:
      - 'null'
      - float
    doc: Length ratio clustering parameter for deletions.
    default: 0.3
    inputBinding:
      position: 102
      prefix: --DelClusterLengthRatio
  - id: del_cluster_length_ratio2
    type:
      - 'null'
      - float
    doc: Length ratio 2 clustering parameter for deletions.
    default: 0.5
    inputBinding:
      position: 102
      prefix: --DelClusterLengthRatio2
  - id: del_cluster_min_length_endurance
    type:
      - 'null'
      - int
    doc: Min length endurance clustering parameter for deletions.
    default: 10
    inputBinding:
      position: 102
      prefix: --DelClusterMinLengthEndurance
  - id: del_cluster_near_range
    type:
      - 'null'
      - int
    doc: Near range clustering parameter for deletions.
    default: -1
    inputBinding:
      position: 102
      prefix: --DelClusterNearRange
  - id: del_cluster_paras
    type:
      - 'null'
      - string
    doc: Custom clustering parameters for deletions, if later 3 not given or 
      NearRange=-1 use single layer clustering. Value * for defaults.
    default: ''
    inputBinding:
      position: 102
      prefix: --DelClusterParas
  - id: del_cluster_ratio
    type:
      - 'null'
      - float
    doc: Distance ratio clustering parameter for deletions.
    default: 1.5
    inputBinding:
      position: 102
      prefix: --DelClusterRatio
  - id: del_filter_paras
    type:
      - 'null'
      - string
    doc: Custom filter parameters for deletions. Value * for defaults.
    default: ''
    inputBinding:
      position: 102
      prefix: --DelFilterParas
  - id: del_homo_m
    type:
      - 'null'
      - float
    doc: Homo Minus for deletions.
    default: 0.0
    inputBinding:
      position: 102
      prefix: --DelHomoM
  - id: del_homo_mr
    type:
      - 'null'
      - float
    doc: Homo Minus Ratio for deletions.
    default: 0.2
    inputBinding:
      position: 102
      prefix: --DelHomoMR
  - id: del_homo_r
    type:
      - 'null'
      - float
    doc: HomoRatio for deletions.
    default: 0.8
    inputBinding:
      position: 102
      prefix: --DelHomoR
  - id: del_hpdcr
    type:
      - 'null'
      - float
    doc: HP diff compare ratio for deletions
    default: 1.4
    inputBinding:
      position: 102
      prefix: --DelHPDCR
  - id: del_hpr
    type:
      - 'null'
      - float
    doc: HPRatio for deletions
    default: 0.8
    inputBinding:
      position: 102
      prefix: --DelHPR
  - id: del_hpscr
    type:
      - 'null'
      - float
    doc: HP same compare ratio for deletions
    default: 0.8
    inputBinding:
      position: 102
      prefix: --DelHPSCR
  - id: del_low_hpp
    type:
      - 'null'
      - float
    doc: Low HP Plus for deletions.
    default: 0.0
    inputBinding:
      position: 102
      prefix: --DelLowHPP
  - id: del_low_hppr
    type:
      - 'null'
      - float
    doc: Low HP Plus Ratio for deletions.
    default: 0.25
    inputBinding:
      position: 102
      prefix: --DelLowHPPR
  - id: del_min_pos_std
    type:
      - 'null'
      - int
    doc: "Filter out clusters that have position stds > MinPosSTD, -1: don't filter."
    default: -1
    inputBinding:
      position: 102
      prefix: --DelMinPosSTD
  - id: del_non_homo_m
    type:
      - 'null'
      - float
    doc: Non Homo Minus for deletions.
    default: 0.0
    inputBinding:
      position: 102
      prefix: --DelNonHomoM
  - id: del_non_homo_mr
    type:
      - 'null'
      - float
    doc: Non Homo Minus Ratio for deletions.
    default: -0.05
    inputBinding:
      position: 102
      prefix: --DelNonHomoMR
  - id: dup_cluster_fixed
    type:
      - 'null'
      - int
    doc: Fixed distance clustering parameter for duplications.
    default: 0
    inputBinding:
      position: 102
      prefix: --DupClusterFixed
  - id: dup_cluster_fixed2
    type:
      - 'null'
      - int
    doc: Fixed distance 2 clustering parameter for duplications.
    default: 500
    inputBinding:
      position: 102
      prefix: --DupClusterFixed2
  - id: dup_cluster_length_ratio
    type:
      - 'null'
      - float
    doc: Length ratio clustering parameter for duplications.
    default: 0.1
    inputBinding:
      position: 102
      prefix: --DupClusterLengthRatio
  - id: dup_cluster_length_ratio2
    type:
      - 'null'
      - float
    doc: Length ratio 2 clustering parameter for duplications.
    default: 0.1
    inputBinding:
      position: 102
      prefix: --DupClusterLengthRatio2
  - id: dup_cluster_min_length_endurance
    type:
      - 'null'
      - int
    doc: Min length endurance clustering parameter for duplications.
    default: 0
    inputBinding:
      position: 102
      prefix: --DupClusterMinLengthEndurance
  - id: dup_cluster_near_range
    type:
      - 'null'
      - int
    doc: Near range clustering parameter for duplications.
    default: -1
    inputBinding:
      position: 102
      prefix: --DupClusterNearRange
  - id: dup_cluster_paras
    type:
      - 'null'
      - string
    doc: Custom clustering parameters for duplications, if later 3 not given or 
      NearRange=-1 use single layer clustering. Value * for defaults.
    default: ''
    inputBinding:
      position: 102
      prefix: --DupClusterParas
  - id: dup_cluster_ratio
    type:
      - 'null'
      - float
    doc: Distance ratio clustering parameter for duplications.
    default: 0.2
    inputBinding:
      position: 102
      prefix: --DupClusterRatio
  - id: dup_filter_paras
    type:
      - 'null'
      - string
    doc: Custom filter parameters for duplications. Value * for defaults.
    default: ''
    inputBinding:
      position: 102
      prefix: --DupFilterParas
  - id: dup_homo_m
    type:
      - 'null'
      - float
    doc: Homo Minus for duplications.
    default: 0.0
    inputBinding:
      position: 102
      prefix: --DupHomoM
  - id: dup_homo_mr
    type:
      - 'null'
      - float
    doc: Homo Minus Ratio for duplications.
    default: 0.6
    inputBinding:
      position: 102
      prefix: --DupHomoMR
  - id: dup_homo_r
    type:
      - 'null'
      - float
    doc: HomoRatio for duplications.
    default: 0.9
    inputBinding:
      position: 102
      prefix: --DupHomoR
  - id: dup_hpdcr
    type:
      - 'null'
      - float
    doc: HP diff compare ratio for duplications
    default: 1.4
    inputBinding:
      position: 102
      prefix: --DupHPDCR
  - id: dup_hpr
    type:
      - 'null'
      - float
    doc: HPRatio for duplications
    default: 0.2
    inputBinding:
      position: 102
      prefix: --DupHPR
  - id: dup_hpscr
    type:
      - 'null'
      - float
    doc: HP same compare ratio for duplications
    default: 0.4
    inputBinding:
      position: 102
      prefix: --DupHPSCR
  - id: dup_low_hpp
    type:
      - 'null'
      - float
    doc: Low HP Plus for duplications.
    default: 0.0
    inputBinding:
      position: 102
      prefix: --DupLowHPP
  - id: dup_low_hppr
    type:
      - 'null'
      - float
    doc: Low HP Plus Ratio for duplications.
    default: 0.9
    inputBinding:
      position: 102
      prefix: --DupLowHPPR
  - id: dup_min_pos_std
    type:
      - 'null'
      - int
    doc: "Filter out clusters that have position stds > MinPosSTD, -1: don't filter."
    default: -1
    inputBinding:
      position: 102
      prefix: --DupMinPosSTD
  - id: dup_non_homo_m
    type:
      - 'null'
      - float
    doc: Non Homo Minus for duplications.
    default: 0.0
    inputBinding:
      position: 102
      prefix: --DupNonHomoM
  - id: dup_non_homo_mr
    type:
      - 'null'
      - float
    doc: Non Homo Minus Ratio for duplications.
    default: 0.0
    inputBinding:
      position: 102
      prefix: --DupNonHomoMR
  - id: filter_insertions_within_duplication
    type:
      - 'null'
      - boolean
    doc: Filter out insertions within duplication range that have large PSTD 
      when number of duplication/number of insertion is large(>1/20). Implicates
      --PSTD.
    default: true
    inputBinding:
      position: 102
      prefix: --FID
  - id: ins_cluster_fixed
    type:
      - 'null'
      - int
    doc: Fixed distance clustering parameter for insertions.
    default: 150
    inputBinding:
      position: 102
      prefix: --InsClusterFixed
  - id: ins_cluster_fixed2
    type:
      - 'null'
      - int
    doc: Fixed distance 2 clustering parameter for insertions.
    default: 50
    inputBinding:
      position: 102
      prefix: --InsClusterFixed2
  - id: ins_cluster_length_ratio
    type:
      - 'null'
      - float
    doc: Length ratio clustering parameter for insertions.
    default: 0.1
    inputBinding:
      position: 102
      prefix: --InsClusterLengthRatio
  - id: ins_cluster_length_ratio2
    type:
      - 'null'
      - float
    doc: Length ratio 2 clustering parameter for insertions.
    default: 0.3
    inputBinding:
      position: 102
      prefix: --InsClusterLengthRatio2
  - id: ins_cluster_min_length_endurance
    type:
      - 'null'
      - int
    doc: Min length endurance clustering parameter for insertions.
    default: 20
    inputBinding:
      position: 102
      prefix: --InsClusterMinLengthEndurance
  - id: ins_cluster_near_range
    type:
      - 'null'
      - int
    doc: Near range clustering parameter for insertions.
    default: -1
    inputBinding:
      position: 102
      prefix: --InsClusterNearRange
  - id: ins_cluster_paras
    type:
      - 'null'
      - string
    doc: Custom clustering parameters for insertions, if later 3 not given or 
      NearRange=-1 use single layer clustering. Value * for defaults.
    default: ''
    inputBinding:
      position: 102
      prefix: --InsClusterParas
  - id: ins_cluster_ratio
    type:
      - 'null'
      - float
    doc: Distance ratio clustering parameter for insertions.
    default: 0.5
    inputBinding:
      position: 102
      prefix: --InsClusterRatio
  - id: ins_filter_paras
    type:
      - 'null'
      - string
    doc: Custom filter parameters for insertions. Value * for defaults.
    default: ''
    inputBinding:
      position: 102
      prefix: --InsFilterParas
  - id: ins_homo_m
    type:
      - 'null'
      - float
    doc: Homo Minus for insertions.
    default: 0.05
    inputBinding:
      position: 102
      prefix: --InsHomoM
  - id: ins_homo_mr
    type:
      - 'null'
      - float
    doc: Homo Minus Ratio for insertions.
    default: 0.25
    inputBinding:
      position: 102
      prefix: --InsHomoMR
  - id: ins_homo_r
    type:
      - 'null'
      - float
    doc: HomoRatio for insertions.
    default: 0.75
    inputBinding:
      position: 102
      prefix: --InsHomoR
  - id: ins_hpdcr
    type:
      - 'null'
      - float
    doc: HP diff compare ratio for insertions
    default: 1.5
    inputBinding:
      position: 102
      prefix: --InsHPDCR
  - id: ins_hpr
    type:
      - 'null'
      - float
    doc: HPRatio for insertions
    default: 0.7
    inputBinding:
      position: 102
      prefix: --InsHPR
  - id: ins_hpscr
    type:
      - 'null'
      - float
    doc: HP same compare ratio for insertions
    default: 0.8
    inputBinding:
      position: 102
      prefix: --InsHPSCR
  - id: ins_low_hpp
    type:
      - 'null'
      - float
    doc: Low HP Plus for insertions.
    default: 0.0
    inputBinding:
      position: 102
      prefix: --InsLowHPP
  - id: ins_low_hppr
    type:
      - 'null'
      - float
    doc: Low HP Plus Ratio for insertions.
    default: 0.25
    inputBinding:
      position: 102
      prefix: --InsLowHPPR
  - id: ins_min_pos_std
    type:
      - 'null'
      - int
    doc: "Filter out clusters that have position stds > MinPosSTD, -1: don't filter."
    default: -1
    inputBinding:
      position: 102
      prefix: --InsMinPosSTD
  - id: ins_non_homo_m
    type:
      - 'null'
      - float
    doc: Non Homo Minus for insertions.
    default: 0.0
    inputBinding:
      position: 102
      prefix: --InsNonHomoM
  - id: ins_non_homo_mr
    type:
      - 'null'
      - float
    doc: Non Homo Minus Ratio for insertions.
    default: 0.3
    inputBinding:
      position: 102
      prefix: --InsNonHomoMR
  - id: insertion_clip_tolerance
    type:
      - 'null'
      - int
    doc: Insertion clip signature distance tolerance.
    default: 10
    inputBinding:
      position: 102
      prefix: --InsClipTolerance
  - id: insertion_max_gap_size
    type:
      - 'null'
      - int
    doc: Insertion clip signature max gap size.
    default: 50000
    inputBinding:
      position: 102
      prefix: --InsMaxGapSize
  - id: inv_cluster_fixed
    type:
      - 'null'
      - int
    doc: Fixed distance clustering parameter for inversions.
    default: 100
    inputBinding:
      position: 102
      prefix: --InvClusterFixed
  - id: inv_cluster_fixed2
    type:
      - 'null'
      - int
    doc: Fixed distance 2 clustering parameter for inversions.
    default: 100
    inputBinding:
      position: 102
      prefix: --InvClusterFixed2
  - id: inv_cluster_length_ratio
    type:
      - 'null'
      - float
    doc: Length ratio clustering parameter for inversions.
    default: 0.1
    inputBinding:
      position: 102
      prefix: --InvClusterLengthRatio
  - id: inv_cluster_length_ratio2
    type:
      - 'null'
      - float
    doc: Length ratio 2 clustering parameter for inversions.
    default: 0.5
    inputBinding:
      position: 102
      prefix: --InvClusterLengthRatio2
  - id: inv_cluster_min_length_endurance
    type:
      - 'null'
      - int
    doc: Min length endurance clustering parameter for inversions.
    default: 0
    inputBinding:
      position: 102
      prefix: --InvClusterMinLengthEndurance
  - id: inv_cluster_near_range
    type:
      - 'null'
      - int
    doc: Near range clustering parameter for inversions.
    default: -1
    inputBinding:
      position: 102
      prefix: --InvClusterNearRange
  - id: inv_cluster_paras
    type:
      - 'null'
      - string
    doc: Custom clustering parameters for inversions, if later 3 not given or 
      NearRange=-1 use single layer clustering. Value * for defaults.
    default: ''
    inputBinding:
      position: 102
      prefix: --InvClusterParas
  - id: inv_cluster_ratio
    type:
      - 'null'
      - float
    doc: Distance ratio clustering parameter for inversions.
    default: 0.1
    inputBinding:
      position: 102
      prefix: --InvClusterRatio
  - id: inv_filter_paras
    type:
      - 'null'
      - string
    doc: Custom filter parameters for inversions. Value * for defaults.
    default: ''
    inputBinding:
      position: 102
      prefix: --InvFilterParas
  - id: inv_homo_m
    type:
      - 'null'
      - float
    doc: Homo Minus for inversions.
    default: 0.7
    inputBinding:
      position: 102
      prefix: --InvHomoM
  - id: inv_homo_mr
    type:
      - 'null'
      - float
    doc: Homo Minus Ratio for inversions.
    default: 0.2
    inputBinding:
      position: 102
      prefix: --InvHomoMR
  - id: inv_homo_r
    type:
      - 'null'
      - float
    doc: HomoRatio for inversions.
    default: 0.65
    inputBinding:
      position: 102
      prefix: --InvHomoR
  - id: inv_hpdcr
    type:
      - 'null'
      - float
    doc: HP diff compare ratio for inversions
    default: 1.3
    inputBinding:
      position: 102
      prefix: --InvHPDCR
  - id: inv_hpr
    type:
      - 'null'
      - float
    doc: HPRatio for inversions
    default: 0.5
    inputBinding:
      position: 102
      prefix: --InvHPR
  - id: inv_hpscr
    type:
      - 'null'
      - float
    doc: HP same compare ratio for inversions
    default: 1.0
    inputBinding:
      position: 102
      prefix: --InvHPSCR
  - id: inv_low_hpp
    type:
      - 'null'
      - float
    doc: Low HP Plus for inversions.
    default: 0.0
    inputBinding:
      position: 102
      prefix: --InvLowHPP
  - id: inv_low_hppr
    type:
      - 'null'
      - float
    doc: Low HP Plus Ratio for inversions.
    default: 0.0
    inputBinding:
      position: 102
      prefix: --InvLowHPPR
  - id: inv_min_pos_std
    type:
      - 'null'
      - int
    doc: "Filter out clusters that have position stds > MinPosSTD, -1: don't filter."
    default: -1
    inputBinding:
      position: 102
      prefix: --InvMinPosSTD
  - id: inv_non_homo_m
    type:
      - 'null'
      - float
    doc: Non Homo Minus for inversions.
    default: 0.0
    inputBinding:
      position: 102
      prefix: --InvNonHomoM
  - id: inv_non_homo_mr
    type:
      - 'null'
      - float
    doc: Non Homo Minus Ratio for inversions.
    default: 0.4
    inputBinding:
      position: 102
      prefix: --InvNonHomoMR
  - id: max_cluster_size
    type:
      - 'null'
      - int
    doc: Max cluster size, will resize to this value if a cluster is larger than
      this.
    default: 1000
    inputBinding:
      position: 102
      prefix: -M
  - id: max_max_merge_distance
    type:
      - 'null'
      - int
    doc: Maximum max merge distance of signature merging during CIGAR signature 
      collection for simple merge.
    default: 50000
    inputBinding:
      position: 102
      prefix: -D
  - id: max_merge_portion
    type:
      - 'null'
      - float
    doc: Max merge portion of signature merging during CIGAR signature 
      collection for simple merge.
    default: 0.2
    inputBinding:
      position: 102
      prefix: -p
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: Minimum mapping quality.
    default: 20
    inputBinding:
      position: 102
      prefix: -q
  - id: min_max_merge_distance
    type:
      - 'null'
      - int
    doc: Minimum max merge distance of signature merging during CIGAR signature 
      collection for simple merge.
    default: 500
    inputBinding:
      position: 102
      prefix: -d
  - id: min_sv_length
    type:
      - 'null'
      - int
    doc: Minimum SV length.
    default: 30
    inputBinding:
      position: 102
      prefix: -m
  - id: min_template_length
    type:
      - 'null'
      - int
    doc: Minimum template length.
    default: 500
    inputBinding:
      position: 102
      prefix: -l
  - id: no_filter
    type:
      - 'null'
      - boolean
    doc: No filter, output all results.
    default: false
    inputBinding:
      position: 102
      prefix: --NOF
  - id: omni_a
    type:
      - 'null'
      - int
    doc: A for omni.b merge.
    default: 800
    inputBinding:
      position: 102
      prefix: --OmniA
  - id: omni_b
    type:
      - 'null'
      - int
    doc: B for omni.b merge.
    default: 800
    inputBinding:
      position: 102
      prefix: --OmniB
  - id: omni_count_limit
    type:
      - 'null'
      - int
    doc: Relevant alignments count limit for omni.b merge.
    default: 20
    inputBinding:
      position: 102
      prefix: --OCountLimit
  - id: omni_max_edges
    type:
      - 'null'
      - int
    doc: Max edges(depth) for omni.b merge. This will grow complexity 
      exponentially.
    default: 8
    inputBinding:
      position: 102
      prefix: --OMaxE
  - id: omni_score_b_ratio
    type:
      - 'null'
      - float
    doc: ScoreB ratio for omni.b merge.
    default: 0.1
    inputBinding:
      position: 102
      prefix: --OScoreBRatio
  - id: output_all_with_st_ge_2
    type:
      - 'null'
      - boolean
    doc: Output all results with ST>=2.
    default: false
    inputBinding:
      position: 102
      prefix: --F2
  - id: reference_file
    type: File
    doc: Indicate Reference Fasta File
    inputBinding:
      position: 102
      prefix: --Ref
  - id: sample_name
    type:
      - 'null'
      - string
    doc: Sample name, if not given, kled will try to get it from the first bam 
      file ("*")
    inputBinding:
      position: 102
      prefix: -S
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads.
    default: 8
    inputBinding:
      position: 102
      prefix: --threads
  - id: use_ccs_defaults
    type:
      - 'null'
      - boolean
    doc: Use default parameters for CCS data (will overwrite previous cluster 
      and filter parameters).
    default: false
    inputBinding:
      position: 102
      prefix: --CCS
  - id: use_clr_defaults
    type:
      - 'null'
      - boolean
    doc: Use default parameters for CLR data (will overwrite previous cluster 
      and filter parameters).
    default: false
    inputBinding:
      position: 102
      prefix: --CLR
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'Set the logging verbosity, <=0: info, 1: verbose, >=2: debug.'
    default: 0
    inputBinding:
      position: 102
      prefix: --verbosity
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kled:1.2.10--h4f462e4_0
stdout: kled.out
