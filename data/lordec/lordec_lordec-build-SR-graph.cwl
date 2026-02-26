cwlVersion: v1.2
class: CommandLineTool
baseCommand: lordec-build-SR-graph
label: lordec_lordec-build-SR-graph
doc: "reads the <FASTA/Q file(s)> of short reads, then builds and save their de Bruijn
  graph for k-mers of length <k-mer size> and occurring at least <abundance threshold>
  time; the graph is saved in an external file named <out graph file>\n\nTool homepage:
  http://www.atgc-montpellier.fr/lordec/"
inputs:
  - id: abundance_max_threshold
    type:
      - 'null'
      - int
    doc: abundance max threshold for k-mers
    inputBinding:
      position: 101
      prefix: -a
  - id: gatb_graph_temp_dir
    type:
      - 'null'
      - Directory
    doc: GATB graph creation temporary files directory
    inputBinding:
      position: 101
      prefix: -O
  - id: kmer_size
    type: int
    doc: k-mer size
    inputBinding:
      position: 101
      prefix: -k
  - id: short_read_files
    type:
      type: array
      items: File
    doc: short read FASTA/Q file(s)
    inputBinding:
      position: 101
      prefix: '-2'
  - id: solid_kmer_abundance_threshold
    type: int
    doc: solid k-mer abundance threshold
    inputBinding:
      position: 101
      prefix: -s
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 101
      prefix: -T
outputs:
  - id: out_graph_file
    type: File
    doc: out graph file
    outputBinding:
      glob: $(inputs.out_graph_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lordec:0.9--h77376b9_3
