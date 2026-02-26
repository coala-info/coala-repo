cwlVersion: v1.2
class: CommandLineTool
baseCommand: spp-dcj ilp
label: spp-dcj_ilp
doc: "Solves the Double-Cut-and-Join problem using Integer Linear Programming.\n\n\
  Tool homepage: https://github.com/codialab/spp-dcj"
inputs:
  - id: tree
    type: File
    doc: 'phylogenetic tree as child->parent relation table (Important: children must
      be in first column.)'
    inputBinding:
      position: 1
  - id: candidate_adjacencies
    type: File
    doc: candidate adjacencies of the genomes in the phylogeny
    inputBinding:
      position: 2
  - id: all_telomeres
    type:
      - 'null'
      - boolean
    doc: Add additional telomeres to all nodes.
    inputBinding:
      position: 103
      prefix: --all_telomeres
  - id: alpha
    type:
      - 'null'
      - float
    doc: linear weighting factor for adjacency weights vs DCJ indel distance 
      (alpha = 1 => maximize only DCJ indel distance)
    inputBinding:
      position: 103
      prefix: --alpha
  - id: beta
    type:
      - 'null'
      - float
    doc: Backwards compatible beta parameter from v1. Telomeres will be 
      re-weighted and the ILP scaled to be equivalent to v1.
    inputBinding:
      position: 103
      prefix: --beta
  - id: def_telomere_weight
    type:
      - 'null'
      - float
    doc: Default weight for added telomeres. Has no effect if -t is used. For 
      most use cases this should be <= 0.
    inputBinding:
      position: 103
      prefix: --def-telomere-weight
  - id: family_bounds
    type:
      - 'null'
      - File
    doc: Family bounds file
    inputBinding:
      position: 103
      prefix: --family-bounds
  - id: no_telomeres
    type:
      - 'null'
      - boolean
    doc: don't add any additional telomeres. Overrides -at.
    inputBinding:
      position: 103
      prefix: --no_telomeres
  - id: pairwise_lower_bnds
    type:
      - 'null'
      - File
    doc: Pairwise lower bounds file
    inputBinding:
      position: 103
      prefix: --pairwise-lower-bnds
  - id: separator
    type:
      - 'null'
      - string
    doc: Separator of in gene names to split <family ID> and <uniquifying 
      identifier> in adjacencies file
    inputBinding:
      position: 103
      prefix: --separator
  - id: set_circ_sing_handling
    type:
      - 'null'
      - string
    doc: Set circular/single-ended telomere handling strategy
    inputBinding:
      position: 103
      prefix: --set-circ-sing-handling
  - id: warm_start_sol
    type:
      - 'null'
      - File
    doc: Warm start solution file
    inputBinding:
      position: 103
      prefix: --warm-start-sol
outputs:
  - id: output_id_mapping
    type:
      - 'null'
      - File
    doc: writs a table with ID-to-gene extremity mapping
    outputBinding:
      glob: $(inputs.output_id_mapping)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spp-dcj:2.0.0--pyh7e72e81_0
