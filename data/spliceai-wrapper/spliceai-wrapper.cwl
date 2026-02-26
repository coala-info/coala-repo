cwlVersion: v1.2
class: CommandLineTool
baseCommand: spliceai-wrapper
label: spliceai-wrapper
doc: "A wrapper for SpliceAI, a deep learning-based variant caller for splice-altering
  variants.\n\nTool homepage: https://github.com/bihealth/spliceai-wrapper"
inputs:
  - id: input_vcf
    type: File
    doc: Input VCF file containing variants.
    inputBinding:
      position: 1
  - id: delta_score
    type:
      - 'null'
      - float
    doc: Minimum delta score to consider a variant as splice-altering.
    default: 0.05
    inputBinding:
      position: 102
      prefix: --delta-score
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite output VCF if it already exists.
    inputBinding:
      position: 102
      prefix: --force
  - id: include_all
    type:
      - 'null'
      - boolean
    doc: Include all variants in the output VCF, even those without predicted 
      splice-altering effects.
    inputBinding:
      position: 102
      prefix: --include-all
  - id: max_distance
    type:
      - 'null'
      - int
    doc: Maximum distance from splice site to consider a variant.
    default: 500
    inputBinding:
      position: 102
      prefix: --max-distance
  - id: min_distance
    type:
      - 'null'
      - int
    doc: Minimum distance from splice site to consider a variant.
    default: 10
    inputBinding:
      position: 102
      prefix: --min-distance
  - id: reference_fasta
    type: File
    doc: Reference genome FASTA file.
    inputBinding:
      position: 102
      prefix: --reference
  - id: spliceai_model
    type: Directory
    doc: Path to the SpliceAI model directory.
    inputBinding:
      position: 102
      prefix: --spliceai-model
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for processing.
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: output_vcf
    type:
      - 'null'
      - File
    doc: Output VCF file with SpliceAI predictions.
    outputBinding:
      glob: $(inputs.output_vcf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spliceai-wrapper:0.1.0--0
