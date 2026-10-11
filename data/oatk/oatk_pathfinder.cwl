cwlVersion: v1.2
class: CommandLineTool
baseCommand: pathfinder
label: oatk_pathfinder
doc: "Parses and circularises organelle genomes from an assembly graph using core gene annotations.\n\nTool homepage: https://github.com/c-zhou/oatk"
inputs:
  - id: gfa_file
    type: File
    doc: Assembly graph file in GFA format (plain or gzipped).
    inputBinding:
      position: 1
  - id: mito_annotation
    type:
      - 'null'
      - File
    doc: Mitochondria core gene annotation file.
    inputBinding:
      position: 102
      prefix: -m
  - id: plastid_annotation
    type:
      - 'null'
      - File
    doc: Plastid core gene annotation file.
    inputBinding:
      position: 102
      prefix: -p
  - id: prefer_circular_path
    type:
      - 'null'
      - float
    doc: Prefer circular path to longest if >= float sequence covered.
    inputBinding:
      position: 102
      prefix: -f
  - id: edge_c_tag
    type:
      - 'null'
      - string
    doc: Edge coverage tag in the gfa file.
    inputBinding:
      position: 102
      prefix: --edge-c-tag
  - id: kmer_c_tag
    type:
      - 'null'
      - string
    doc: Kmer coverage tag in the gfa file.
    inputBinding:
      position: 102
      prefix: --kmer-c-tag
  - id: seq_c_tag
    type:
      - 'null'
      - string
    doc: Sequence coverage tag in the gfa file.
    inputBinding:
      position: 102
      prefix: --seq-c-tag
  - id: verbose_level
    type:
      - 'null'
      - int
    doc: Verbose level.
    inputBinding:
      position: 102
      prefix: -v
  - id: min_core_gene_score
    type:
      - 'null'
      - float
    doc: Minimum annotation score of a core gene.
    inputBinding:
      position: 102
      prefix: -s
  - id: max_core_gene_evalue
    type:
      - 'null'
      - float
    doc: Maximum e-value of a core gene.
    inputBinding:
      position: 102
      prefix: -e
  - id: min_core_gene_gain
    type:
      - 'null'
      - string
    doc: Minimum number of core gene gain; the second integer is for mitochondria (for example 3,1).
    inputBinding:
      position: 102
      prefix: -g
  - id: min_singleton_length
    type:
      - 'null'
      - int
    doc: Minimum length of a singleton sequence to keep.
    inputBinding:
      position: 102
      prefix: -l
  - id: include_trn
    type:
      - 'null'
      - boolean
    doc: Include trna genes for sequence classification.
    inputBinding:
      position: 102
      prefix: --include-trn
  - id: include_rrn
    type:
      - 'null'
      - boolean
    doc: Include rrna genes for sequence classification.
    inputBinding:
      position: 102
      prefix: --include-rrn
  - id: min_sequence_coverage_ratio
    type:
      - 'null'
      - float
    doc: Minimum coverage of a sequence compared to the subgraph average.
    inputBinding:
      position: 102
      prefix: -q
  - id: max_copy_number
    type:
      - 'null'
      - int
    doc: Maximum copy number to consider.
    inputBinding:
      position: 102
      prefix: -c
  - id: max_bubble
    type:
      - 'null'
      - int
    doc: Maximum bubble size for assembly graph clean.
    inputBinding:
      position: 102
      prefix: --max-bubble
  - id: max_tip
    type:
      - 'null'
      - int
    doc: Maximum tip size for assembly graph clean.
    inputBinding:
      position: 102
      prefix: --max-tip
  - id: weak_cross
    type:
      - 'null'
      - float
    doc: Maximum relative edge coverage for weak crosslink clean.
    inputBinding:
      position: 102
      prefix: --weak-cross
  - id: no_graph_clean
    type:
      - 'null'
      - boolean
    doc: Do not do assembly graph clean.
    inputBinding:
      position: 102
      prefix: --no-graph-clean
  - id: output_prefix_path
    type: string
    doc: prefix of output files
    inputBinding:
      position: 103
      prefix: -o
outputs:
  - id: output_prefix
    type:
      type: array
      items: File
    doc: Organelle subgraph, contig FASTA and annotation files written with the output prefix
    outputBinding:
      glob: $(inputs.output_prefix_path)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/oatk:1.0--h577a1d6_1
