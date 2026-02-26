cwlVersion: v1.2
class: CommandLineTool
baseCommand: domainator_compare_contigs.py
label: domainator_compare_contigs.py
doc: "Calculates similarity metrics for gene neighborhoods\n\nTool homepage: https://github.com/nebiolabs/domainator"
inputs:
  - id: adjacency_index_weight
    type:
      - 'null'
      - float
    doc: weighting for adjacency index metric, a comparison of shared domain 
      pairs in the contigs. When two contigs have 0 or 1 domains, their ai is 
      1.0.
    default: 0.5
    inputBinding:
      position: 101
      prefix: --ai
  - id: config_file
    type:
      - 'null'
      - File
    doc: Path to a configuration file.
    default: None
    inputBinding:
      position: 101
      prefix: --config
  - id: contigs
    type:
      - 'null'
      - type: array
        items: string
    doc: 'only annotate contigs with ids in this list. Additive with --contigs_file.
      default: all contigs.'
    default: []
    inputBinding:
      position: 101
      prefix: --contigs
  - id: contigs_file
    type:
      - 'null'
      - File
    doc: 'only annotate contigs with ids listed in this file (one per line). Additive
      with --contigs. default: all contigs.'
    default: None
    inputBinding:
      position: 101
      prefix: --contigs_file
  - id: databases
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Domain databases to use for domain content comparison. default: all databases.'
    default: None
    inputBinding:
      position: 101
      prefix: --databases
  - id: dense_matrix_hdf5
    type:
      - 'null'
      - File
    doc: Write a dense distance matrix hdf5 file to this path.
    default: None
    inputBinding:
      position: 101
      prefix: --dense
  - id: dense_matrix_tsv
    type:
      - 'null'
      - File
    doc: Write a dense distance matrix tsv file to this path.
    default: None
    inputBinding:
      position: 101
      prefix: --dense_text
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Genbank filenames.
    default: None
    inputBinding:
      position: 101
      prefix: --input
  - id: jaccard_index_weight
    type:
      - 'null'
      - float
    doc: weighting for jaccard index metric, a comparison of all distinct types 
      of domains in the contigs. When two contigs have no domains, their ji is 
      1.0.
    default: 0.5
    inputBinding:
      position: 101
      prefix: --ji
  - id: name_by_order
    type:
      - 'null'
      - boolean
    doc: Will rename contigs in the genbank file such that they have a prefix 
      that can be sorted to restore the sorted order.
    default: false
    inputBinding:
      position: 101
      prefix: --name_by_order
  - id: print_config
    type:
      - 'null'
      - boolean
    doc: 'Print the configuration after applying all other arguments and exit. The
      optional flags customizes the output and are one or more keywords separated
      by comma. The supported flags are: comments, skip_default, skip_null.'
    inputBinding:
      position: 101
      prefix: --print_config
  - id: sparse_matrix_hdf5
    type:
      - 'null'
      - File
    doc: Write a sparse distance matrix hdf5 file to this path.
    default: None
    inputBinding:
      position: 101
      prefix: --sparse
  - id: top_hits_k
    type:
      - 'null'
      - int
    doc: 'for each metric, return scores for this many of the top hits, and consider
      all other hits to be zero. default: count all comparisons.'
    default: None
    inputBinding:
      position: 101
      prefix: -k
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: "Name of genbank output, contigs will be sorted hierarchically within the
      output genbank. If not supplied then no genbank output will be generated. To
      write to stdout, use '-'. default: None"
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/domainator:0.8.1--pyhdfd78af_0
