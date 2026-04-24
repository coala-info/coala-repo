cwlVersion: v1.2
class: CommandLineTool
baseCommand: phynder
label: phynder
doc: "Phylogenetic placement of variants into a tree\n\nTool homepage: https://github.com/richarddurbin/phynder"
inputs:
  - id: newick_tree
    type: File
    doc: Newick tree file
    inputBinding:
      position: 1
  - id: vcf_for_tree
    type: File
    doc: VCF file for the tree
    inputBinding:
      position: 2
  - id: calc_mode
    type:
      - 'null'
      - int
    doc: 'calculation mode. 0: LL both ends of edge match; 1: -LL both ends of edge
      mismatch'
    inputBinding:
      position: 103
      prefix: -C
  - id: output_branch_positions
    type:
      - 'null'
      - boolean
    doc: output branch positions of tree variants
    inputBinding:
      position: 103
      prefix: -B
  - id: posterior_threshold
    type:
      - 'null'
      - float
    doc: print out suboptimal branches and clade
    inputBinding:
      position: 103
      prefix: -p
  - id: query_vcf
    type:
      - 'null'
      - File
    doc: output query assignments
    inputBinding:
      position: 103
      prefix: -q
  - id: site_likelihood_threshold
    type:
      - 'null'
      - float
    doc: site likelihood threshold, zero means no threshold
    inputBinding:
      position: 103
      prefix: -T
  - id: transition_rate
    type:
      - 'null'
      - float
    doc: transition rate
    inputBinding:
      position: 103
      prefix: -ts
  - id: transversion_rate
    type:
      - 'null'
      - float
    doc: transversion rate
    inputBinding:
      position: 103
      prefix: -tv
  - id: ultrametric
    type:
      - 'null'
      - boolean
    doc: make tree ultrametric - all leaves equidistant from root
    inputBinding:
      position: 103
      prefix: -U
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose - print extra info
    inputBinding:
      position: 103
      prefix: -v
  - id: write_binary
    type:
      - 'null'
      - boolean
    doc: write binary (can read with ONEview)
    inputBinding:
      position: 103
      prefix: -b
outputs:
  - id: output_filename
    type:
      - 'null'
      - File
    doc: ONEfile name; default is stdout
    outputBinding:
      glob: $(inputs.output_filename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phynder:1.0--h566b1c6_5
