cwlVersion: v1.2
class: CommandLineTool
baseCommand: monovar.py
label: monovar
doc: "Monovar is a Single Nucleotide Variant (SNV) caller for single-cell DNA sequencing
  data. It is designed to handle the high levels of noise and allelic dropout common
  in single-cell sequencing.\n\nTool homepage: https://bitbucket.org/hamimzafar/monovar"
inputs:
  - id: bam_list
    type: File
    doc: Input file containing paths of BAM files
    inputBinding:
      position: 101
      prefix: --bamfile
  - id: consensus
    type:
      - 'null'
      - boolean
    doc: Output consensus genotype
    inputBinding:
      position: 101
      prefix: --consensus
  - id: min_base_quality
    type:
      - 'null'
      - int
    doc: Minimum base quality
    inputBinding:
      position: 101
      prefix: --min_bq
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: Minimum mapping quality
    inputBinding:
      position: 101
      prefix: --min_mq
  - id: prob_threshold
    type:
      - 'null'
      - float
    doc: Threshold for the probability of being a variant
    inputBinding:
      position: 101
      prefix: --prob_threshold
  - id: reference
    type: File
    doc: Reference genome file (FASTA)
    inputBinding:
      position: 101
      prefix: --ref
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_vcf
    type: File
    doc: Output VCF file
    outputBinding:
      glob: $(inputs.output_vcf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/monovar:v0.0.1--py27_0
