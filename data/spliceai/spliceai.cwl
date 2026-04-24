cwlVersion: v1.2
class: CommandLineTool
baseCommand: spliceai
label: spliceai
doc: "SpliceAI predicts the impact of variants on RNA splicing.\n\nTool homepage:
  https://github.com/Illumina/SpliceAI"
inputs:
  - id: annotation
    type: File
    doc: GTF/GFF3 annotation file
    inputBinding:
      position: 101
      prefix: --annotation
  - id: distance
    type:
      - 'null'
      - int
    doc: Maximum distance from splice sites to consider
    inputBinding:
      position: 101
      prefix: --distance
  - id: input
    type:
      - 'null'
      - File
    doc: Input VCF file
    inputBinding:
      position: 101
      prefix: --input
  - id: mask
    type:
      - 'null'
      - File
    doc: Mask regions (BED file)
    inputBinding:
      position: 101
      prefix: --mask
  - id: reference
    type: File
    doc: Reference genome FASTA file
    inputBinding:
      position: 101
      prefix: --reference
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output VCF file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spliceai:1.3.1--pyh864c0ab_1
