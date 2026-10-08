cwlVersion: v1.2
class: CommandLineTool
baseCommand: reconstruct_graph_from_fasta.py
label: getorganelle_reconstruct_graph_from_fasta.py
doc: "Convert sequences back into an assembly graph (GFA, or FASTG when the output name ends with .fastg) using a naive De Bruijn approach.\n\nTool homepage: http://github.com/Kinggerm/GetOrganelle"
inputs:
  - id: input_fasta
    type: File
    doc: "Input fasta file."
    inputBinding:
      position: 101
      prefix: -i
  - id: output_graph
    type: string
    doc: "Output graph file. The output format is GFA by default, but FASTG only when indicated with postfix '.fastg'."
    inputBinding:
      position: 101
      prefix: -o
  - id: overlap
    type:
      - 'null'
      - int
    doc: "Overlap for reconstructing De Bruijn graph. Default: 55"
    inputBinding:
      position: 101
      prefix: -L
  - id: circular
    type:
      - 'null'
      - string
    doc: "Sequences in input fasta file are all circular (yes/no/auto). Default: auto"
    inputBinding:
      position: 101
      prefix: -c
  - id: single_chain
    type:
      - 'null'
      - boolean
    doc: "Turn off the treatment of the input as double-chain DNA with its complementary sequence."
    inputBinding:
      position: 101
      prefix: --single-chain
  - id: out_kg
    type:
      - 'null'
      - string
    doc: "Output kmer node graph."
    inputBinding:
      position: 101
      prefix: --out-kg
outputs:
  - id: graph_file
    type: File
    doc: "The reconstructed assembly graph."
    outputBinding:
      glob: "$(inputs.output_graph)"
  - id: kmer_graph
    type: File?
    doc: "Kmer node graph, written only with out_kg."
    outputBinding:
      glob: "$(inputs.out_kg)"
  - id: stdout
    type: stdout
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/getorganelle:1.7.7.1--pyhdfd78af_0
stdout: getorganelle_reconstruct_graph_from_fasta.py.out
