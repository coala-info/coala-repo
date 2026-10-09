cwlVersion: v1.2
class: CommandLineTool
baseCommand: lordec-build-SR-graph
label: lordec_lordec-build-SR-graph
doc: "Reads the FASTA/Q file(s) of short reads, then builds and saves their de Bruijn graph for k-mers of the given length occurring at least the given number of times; the graph is saved in an external file.\n\nTool homepage: http://www.atgc-montpellier.fr/lordec/"
inputs:
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 101
      prefix: -T
  - id: out_tmp
    type:
      - 'null'
      - string
    doc: GATB graph creation temporary files directory
    inputBinding:
      position: 102
      prefix: -O
  - id: abundance_max
    type:
      - 'null'
      - int
    doc: abundance max threshold for k-mers
    inputBinding:
      position: 103
      prefix: -a
  - id: short_reads
    type:
      type: array
      items: File
    doc: short read FASTA/Q file(s)
    inputBinding:
      position: 104
      prefix: '-2'
  - id: kmer_len
    type: int
    doc: k-mer size
    inputBinding:
      position: 105
      prefix: -k
  - id: solid_threshold
    type: int
    doc: solid k-mer abundance threshold
    inputBinding:
      position: 106
      prefix: -s
  - id: out_graph_file_path
    type: string
    doc: out graph file
    inputBinding:
      position: 107
      prefix: -g
outputs:
  - id: out_graph_file
    type: File
    doc: out graph file
    outputBinding:
      glob: $(inputs.out_graph_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lordec:0.9--h77376b9_3
