cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - prophyle
  - index
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
    type: string
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
      prefix: -c
  - id: autocomplete_tree
    type:
      - 'null'
      - boolean
    doc: autocomplete tree (names of internal nodes and FASTA paths)
    inputBinding:
      position: 103
      prefix: -A
  - id: keep_temporary_files
    type:
      - 'null'
      - boolean
    doc: keep temporary files from k-mer propagation
    inputBinding:
      position: 103
      prefix: -T
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: k-mer length
    inputBinding:
      position: 103
      prefix: -k
  - id: library_dir
    type:
      - 'null'
      - Directory
    doc: directory with the library sequences
    inputBinding:
      position: 103
      prefix: -g
  - id: log_file
    type:
      - 'null'
      - string
    doc: log file
    inputBinding:
      position: 103
      prefix: -l
  - id: mask_repeats
    type:
      - 'null'
      - boolean
    doc: mask repeats/low complexity regions (using DustMasker)
    inputBinding:
      position: 103
      prefix: -M
  - id: no_prefix_for_multiple_trees
    type:
      - 'null'
      - boolean
    doc: do not add prefixes to node names when multiple trees are used
    inputBinding:
      position: 103
      prefix: -P
  - id: rewrite_index
    type:
      - 'null'
      - boolean
    doc: rewrite index files if they already exist
    inputBinding:
      position: 103
      prefix: -F
  - id: sampling_rate
    type:
      - 'null'
      - float
    doc: rate of sampling of the tree
    inputBinding:
      position: 103
      prefix: -s
  - id: skip_k_lcp
    type:
      - 'null'
      - boolean
    doc: skip k-LCP construction (then restarted search only)
    inputBinding:
      position: 103
      prefix: -K
  - id: stop_after_propagation
    type:
      - 'null'
      - boolean
    doc: stop after k-mer propagation (no BWT index construction)
    inputBinding:
      position: 103
      prefix: -S
  - id: switch_propagation_off
    type:
      - 'null'
      - boolean
    doc: switch propagation off (only re-assemble leaves)
    inputBinding:
      position: 103
      prefix: -R
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 103
      prefix: -j
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: index_directory
    type: Directory
    doc: ProPhyle index directory
    outputBinding:
      glob: $(inputs.index_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prophyle:0.3.3.2--py39h746d604_3
stdout: prophyle_index.out
