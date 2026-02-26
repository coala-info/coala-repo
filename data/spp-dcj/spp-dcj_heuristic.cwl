cwlVersion: v1.2
class: CommandLineTool
baseCommand: spp-dcj_heuristic
label: spp-dcj_heuristic
doc: "heuristic\n\nTool homepage: https://github.com/codialab/spp-dcj"
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
  - id: idmap
    type: File
    doc: Id map file (output of the main script)
    inputBinding:
      position: 3
  - id: all_telomeres
    type:
      - 'null'
      - boolean
    doc: Add additional telomeres to all nodes.
    inputBinding:
      position: 104
      prefix: --all_telomeres
  - id: alpha
    type:
      - 'null'
      - float
    doc: linear weighting factor for adjacency weights vs DCJ indel distance 
      (alpha = 1 => maximize only DCJ indel distance)
    inputBinding:
      position: 104
      prefix: --alpha
  - id: beta
    type:
      - 'null'
      - float
    doc: Backwards compatible beta parameter from v1. Telomeres will be 
      re-weighted and the ILP scaled to be equivalent to v1.
    inputBinding:
      position: 104
      prefix: --beta
  - id: def_telomere_weight
    type:
      - 'null'
      - float
    doc: Default weight for added telomeres. Has no effect if -t is used. For 
      most use cases this should be <= 0.
    inputBinding:
      position: 104
      prefix: --def-telomere-weight
  - id: family_bounds
    type:
      - 'null'
      - string
    inputBinding:
      position: 104
      prefix: --family-bounds
  - id: no_telomeres
    type:
      - 'null'
      - boolean
    doc: don't add any additional telomeres. Overrides -at.
    inputBinding:
      position: 104
      prefix: --no_telomeres
  - id: separator
    type:
      - 'null'
      - string
    doc: Separator of in gene names to split <family ID> and <uniquifying 
      identifier> in adjacencies file
    inputBinding:
      position: 104
      prefix: --separator
  - id: set_circ_sing_handling
    type:
      - 'null'
      - string
    inputBinding:
      position: 104
      prefix: --set-circ-sing-handling
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spp-dcj:2.0.0--pyh7e72e81_0
stdout: spp-dcj_heuristic.out
