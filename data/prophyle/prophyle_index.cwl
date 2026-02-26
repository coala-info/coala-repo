cwlVersion: v1.2
class: CommandLineTool
baseCommand: prophyle_index
label: prophyle_index
doc: "Index phylogenetic trees for efficient querying.\n\nTool homepage: https://github.com/karel-brinda/prophyle"
inputs:
  - id: trees
    type:
      type: array
      items: File
    doc: phylogenetic tree (in Newick/NHX)
    inputBinding:
      position: 1
  - id: index_dir
    type: Directory
    doc: index directory (will be created)
    inputBinding:
      position: 2
  - id: advanced_config
    type:
      - 'null'
      - type: array
        items: string
    doc: advanced configuration (a JSON dictionary)
    inputBinding:
      position: 103
      prefix: --advanced-config
  - id: autocomplete_tree
    type:
      - 'null'
      - boolean
    doc: autocomplete tree (names of internal nodes and FASTA paths)
    inputBinding:
      position: 103
      prefix: --autocomplete-tree
  - id: keep_temporary_files
    type:
      - 'null'
      - boolean
    doc: keep temporary files from k-mer propagation
    inputBinding:
      position: 103
      prefix: --keep-temporary-files
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: k-mer length
    default: 31
    inputBinding:
      position: 103
      prefix: --kmer-length
  - id: library_dir
    type:
      - 'null'
      - Directory
    doc: directory with the library sequences
    inputBinding:
      position: 103
      prefix: --library-dir
  - id: log_file
    type:
      - 'null'
      - File
    doc: log file
    default: <index.dir>/log.txt
    inputBinding:
      position: 103
      prefix: --log-file
  - id: mask_repeats
    type:
      - 'null'
      - boolean
    doc: mask repeats/low complexity regions (using DustMasker)
    inputBinding:
      position: 103
      prefix: --mask-repeats
  - id: no_prefix_for_multiple_trees
    type:
      - 'null'
      - boolean
    doc: do not add prefixes to node names when multiple trees are used
    inputBinding:
      position: 103
      prefix: --no-prefix-for-multiple-trees
  - id: rewrite_index
    type:
      - 'null'
      - boolean
    doc: rewrite index files if they already exist
    inputBinding:
      position: 103
      prefix: --rewrite-index
  - id: sampling_rate
    type:
      - 'null'
      - float
    doc: rate of sampling of the tree
    inputBinding:
      position: 103
      prefix: --sampling-rate
  - id: skip_k_lcp
    type:
      - 'null'
      - boolean
    doc: skip k-LCP construction (then restarted search only)
    inputBinding:
      position: 103
      prefix: --skip-k-lcp
  - id: stop_after_propagation
    type:
      - 'null'
      - boolean
    doc: stop after k-mer propagation (no BWT index construction)
    inputBinding:
      position: 103
      prefix: --stop-after-propagation
  - id: switch_propagation_off
    type:
      - 'null'
      - boolean
    doc: switch propagation off (only re-assemble leaves)
    inputBinding:
      position: 103
      prefix: --switch-propagation-off
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    default: auto (20)
    inputBinding:
      position: 103
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prophyle:0.3.3.2--py39h746d604_3
stdout: prophyle_index.out
