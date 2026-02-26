cwlVersion: v1.2
class: CommandLineTool
baseCommand: sapling
label: sapling
doc: "Sapling is an algorithm for summarizing and inferring tumor phylogenies from\n\
  bulk DNA sequencing data\n\nTool homepage: https://github.com/elkebir-group/Sapling"
inputs:
  - id: alt_roots
    type:
      - 'null'
      - boolean
    doc: Explore alternative root nodes
    inputBinding:
      position: 101
      prefix: --alt_roots
  - id: beam_width
    type:
      - 'null'
      - int
    doc: "Maximum beam width (default: -1, limited only by\n                     \
      \   --rho)"
    default: -1
    inputBinding:
      position: 101
      prefix: --beam_width
  - id: big_expand
    type:
      - 'null'
      - boolean
    doc: "Use big expand (new mutations are anywhere, not just\n                 \
      \       as leaves or splitting a single edge)"
    inputBinding:
      position: 101
      prefix: --big_expand
  - id: ell
    type:
      - 'null'
      - int
    doc: 'Ell parameter, minimum number of mutations (default: -1, unlimited)'
    default: -1
    inputBinding:
      position: 101
      prefix: --ell
  - id: init_trees
    type:
      - 'null'
      - File
    doc: Input filename with initial backbone trees to expand
    inputBinding:
      position: 101
      prefix: --init_trees
  - id: input_filename
    type: File
    doc: Input filename with mutation read counts (use '-' for STDIN)
    inputBinding:
      position: 101
      prefix: --f
  - id: poly_clonal_root
    type:
      - 'null'
      - boolean
    doc: Allow poly clonal root node
    inputBinding:
      position: 101
      prefix: --poly_clonal_root
  - id: regression_method
    type:
      - 'null'
      - string
    doc: Regression method
    default: fastppm
    inputBinding:
      position: 101
      prefix: --L
  - id: rho
    type:
      - 'null'
      - float
    doc: "Rho parameter, minimum deviation allowed from max\n                    \
      \    likelihood (default: 0.9, ignored when beam_width\n                   \
      \     specified)"
    default: 0.9
    inputBinding:
      position: 101
      prefix: --rho
  - id: sep
    type:
      - 'null'
      - string
    doc: Input/output column separator
    default: \t
    inputBinding:
      position: 101
      prefix: --sep
  - id: tau
    type:
      - 'null'
      - int
    doc: "Tau parameter, maximum number of backbone trees\n                      \
      \  (default: 5)"
    default: 5
    inputBinding:
      position: 101
      prefix: --tau
  - id: use_clusters
    type:
      - 'null'
      - boolean
    doc: "Use provided clustering (taking median read depth and\n                \
      \        using average frequency for variant counts)"
    inputBinding:
      position: 101
      prefix: --use_clusters
outputs:
  - id: output_filename
    type:
      - 'null'
      - File
    doc: Output filename to store trees and frequencies
    outputBinding:
      glob: $(inputs.output_filename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sapling:1.0.0--pyhdfd78af_0
