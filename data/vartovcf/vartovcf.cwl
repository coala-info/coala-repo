cwlVersion: v1.2
class: CommandLineTool
baseCommand: vartovcf
label: vartovcf
doc: "Convert variants from VarDict/VarDictJava into VCF v4.2 format.\n\nTool homepage:
  https://github.com/clintval/vartovcf"
inputs:
  - id: input
    type:
      - 'null'
      - File
    doc: Input VAR file or stream
    default: /dev/stdin
    inputBinding:
      position: 101
      prefix: --input
  - id: mode
    type:
      - 'null'
      - string
    doc: Variant calling mode
    default: TumorOnly
    inputBinding:
      position: 101
      prefix: --mode
  - id: reference
    type: File
    doc: The indexed FASTA reference sequence file
    inputBinding:
      position: 101
      prefix: --reference
  - id: sample
    type: string
    doc: The input sample name, must match input data stream
    inputBinding:
      position: 101
      prefix: --sample
  - id: skip_non_variants
    type:
      - 'null'
      - boolean
    doc: Skip non-variant sites (where ref_allele == alt_allele)
    inputBinding:
      position: 101
      prefix: --skip-non-variants
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output VCF file or stream
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vartovcf:1.4.0--h3ab6199_0
