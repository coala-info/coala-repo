cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - treebest
  - nj
label: treebest_nj
doc: "Neighbor-joining tree building using various distance metrics and models.\n\n
  Tool homepage: https://github.com/lh3/treebest"
inputs:
  - id: input_file
    type: File
    doc: Input alignment file
    inputBinding:
      position: 1
  - id: aln_format
    type:
      - 'null'
      - boolean
    doc: the input alignment is stored in ALN format
    inputBinding:
      position: 102
      prefix: -A
  - id: bootstrapping_times
    type:
      - 'null'
      - int
    doc: bootstrapping times
    default: 100
    inputBinding:
      position: 102
      prefix: -b
  - id: branch_mode
    type:
      - 'null'
      - boolean
    doc: branch mode that is used by most tree-builder
    inputBinding:
      position: 102
      prefix: -a
  - id: codon_type
    type:
      - 'null'
      - string
    doc: 'codon NT: ntmm, dn, ds, dm; AA: mm, jtt, kimura'
    default: mm
    inputBinding:
      position: 102
      prefix: -t
  - id: collapse_alternative_splicing
    type:
      - 'null'
      - boolean
    doc: collapse alternative splicing
    inputBinding:
      position: 102
      prefix: -g
  - id: comparison_tree
    type:
      - 'null'
      - File
    doc: tree to be compared
    inputBinding:
      position: 102
      prefix: -m
  - id: constrained_tree
    type:
      - 'null'
      - File
    doc: constrained tree(s) in NH format
    inputBinding:
      position: 102
      prefix: -c
  - id: copy_support_tags
    type:
      - 'null'
      - boolean
    doc: copy the branch support tags from the constrained tree
    inputBinding:
      position: 102
      prefix: -I
  - id: first_constrained_as_original
    type:
      - 'null'
      - boolean
    doc: treat the first constrained tree as the original tree
    inputBinding:
      position: 102
      prefix: -S
  - id: ingroup_list
    type:
      - 'null'
      - File
    doc: ingroup list file
    inputBinding:
      position: 102
      prefix: -l
  - id: leaves_as_ingroup
    type:
      - 'null'
      - boolean
    doc: use the leaves of constrained trees as ingroup
    inputBinding:
      position: 102
      prefix: -C
  - id: no_alignment_mask
    type:
      - 'null'
      - boolean
    doc: do not apply alignment mask
    inputBinding:
      position: 102
      prefix: -M
  - id: no_leaf_reordering
    type:
      - 'null'
      - boolean
    doc: do not apply leaf-reordering
    inputBinding:
      position: 102
      prefix: -R
  - id: no_mask_poor_segments
    type:
      - 'null'
      - boolean
    doc: do not mask poorly aligned segments
    inputBinding:
      position: 102
      prefix: -N
  - id: outgroup
    type:
      - 'null'
      - string
    doc: outgroup for tree cutting
    default: Bilateria
    inputBinding:
      position: 102
      prefix: -o
  - id: putative_root_node
    type:
      - 'null'
      - boolean
    doc: the root node is a putative node
    inputBinding:
      position: 102
      prefix: -p
  - id: quality_cutoff
    type:
      - 'null'
      - int
    doc: quality cut-off
    default: 15
    inputBinding:
      position: 102
      prefix: -F
  - id: species_tree
    type:
      - 'null'
      - File
    doc: species tree in NH format
    inputBinding:
      position: 102
      prefix: -s
  - id: time_limit
    type:
      - 'null'
      - int
    doc: time limit in seconds
    inputBinding:
      position: 102
      prefix: -T
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose output
    inputBinding:
      position: 102
      prefix: -v
  - id: wipe_out_root
    type:
      - 'null'
      - boolean
    doc: wipe out root (SDI information will be lost!)
    inputBinding:
      position: 102
      prefix: -W
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treebest:1.9.2_ep78--hfc679d8_2
stdout: treebest_nj.out
