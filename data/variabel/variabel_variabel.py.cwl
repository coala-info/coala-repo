cwlVersion: v1.2
class: CommandLineTool
baseCommand: variabel
label: variabel_variabel.py
doc: "A tool for calling low-frequency variants in viral populations from NGS data.\n
  \nTool homepage: https://gitlab.com/treangenlab/variabel"
inputs:
  - id: bam
    type: File
    doc: Input BAM file containing aligned reads.
    inputBinding:
      position: 101
      prefix: --bam
  - id: min_alt_count
    type:
      - 'null'
      - int
    doc: Minimum number of reads supporting a variant.
    inputBinding:
      position: 101
      prefix: --min_alt_count
  - id: min_baseq
    type:
      - 'null'
      - int
    doc: Minimum base quality for a base to be considered.
    inputBinding:
      position: 101
      prefix: --min_baseq
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: Minimum mapping quality for a read to be considered.
    inputBinding:
      position: 101
      prefix: --min_mapq
  - id: min_variant_freq
    type:
      - 'null'
      - float
    doc: Minimum variant frequency threshold.
    inputBinding:
      position: 101
      prefix: --min_variant_freq
  - id: reference
    type: File
    doc: Reference genome in FASTA format.
    inputBinding:
      position: 101
      prefix: --ref
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for processing.
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file to write variants to.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/variabel:1.0.0--hdfd78af_0
