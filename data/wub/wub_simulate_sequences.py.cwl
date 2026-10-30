cwlVersion: v1.2
class: CommandLineTool
baseCommand: simulate_sequences.py
label: wub_simulate_sequences.py
doc: "Simulate sequences of fixed length and specified base composition.\n\nTool homepage: https://github.com/nanoporetech/wub"
inputs:
  - id: nr_seq
    type:
      - 'null'
      - int
    doc: "Number of sequences (1)."
    inputBinding:
      position: 1
      prefix: -n
  - id: length
    type:
      - 'null'
      - int
    doc: "Length of simulated sequences (3000)."
    inputBinding:
      position: 2
      prefix: -m
  - id: base_freqs
    type:
      - 'null'
      - string
    doc: "Relative base frequencies in A,C,G,T order (1,1,1,1)."
    inputBinding:
      position: 3
      prefix: -b
  - id: random_seed
    type:
      - 'null'
      - int
    doc: "Random seed (None)."
    inputBinding:
      position: 4
      prefix: -z
  - id: output_fasta
    type:
      - 'null'
      - string
    default: "simulate_sequences.fasta"
    doc: "Output fasta (default: stdout)"
    inputBinding:
      position: 100
outputs:
  - id: sequences_fasta
    type: File
    doc: "Simulated sequences"
    outputBinding:
      glob: $(inputs.output_fasta)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
