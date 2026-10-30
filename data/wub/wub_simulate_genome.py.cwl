cwlVersion: v1.2
class: CommandLineTool
baseCommand: simulate_genome.py
label: wub_simulate_genome.py
doc: "Simulate genome sequence with the specified number of chromosomes, length distribution (truncated gamma) and base composition.\n\nTool homepage: https://github.com/nanoporetech/wub"
inputs:
  - id: nr_chrom
    type:
      - 'null'
      - int
    doc: "Number of chromosomes (23)."
    inputBinding:
      position: 1
      prefix: -n
  - id: mean_length
    type:
      - 'null'
      - int
    doc: "Mean length of chromosomes (5000000)."
    inputBinding:
      position: 2
      prefix: -m
  - id: gamma_shape
    type:
      - 'null'
      - float
    doc: "Gamma shape parameter (1)."
    inputBinding:
      position: 3
      prefix: -a
  - id: low_trunc
    type:
      - 'null'
      - int
    doc: "Lower truncation point (None)."
    inputBinding:
      position: 4
      prefix: -l
  - id: high_trunc
    type:
      - 'null'
      - int
    doc: "Upper truncation point (None)."
    inputBinding:
      position: 5
      prefix: -u
  - id: base_freqs
    type:
      - 'null'
      - string
    doc: "Relative base frequencies in A,C,G,T order (1,1,1,1) or \"random\"."
    inputBinding:
      position: 6
      prefix: -b
  - id: random_seed
    type:
      - 'null'
      - int
    doc: "Random seed (None)."
    inputBinding:
      position: 7
      prefix: -z
  - id: output_fasta
    type:
      - 'null'
      - string
    default: "simulate_genome.fasta"
    doc: "Output fasta (default: stdout)"
    inputBinding:
      position: 100
outputs:
  - id: genome_fasta
    type: File
    doc: "Simulated genome"
    outputBinding:
      glob: $(inputs.output_fasta)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
