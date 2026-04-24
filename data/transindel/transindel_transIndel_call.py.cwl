cwlVersion: v1.2
class: CommandLineTool
baseCommand: transIndel_call.py
label: transindel_transIndel_call.py
doc: "Call transcript-supported insertions and deletions (indels) from RNA-seq data.\n
  \nTool homepage: https://github.com/cauyrd/transIndel"
inputs:
  - id: input_bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 101
      prefix: -i
  - id: min_base_quality
    type:
      - 'null'
      - int
    doc: Minimum base quality
    inputBinding:
      position: 101
      prefix: -q
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: Minimum mapping quality
    inputBinding:
      position: 101
      prefix: -m
  - id: min_reads
    type:
      - 'null'
      - int
    doc: Minimum number of supporting reads
    inputBinding:
      position: 101
      prefix: -n
  - id: reference
    type: File
    doc: Reference genome FASTA file
    inputBinding:
      position: 101
      prefix: -r
outputs:
  - id: output_prefix
    type: File
    doc: Prefix for output files
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transindel:2.0--hdfd78af_0
