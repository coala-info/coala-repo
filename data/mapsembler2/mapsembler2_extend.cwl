cwlVersion: v1.2
class: CommandLineTool
baseCommand: mapsembler2_extend
label: mapsembler2_extend
doc: "Extends starter sequences using the reads, as a linear sequence or as a graph.\n\nTool
  homepage: https://colibread.inria.fr/software/mapsembler2/"
inputs:
  - id: extrem_kmers
    type: File
    doc: starters or starter extremities (fasta)
    inputBinding:
      position: 1
  - id: reads
    type:
      type: array
      items: File
    doc: read files (fasta or fastq)
    inputBinding:
      position: 2
  - id: extension_type
    type:
      - 'null'
      - int
    doc: 'extension type: 1 strict sequence, 2 consensus sequence, 3 strict graph,
      4 consensus graph'
    inputBinding:
      position: 3
      prefix: -t
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: size of the k-mers used during the extension phase
    inputBinding:
      position: 3
      prefix: -k
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: a sequence is covered by at least min_coverage coherent reads
    inputBinding:
      position: 3
      prefix: -c
  - id: genome_size
    type:
      - 'null'
      - long
    doc: estimation of the size of the genome whose reads come from (controls memory
      usage)
    inputBinding:
      position: 3
      prefix: -g
  - id: node_len
    type:
      - 'null'
      - int
    doc: limit max of nodes length
    inputBinding:
      position: 3
      prefix: -x
  - id: graph_max_depth
    type:
      - 'null'
      - int
    doc: limit max of graph depth
    inputBinding:
      position: 3
      prefix: -y
  - id: index_name
    type: string
    default: index
    doc: store the index files in files starting with this prefix name
    inputBinding:
      position: 3
      prefix: -i
  - id: output_prefix
    type: string
    default: res_mapsembler
    doc: where to write outputs (file name prefix)
    inputBinding:
      position: 3
      prefix: -o
  - id: search_mod
    type:
      - 'null'
      - string
    doc: kind of process, Breadth or Depth
    inputBinding:
      position: 3
      prefix: -p
outputs:
  - id: results
    type:
      type: array
      items: File
    doc: extension results (fasta, or json for graphs)
    outputBinding:
      glob: $(inputs.output_prefix)*
  - id: index_files
    type:
      - 'null'
      - type: array
        items: File
    doc: index files, reusable in later runs
    outputBinding:
      glob: $(inputs.index_name)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mapsembler2:2.2.4--2
