cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rukki
  - trio
label: rukki_trio
doc: "Trio-marker based analysis\n\nTool homepage: https://github.com/marbl/rukki"
inputs:
  - id: assign_tangles
    type:
      - 'null'
      - boolean
    doc: Assign tangles flanked by solid nodes from the same class
    inputBinding:
      position: 101
      prefix: --assign-tangles
  - id: default_gap_size
    type:
      - 'null'
      - int
    doc: Default gap size, which will be output in cases where reasonable 
      estimate is not possible or (more likely) hasn't been implemented yet
    default: 5000
    inputBinding:
      position: 101
      prefix: --default-gap-size
  - id: fillable_bubble_diff
    type:
      - 'null'
      - int
    doc: Bubbles with bigger difference between alternatives' lengths will not 
      be filled
    default: 200
    inputBinding:
      position: 101
      prefix: --fillable-bubble-diff
  - id: fillable_bubble_len
    type:
      - 'null'
      - int
    doc: Bubbles including a longer alternative sequence will not be filled
    default: 50000
    inputBinding:
      position: 101
      prefix: --fillable-bubble-len
  - id: gaf_format
    type:
      - 'null'
      - boolean
    doc: Use GAF ([<>]<name1>)+ format for paths
    inputBinding:
      position: 101
      prefix: --gaf-format
  - id: good_side_cov_gap
    type:
      - 'null'
      - float
    doc: During bubble filling ignore simple sides of bubbles with coverage less
      than source/sink average divided by this value 0. disables check
    default: 5
    inputBinding:
      position: 101
      prefix: --good-side-cov-gap
  - id: graph
    type: File
    doc: GFA file
    inputBinding:
      position: 101
      prefix: --graph
  - id: hap_names
    type:
      - 'null'
      - string
    doc: 'Comma separated haplotype names to be used in outputs (default: "mat,pat")'
    default: mat,pat
    inputBinding:
      position: 101
      prefix: --hap-names
  - id: het_fill_bubble_diff
    type:
      - 'null'
      - int
    doc: Heterozygous bubbles with bigger difference between alternatives' 
      lengths will not be filled (by default equal to fillable_bubble_diff)
    inputBinding:
      position: 101
      prefix: --het-fill-bubble-diff
  - id: het_fill_bubble_len
    type:
      - 'null'
      - int
    doc: Heterozygous bubbles including a longer alternative sequence will not 
      be filled (by default equal to fillable_bubble_len)
    inputBinding:
      position: 101
      prefix: --het-fill-bubble-len
  - id: issue_cnt
    type:
      - 'null'
      - int
    doc: Minimal number of markers for assigning ISSUE label (by default == 
      marker_cnt, will typically be set to a value >= marker_cnt)
    inputBinding:
      position: 101
      prefix: --issue-cnt
  - id: issue_len
    type:
      - 'null'
      - int
    doc: Minimal node length for assigning ISSUE label
    default: 50000
    inputBinding:
      position: 101
      prefix: --issue-len
  - id: issue_ratio
    type:
      - 'null'
      - float
    doc: Require primary marker excess BELOW <value>:1 for assigning ISSUE 
      label. Must be <= marker_ratio (by default == marker_ratio)
    inputBinding:
      position: 101
      prefix: --issue-ratio
  - id: issue_sparsity
    type:
      - 'null'
      - int
    doc: Require at least (node_length / <value>) markers for assigning ISSUE 
      label (by default == marker_sparsity, will typically be set to a value >= 
      marker_sparsity)
    inputBinding:
      position: 101
      prefix: --issue-sparsity
  - id: marker_cnt
    type:
      - 'null'
      - int
    doc: Minimal number of parent-specific markers required for assigning 
      parental group to a node
    default: 10
    inputBinding:
      position: 101
      prefix: --marker-cnt
  - id: marker_ratio
    type:
      - 'null'
      - float
    doc: Sets minimal marker excess for assigning a parental group to <value>:1
    default: 5
    inputBinding:
      position: 101
      prefix: --marker-ratio
  - id: marker_sparsity
    type:
      - 'null'
      - int
    doc: Require at least (node_length / <value>) markers within the node for 
      parental group assignment
    default: 10000
    inputBinding:
      position: 101
      prefix: --marker-sparsity
  - id: markers
    type: File
    doc: Parental markers file
    inputBinding:
      position: 101
      prefix: --markers
  - id: max_homozygous_len
    type:
      - 'null'
      - int
    doc: Longer nodes can not be classified as homozygous
    default: 2000000
    inputBinding:
      position: 101
      prefix: --max-homozygous-len
  - id: max_unique_cov_coeff
    type:
      - 'null'
      - float
    doc: Do not fill bubble if source or sink is non-solid, non-homozygous and 
      has coverage above <coeff> * <weighted mean coverage of 'solid' nodes>. 
      Negative disables check, 0. makes it fail
    default: 1.5
    inputBinding:
      position: 101
      prefix: --max-unique-cov-coeff
  - id: min_gap_size
    type:
      - 'null'
      - int
    doc: Minimal introducible gap size (number of Ns reported). If the gap size 
      estimate is smaller it will be artificially increased to this value
    default: 1000
    inputBinding:
      position: 101
      prefix: --min-gap-size
  - id: paths
    type:
      - 'null'
      - File
    doc: Marker-assisted extracted haplo-paths
    inputBinding:
      position: 101
      prefix: --paths
  - id: solid_homozygous_cov_coeff
    type:
      - 'null'
      - float
    doc: Solid nodes with coverage below <coeff> * <weighted mean coverage of 
      'solid' nodes> can not be classified as homozygous. 0. disables check
    default: 1.5
    inputBinding:
      position: 101
      prefix: --solid-homozygous-cov-coeff
  - id: solid_len
    type:
      - 'null'
      - int
    doc: Longer nodes are unlikely to represent repeats, polymorphic variants, 
      etc (used to seed and guide the path search)
    default: 500000
    inputBinding:
      position: 101
      prefix: --solid-len
  - id: solid_ratio
    type:
      - 'null'
      - float
    doc: Sets minimal marker excess for assigning a parental group of solid 
      nodes to <value>:1. Must be <= marker_ratio (by default == marker_ratio)
    inputBinding:
      position: 101
      prefix: --solid-ratio
  - id: suspect_homozygous_cov_coeff
    type:
      - 'null'
      - float
    doc: Nodes with coverage below <coeff> * <weighted mean coverage of 'solid' 
      nodes> can not be 'reclassified' as homozygous. Negative turns off 
      reclassification, 0. disables coverage check
    default: 1.5
    inputBinding:
      position: 101
      prefix: --suspect-homozygous-cov-coeff
  - id: tangle_allow_deadend
    type:
      - 'null'
      - boolean
    doc: Allow dead-end nodes in the tangles
    inputBinding:
      position: 101
      prefix: --tangle-allow-deadend
  - id: tangle_check_inner
    type:
      - 'null'
      - boolean
    doc: Check that inner tangle nodes are either unassigned or assigned to 
      correct class
    inputBinding:
      position: 101
      prefix: --tangle-check-inner
  - id: tangle_prevent_reassign
    type:
      - 'null'
      - boolean
    doc: Prevent reassignment of nodes
    inputBinding:
      position: 101
      prefix: --tangle-prevent-reassign
  - id: trusted_len
    type:
      - 'null'
      - int
    doc: Longer nodes are unlikely to be spurious and likely to be reliably 
      assigned based on markers (used in HOMOZYGOUS node labeling)
    default: 200000
    inputBinding:
      position: 101
      prefix: --trusted-len
  - id: try_fill_bubbles
    type:
      - 'null'
      - boolean
    doc: Try to fill in small ambiguous bubbles
    inputBinding:
      position: 101
      prefix: --try-fill-bubbles
outputs:
  - id: init_assign
    type:
      - 'null'
      - File
    doc: Marker-based annotation output file
    outputBinding:
      glob: $(inputs.init_assign)
  - id: refined_assign
    type:
      - 'null'
      - File
    doc: Refined annotation output file
    outputBinding:
      glob: $(inputs.refined_assign)
  - id: final_assign
    type:
      - 'null'
      - File
    doc: Final annotation output file
    outputBinding:
      glob: $(inputs.final_assign)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rukki:0.3.0--ha6fb395_1
