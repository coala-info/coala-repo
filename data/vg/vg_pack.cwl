cwlVersion: v1.2
class: CommandLineTool
baseCommand: vg pack
label: vg_pack
doc: "Compresses alignments into coverage packs.\n\nTool homepage: https://github.com/vgteam/vg"
inputs:
  - id: as_edge_table
    type:
      - 'null'
      - boolean
    doc: write table on stdout representing edge coverage
    inputBinding:
      position: 101
      prefix: --as-edge-table
  - id: as_qual_table
    type:
      - 'null'
      - boolean
    doc: write table on stdout representing average node mapqs
    inputBinding:
      position: 101
      prefix: --as-qual-table
  - id: as_table
    type:
      - 'null'
      - boolean
    doc: write table on stdout representing packs
    inputBinding:
      position: 101
      prefix: --as-table
  - id: bin_size
    type:
      - 'null'
      - int
    doc: number of sequence bases per CSA bin
    default: inf
    inputBinding:
      position: 101
      prefix: --bin-size
  - id: expected_cov
    type:
      - 'null'
      - int
    doc: expected coverage. used only for memory tuning
    default: 128
    inputBinding:
      position: 101
      prefix: --expected-cov
  - id: gaf_file
    type:
      - 'null'
      - File
    doc: read alignments from this GAF file ('-' for stdin)
    inputBinding:
      position: 101
      prefix: --gaf
  - id: gam_file
    type:
      - 'null'
      - File
    doc: read alignments from this GAM file ('-' for stdin)
    inputBinding:
      position: 101
      prefix: --gam
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: ignore reads with MAPQ < N and positions with base quality < N
    default: 0
    inputBinding:
      position: 101
      prefix: --min-mapq
  - id: node
    type:
      - 'null'
      - type: array
        items: int
    doc: write table for only specified node(s)
    inputBinding:
      position: 101
      prefix: --node
  - id: node_list
    type:
      - 'null'
      - File
    doc: white space or line delimited list of nodes to collect
    inputBinding:
      position: 101
      prefix: --node-list
  - id: packs_in
    type:
      - 'null'
      - type: array
        items: File
    doc: begin by summing coverage packs from each provided FILE
    inputBinding:
      position: 101
      prefix: --packs-in
  - id: threads
    type:
      - 'null'
      - int
    doc: use N threads
    default: numCPUs
    inputBinding:
      position: 101
      prefix: --threads
  - id: trim_ends
    type:
      - 'null'
      - int
    doc: ignore the first and last N bases of each read
    inputBinding:
      position: 101
      prefix: --trim-ends
  - id: with_edits
    type:
      - 'null'
      - boolean
    doc: record and write edits rather than only recording graph-matching 
      coverage
    inputBinding:
      position: 101
      prefix: --with-edits
  - id: xg_graph
    type:
      - 'null'
      - File
    doc: use this basis graph (does not have to be xg format)
    inputBinding:
      position: 101
      prefix: --xg
outputs:
  - id: packs_out
    type:
      - 'null'
      - File
    doc: write compressed coverage packs to this output file
    outputBinding:
      glob: $(inputs.packs_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vg:1.70.0--h9ee0642_0
