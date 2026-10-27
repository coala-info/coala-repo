cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vg
  - index
label: vg_index
doc: "Creates an index on the specified graph or graphs. All graphs indexed must already
  be in a joint ID space.\n\nTool homepage: https://github.com/vgteam/vg"
inputs:
  - id: graphs
    type:
      - 'null'
      - type: array
        items: File
    doc: Graph file(s) to index
    inputBinding:
      position: 1
  - id: dist_name
    type:
      - 'null'
      - string
    doc: use this file to store a snarl-based distance index
    inputBinding:
      position: 102
      prefix: --dist-name
  - id: doubling_steps
    type:
      - 'null'
      - int
    doc: use N doubling steps for GCSA2 construction
    inputBinding:
      position: 102
      prefix: --doubling-steps
  - id: index_sorted_gam
    type:
      - 'null'
      - boolean
    doc: input is sorted .gam format alignments, store a GAI index of the sorted
      GAM in INPUT.gam.gai
    inputBinding:
      position: 102
      prefix: --index-sorted-gam
  - id: index_sorted_vg
    type:
      - 'null'
      - boolean
    doc: input is ID-sorted .vg format graph chunks store a VGI index of the 
      sorted vg in INPUT.vg.vgi
    inputBinding:
      position: 102
      prefix: --index-sorted-vg
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: index kmers of size N in the graph
    inputBinding:
      position: 102
      prefix: --kmer-size
  - id: mapping_file
    type:
      - 'null'
      - File
    doc: use this node mapping in GCSA2 construction
    inputBinding:
      position: 102
      prefix: --mapping
  - id: no_nested_distance
    type:
      - 'null'
      - boolean
    doc: only store distances along the top-level chain
    inputBinding:
      position: 102
      prefix: --no-nested-distance
  - id: progress
    type:
      - 'null'
      - boolean
    doc: show progress
    inputBinding:
      position: 102
      prefix: --progress
  - id: size_limit
    type:
      - 'null'
      - int
    doc: limit temp disk space usage to N GB
    inputBinding:
      position: 102
      prefix: --size-limit
  - id: snarl_limit
    type:
      - 'null'
      - int
    doc: don't store distances for snarls > N nodes [50000] if 0 then don't 
      store distances, only the snarl tree
    inputBinding:
      position: 102
      prefix: --snarl-limit
  - id: temp_dir
    type:
      - 'null'
      - string
    doc: use DIR for temporary files
    inputBinding:
      position: 102
      prefix: --temp-dir
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use
    inputBinding:
      position: 102
      prefix: --threads
  - id: upweight_node
    type:
      - 'null'
      - type: array
        items: int
        inputBinding:
          prefix: --upweight-node
    doc: upweight the node with ID N to push it to be part of a top-level chain 
      (may repeat)
    inputBinding:
      position: 102
  - id: verify_index
    type:
      - 'null'
      - boolean
    doc: validate the GCSA2 index using the input kmers (important for testing)
    inputBinding:
      position: 102
      prefix: --verify-index
  - id: xg_alts
    type:
      - 'null'
      - boolean
    doc: include alt paths in XG
    inputBinding:
      position: 102
      prefix: --xg-alts
  - id: xg_in
    type:
      - 'null'
      - File
    doc: existing XG index to read for GCSA or distance indexing (use instead of
      graphs)
    inputBinding:
      position: 102
      prefix: --xg-name
  - id: xg_name
    type:
      - 'null'
      - string
    doc: use this file to store a succinct, queryable version of graph(s), or 
      read for GCSA or distance indexing
    inputBinding:
      position: 102
      prefix: --xg-name
  - id: gcsa_out_path
    type:
      - 'null'
      - string
    doc: output GCSA2 (FILE) & LCP (FILE.lcp) indexes
    inputBinding:
      position: 103
      prefix: --gcsa-out
outputs:
  - id: xg_out
    type:
      - 'null'
      - File
    doc: XG index written when xg_name is given
    outputBinding:
      glob: $(inputs.xg_name)
  - id: dist_out
    type:
      - 'null'
      - File
    doc: Snarl-based distance index written when dist_name is given
    outputBinding:
      glob: $(inputs.dist_name)
  - id: gcsa_out
    type:
      - 'null'
      - File
    doc: GCSA2 index written when gcsa_out_path is given
    outputBinding:
      glob: $(inputs.gcsa_out_path)
  - id: gcsa_lcp_out
    type:
      - 'null'
      - File
    doc: LCP file of the GCSA2 index (<gcsa_out_path>.lcp)
    outputBinding:
      glob: "${ return inputs.gcsa_out_path ? inputs.gcsa_out_path + '.lcp' : []; }"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vg:1.70.0--h9ee0642_0
