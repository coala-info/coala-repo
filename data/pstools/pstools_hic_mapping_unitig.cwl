cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pstools
  - hic_mapping_unitig
label: pstools_hic_mapping_unitig
doc: "Map Hi-C reads to unitig graphs\n\nTool homepage: https://github.com/shilpagarg/pstools"
inputs:
  - id: graph_file
    type: File
    doc: Input graph file (FASTA format)
    inputBinding:
      position: 1
  - id: hic_r1_fastq
    type: File
    doc: Hi-C R1 fastq.gz file
    inputBinding:
      position: 2
  - id: hic_r2_fastq
    type: File
    doc: Hi-C R2 fastq.gz file
    inputBinding:
      position: 3
  - id: bloom_filter_size
    type:
      - 'null'
      - int
    doc: set Bloom filter size to 2**INT bits; 0 to disable
    default: 0
    inputBinding:
      position: 104
      prefix: -b
  - id: chunk_size
    type:
      - 'null'
      - string
    doc: chunk size
    default: 100m
    inputBinding:
      position: 104
      prefix: -K
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: k-mer size
    default: 31
    inputBinding:
      position: 104
      prefix: -k
  - id: prefix_length
    type:
      - 'null'
      - int
    doc: prefix length
    default: 20
    inputBinding:
      position: 104
      prefix: -p
  - id: threads
    type:
      - 'null'
      - int
    doc: number of worker threads
    default: 32
    inputBinding:
      position: 104
      prefix: -t
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: save mapping relationship to FILE
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pstools:0.2a3--h077b44d_4
