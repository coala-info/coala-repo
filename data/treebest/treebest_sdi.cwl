cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - treebest
  - sdi
label: treebest_sdi
doc: "TreeBest SDI (Speciation Duplication Inference) tool for rooting and comparing
  gene trees with species trees.\n\nTool homepage: https://github.com/lh3/treebest"
inputs:
  - id: tree
    type: File
    doc: Input gene tree file
    inputBinding:
      position: 1
  - id: compare_topology
    type:
      - 'null'
      - File
    doc: compare topology with FILE and re-order the leaves [null]
    inputBinding:
      position: 102
      prefix: -m
  - id: no_reorder_leaves
    type:
      - 'null'
      - boolean
    doc: do not reorder the leaves.
    inputBinding:
      position: 102
      prefix: -R
  - id: reroot
    type:
      - 'null'
      - boolean
    doc: reroot
    inputBinding:
      position: 102
      prefix: -r
  - id: reroot_min_height
    type:
      - 'null'
      - boolean
    doc: reroot by minimizing tree height, instead of by minimizing the number of
      duplication events.
    inputBinding:
      position: 102
      prefix: -H
  - id: species_list
    type:
      - 'null'
      - File
    doc: cut a subtree that contains genes whose species exist in list [null]
    inputBinding:
      position: 102
      prefix: -l
  - id: species_tree
    type:
      - 'null'
      - File
    doc: species tree [default taxa tree]
    inputBinding:
      position: 102
      prefix: -s
  - id: use_core_species
    type:
      - 'null'
      - boolean
    doc: use core species tree instead of the default one
    inputBinding:
      position: 102
      prefix: -c
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treebest:1.9.2_ep78--hfc679d8_2
stdout: treebest_sdi.out
