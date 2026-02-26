cwlVersion: v1.2
class: CommandLineTool
baseCommand: wfmash
label: wfmash
doc: "wfmash [target.fa] [query.fa] {OPTIONS}\n\nTool homepage: https://github.com/ekg/wfmash"
inputs:
  - id: target_fa
    type: File
    doc: target sequences (required)
    inputBinding:
      position: 1
  - id: query_fa
    type:
      - 'null'
      - File
    doc: 'query sequences (default: self-map)'
    default: self-map
    inputBinding:
      position: 2
  - id: align_paf
    type:
      - 'null'
      - File
    doc: align from PAF file
    inputBinding:
      position: 103
      prefix: --align-paf
  - id: ani_sketch_size
    type:
      - 'null'
      - int
    doc: sketch size for ANI estimation
    default: 1000
    inputBinding:
      position: 103
      prefix: --ani-sketch-size
  - id: approx_mapping
    type:
      - 'null'
      - boolean
    doc: output mappings only (no alignment)
    inputBinding:
      position: 103
      prefix: --approx-mapping
  - id: batch_size
    type:
      - 'null'
      - string
    doc: target batch size for indexing
    default: 4G
    inputBinding:
      position: 103
      prefix: --batch
  - id: block_length
    type:
      - 'null'
      - int
    doc: minimum block length
    default: 0
    inputBinding:
      position: 103
      prefix: --block-length
  - id: chain_jump
    type:
      - 'null'
      - string
    doc: chain jump (gap)
    default: 2k
    inputBinding:
      position: 103
      prefix: --chain-jump
  - id: filter_freq
    type:
      - 'null'
      - float
    doc: filter high-freq minimizers
    default: 0.0002
    inputBinding:
      position: 103
      prefix: --filter-freq
  - id: group_prefix
    type:
      - 'null'
      - string
    doc: group by last occurrence of prefix delimiter
    default: '#'
    inputBinding:
      position: 103
      prefix: --group-prefix
  - id: hg_filter
    type:
      - 'null'
      - string
    doc: hypergeometric filter
    default: 1.0,0.0,99.9
    inputBinding:
      position: 103
      prefix: --hg-filter
  - id: input_seeds
    type:
      - 'null'
      - File
    doc: use external PAF seeds instead of MinHash
    inputBinding:
      position: 103
      prefix: --input-seeds
  - id: keep_temp
    type:
      - 'null'
      - boolean
    doc: retain temporary files
    inputBinding:
      position: 103
      prefix: --keep-temp
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: k-mer size
    default: 15
    inputBinding:
      position: 103
      prefix: --kmer-size
  - id: l1_hits
    type:
      - 'null'
      - int
    doc: min hits for L1 filtering
    default: 3
    inputBinding:
      position: 103
      prefix: --l1-hits
  - id: lower_triangular
    type:
      - 'null'
      - boolean
    doc: only map seq_i to seq_j if i>j
    inputBinding:
      position: 103
      prefix: --lower-triangular
  - id: map_pct_id
    type:
      - 'null'
      - string
    doc: minimum identity % or ANI preset
    default: ani50-2
    inputBinding:
      position: 103
      prefix: --map-pct-id
  - id: mappings
    type:
      - 'null'
      - int
    doc: mappings per segment (plane sweep)
    default: inf
    inputBinding:
      position: 103
      prefix: --mappings
  - id: max_length
    type:
      - 'null'
      - string
    doc: max mapping length
    default: 50k
    inputBinding:
      position: 103
      prefix: --max-length
  - id: md_tag
    type:
      - 'null'
      - boolean
    doc: include MD tag
    inputBinding:
      position: 103
      prefix: --md-tag
  - id: no_filter
    type:
      - 'null'
      - boolean
    doc: disable all filtering
    inputBinding:
      position: 103
      prefix: --no-filter
  - id: no_merge
    type:
      - 'null'
      - boolean
    doc: keep all fragment mappings
    inputBinding:
      position: 103
      prefix: --no-merge
  - id: no_split
    type:
      - 'null'
      - boolean
    doc: map each sequence in one piece
    inputBinding:
      position: 103
      prefix: --no-split
  - id: one_to_one
    type:
      - 'null'
      - boolean
    doc: best mapping per query AND target
    inputBinding:
      position: 103
      prefix: --one-to-one
  - id: overlap
    type:
      - 'null'
      - float
    doc: max overlap ratio
    default: 0.95
    inputBinding:
      position: 103
      prefix: --overlap
  - id: query_list
    type:
      - 'null'
      - File
    doc: file with query sequence names
    inputBinding:
      position: 103
      prefix: --query-list
  - id: query_padding
    type:
      - 'null'
      - string
    doc: query padding
    default: segment-length
    inputBinding:
      position: 103
      prefix: --query-padding
  - id: query_prefix
    type:
      - 'null'
      - string
    doc: query name prefix filter
    inputBinding:
      position: 103
      prefix: --query-prefix
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: disable progress output
    inputBinding:
      position: 103
      prefix: --quiet
  - id: read_index
    type:
      - 'null'
      - File
    doc: load index from FILE
    inputBinding:
      position: 103
      prefix: --read-index
  - id: retain_per_scaffold
    type:
      - 'null'
      - int
    doc: mappings per scaffold chain
    default: 1
    inputBinding:
      position: 103
      prefix: --retain-per-scaffold
  - id: sam_format
    type:
      - 'null'
      - boolean
    doc: 'SAM format (default: PAF)'
    inputBinding:
      position: 103
      prefix: --sam
  - id: scaffold_dist
    type:
      - 'null'
      - string
    doc: max scaffold distance
    default: 100k
    inputBinding:
      position: 103
      prefix: --scaffold-dist
  - id: scaffold_jump
    type:
      - 'null'
      - string
    doc: scaffold jump (gap)
    default: 100k
    inputBinding:
      position: 103
      prefix: --scaffold-jump
  - id: scaffold_mass
    type:
      - 'null'
      - string
    doc: min scaffold length
    default: 10k
    inputBinding:
      position: 103
      prefix: --scaffold-mass
  - id: scaffold_overlap
    type:
      - 'null'
      - float
    doc: scaffold chain overlap threshold
    default: 0.5
    inputBinding:
      position: 103
      prefix: --scaffold-overlap
  - id: self_maps
    type:
      - 'null'
      - boolean
    doc: include self mappings
    inputBinding:
      position: 103
      prefix: --self-maps
  - id: sketch_size
    type:
      - 'null'
      - string
    doc: sketch size
    default: auto
    inputBinding:
      position: 103
      prefix: --sketch-size
  - id: sparsify
    type:
      - 'null'
      - float
    doc: keep this fraction of mappings
    default: 1.0
    inputBinding:
      position: 103
      prefix: --sparsify
  - id: streaming_minhash
    type:
      - 'null'
      - boolean
    doc: use streaming MinHash algorithm (experimental)
    inputBinding:
      position: 103
      prefix: --streaming-minhash
  - id: target_list
    type:
      - 'null'
      - File
    doc: file with target sequence names
    inputBinding:
      position: 103
      prefix: --target-list
  - id: target_padding
    type:
      - 'null'
      - string
    doc: target padding
    default: segment-length
    inputBinding:
      position: 103
      prefix: --target-padding
  - id: target_prefix
    type:
      - 'null'
      - string
    doc: target name prefix filter
    inputBinding:
      position: 103
      prefix: --target-prefix
  - id: threads
    type:
      - 'null'
      - int
    doc: threads
    default: 1
    inputBinding:
      position: 103
      prefix: --threads
  - id: tmp_base
    type:
      - 'null'
      - Directory
    doc: temp file directory
    default: pwd
    inputBinding:
      position: 103
      prefix: --tmp-base
  - id: wfa_params
    type:
      - 'null'
      - string
    doc: gap costs
    default: 5,8,2,24,1
    inputBinding:
      position: 103
      prefix: --wfa-params
  - id: window_size
    type:
      - 'null'
      - string
    doc: window size
    default: 1k
    inputBinding:
      position: 103
      prefix: --window-size
  - id: write_index
    type:
      - 'null'
      - File
    doc: save index to FILE
    inputBinding:
      position: 103
      prefix: --write-index
outputs:
  - id: scaffold_out
    type:
      - 'null'
      - File
    doc: output scaffold mappings to FILE
    outputBinding:
      glob: $(inputs.scaffold_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wfmash:0.24.2--h27bdcc9_0
