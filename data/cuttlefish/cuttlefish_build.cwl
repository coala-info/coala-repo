cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cuttlefish
  - build
label: cuttlefish_build
doc: "Efficiently construct the compacted de Bruijn graph from sequencing reads or
  reference sequences\n\nTool homepage: https://github.com/COMBINE-lab/cuttlefish"
inputs:
  - id: construct_read_graph
    type:
      - 'null'
      - boolean
    doc: construct a compacted read de Bruijn graph (for FASTQ input)
    inputBinding:
      position: 101
      prefix: --read
  - id: construct_ref_graph
    type:
      - 'null'
      - boolean
    doc: construct a compacted reference de Bruijn graph (for FASTA input)
    inputBinding:
      position: 101
      prefix: --ref
  - id: cutoff
    type:
      - 'null'
      - int
    doc: frequency cutoff for (k + 1)-mers
    default: 'refs: 1, reads: 2'
    inputBinding:
      position: 101
      prefix: --cutoff
  - id: edge_set
    type:
      - 'null'
      - string
    doc: set of edges, i.e. (k + 1)-mers (KMC database) prefix
    default: ''
    inputBinding:
      position: 101
      prefix: --edge-set
  - id: input_directories
    type:
      - 'null'
      - type: array
        items: Directory
    doc: input file directories
    inputBinding:
      position: 101
      prefix: --dir
  - id: input_file_lists
    type:
      - 'null'
      - type: array
        items: File
    doc: input file lists
    inputBinding:
      position: 101
      prefix: --list
  - id: input_seq_files
    type:
      - 'null'
      - type: array
        items: File
    doc: input files
    inputBinding:
      position: 101
      prefix: --seq
  - id: kmer_len
    type:
      - 'null'
      - int
    doc: k-mer length
    default: 27
    inputBinding:
      position: 101
      prefix: --kmer-len
  - id: max_memory
    type:
      - 'null'
      - float
    doc: soft maximum memory limit in GB
    default: 3
    inputBinding:
      position: 101
      prefix: --max-memory
  - id: output_format
    type:
      - 'null'
      - string
    doc: 'output format (0: FASTA, 1: GFA 1.0, 2: GFA 2.0, 3: GFA-reduced)'
    inputBinding:
      position: 101
      prefix: --format
  - id: path_cover
    type:
      - 'null'
      - boolean
    doc: extract a maximal path cover of the de Bruijn graph
    inputBinding:
      position: 101
      prefix: --path-cover
  - id: poly_n_stretch
    type:
      - 'null'
      - boolean
    doc: includes information of polyN stretches in the tiling output
    inputBinding:
      position: 101
      prefix: --poly-N-stretch
  - id: save_buckets
    type:
      - 'null'
      - boolean
    doc: save the DFA-states collection of the vertices
    inputBinding:
      position: 101
      prefix: --save-buckets
  - id: save_mph
    type:
      - 'null'
      - boolean
    doc: save the minimal perfect hash (BBHash) over the vertex set
    inputBinding:
      position: 101
      prefix: --save-mph
  - id: save_vertices
    type:
      - 'null'
      - boolean
    doc: save the vertex set of the graph
    inputBinding:
      position: 101
      prefix: --save-vertices
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use
    default: 5
    inputBinding:
      position: 101
      prefix: --threads
  - id: track_short_seqs
    type:
      - 'null'
      - boolean
    doc: track existence of sequences shorter than k bases
    inputBinding:
      position: 101
      prefix: --track-short-seqs
  - id: unrestrict_memory
    type:
      - 'null'
      - boolean
    doc: do not impose memory usage restriction
    inputBinding:
      position: 101
      prefix: --unrestrict-memory
  - id: vertex_set
    type:
      - 'null'
      - string
    doc: set of vertices, i.e. k-mers (KMC database) prefix
    default: ''
    inputBinding:
      position: 101
      prefix: --vertex-set
  - id: work_dir
    type:
      - 'null'
      - Directory
    doc: working directory
    default: .
    inputBinding:
      position: 101
      prefix: --work-dir
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cuttlefish:2.2.0--h6b3f7d6_5
