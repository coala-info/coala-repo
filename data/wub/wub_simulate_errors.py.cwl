cwlVersion: v1.2
class: CommandLineTool
baseCommand: simulate_errors.py
label: wub_simulate_errors.py
doc: "Simulate sequencing errors for each input sequence.\n\nTool homepage: https://github.com/nanoporetech/wub"
inputs:
  - id: error_rate
    type:
      - 'null'
      - float
    doc: "Total rate of substitutions insertions and deletions (0.1)."
    inputBinding:
      position: 1
      prefix: -e
  - id: error_weights
    type:
      - 'null'
      - string
    doc: "Relative frequency of substitutions,insertions,deletions (1,1,4)."
    inputBinding:
      position: 2
      prefix: -w
  - id: random_seed
    type:
      - 'null'
      - int
    doc: "Random seed (None)."
    inputBinding:
      position: 3
      prefix: -z
  - id: input_fasta
    type: File
    doc: "Input fasta (default: stdin)."
    inputBinding:
      position: 100
  - id: output_fasta
    type:
      - 'null'
      - string
    default: "simulate_errors.fasta"
    doc: "Output fasta (default: stdout)"
    inputBinding:
      position: 101
outputs:
  - id: simulated_fasta
    type: File
    doc: "Sequences with simulated errors"
    outputBinding:
      glob: $(inputs.output_fasta)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
