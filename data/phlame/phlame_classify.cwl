cwlVersion: v1.2
class: CommandLineTool
baseCommand: phlame_classify
label: phlame_classify
doc: "Classify lineages from bam files.\n\nTool homepage: https://github.com/quevan/phlame"
inputs:
  - id: classifier
    type: File
    doc: Path to classifer file (required).
    inputBinding:
      position: 101
      prefix: -c
  - id: inference_algorithm
    type:
      - 'null'
      - string
    doc: Inference algorithm to use. Defaults to 'mle'
    inputBinding:
      position: 101
      prefix: -m
  - id: input_bam
    type: File
    doc: Path to input bam file (required).
    inputBinding:
      position: 101
      prefix: -i
  - id: level
    type:
      - 'null'
      - string
    doc: Level specification.
    inputBinding:
      position: 101
      prefix: -l
  - id: max_pi
    type:
      - 'null'
      - float
    doc: Maximum Divergence to count a lineage as present.
    inputBinding:
      position: 101
      prefix: --max_pi
  - id: min_hpd
    type:
      - 'null'
      - float
    doc: 'Bayesian only: Minimum value the highest posterior density interval over
      divergence must cover to count a lineage as present.'
    inputBinding:
      position: 101
      prefix: --min_hpd
  - id: min_prob
    type:
      - 'null'
      - float
    doc: 'Bayesian only: Minimum probability score to count a lineage as present.'
    inputBinding:
      position: 101
      prefix: --min_prob
  - id: min_snps
    type:
      - 'null'
      - int
    doc: Minimum number of present mutations to count a lineage as present.
    inputBinding:
      position: 101
      prefix: --min_snps
  - id: reference_genome
    type: File
    doc: Path to reference genome (required, fasta format).
    inputBinding:
      position: 101
      prefix: -r
  - id: seed
    type:
      - 'null'
      - int
    doc: Set random seed for reproducibility.
    inputBinding:
      position: 101
      prefix: --seed
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print progress messages.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_frequencies
    type: File
    doc: Path to output frequencies file (required).
    outputBinding:
      glob: $(inputs.output_frequencies)
  - id: output_data
    type: File
    doc: Path to output data file (required).
    outputBinding:
      glob: $(inputs.output_data)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phlame:1.1.0--pyhdfd78af_0
