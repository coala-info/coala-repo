cwlVersion: v1.2
class: CommandLineTool
baseCommand: locityper
label: locityper_prune
doc: "Remove similar target haplotypes.\n\nTool homepage: https://github.com/tprodanov/locityper"
inputs:
  - id: alignments
    type:
      - 'null'
      - File
    doc: "Path to alignment .paf[.gz] files [haplotypes.paf.gz].\n               \
      \             Should either contain {}, which are then replaced with locus names,\n\
      \                            or direct to files located in INPUT/loci/<locus>/PATH.\n\
      \                            Alignments can be constructed using locityper align."
    default: haplotypes.paf.gz
    inputBinding:
      position: 101
      prefix: --alignments
  - id: field
    type:
      - 'null'
      - string
    doc: PAF field with divergence values [dv].
    default: dv
    inputBinding:
      position: 101
      prefix: --field
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force rewrite output directory.
    inputBinding:
      position: 101
      prefix: --force
  - id: input_db
    type: Directory
    doc: Input database directory.
    inputBinding:
      position: 101
      prefix: --input
  - id: n_clusters
    type:
      - 'null'
      - int
    doc: Use dynamic threshold to get approximately INT clusters.
    inputBinding:
      position: 101
      prefix: --n-clusters
  - id: power
    type:
      - 'null'
      - float
    doc: "Select cluster representative with the smallest\n                      \
      \      generalized mean of this power [2]."
    default: 2
    inputBinding:
      position: 101
      prefix: --power
  - id: skip_tree
    type:
      - 'null'
      - boolean
    doc: Do not write trees in the output directory.
    inputBinding:
      position: 101
      prefix: --skip-tree
  - id: subset_loci
    type:
      - 'null'
      - type: array
        items: string
    doc: Limit the pruning to loci from this list.
    inputBinding:
      position: 101
      prefix: --subset-loci
  - id: threshold
    type:
      - 'null'
      - float
    doc: Divergence threshold for pruning [0.0002].
    default: 0.0002
    inputBinding:
      position: 101
      prefix: --threshold
outputs:
  - id: output_db
    type: Directory
    doc: Output pruned database directory.
    outputBinding:
      glob: $(inputs.output_db)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/locityper:1.3.4--ha6fb395_0
