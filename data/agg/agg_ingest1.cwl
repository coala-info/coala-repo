cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - agg
  - ingest1
label: agg_ingest1
doc: "ingests a single sample gvcf into a variant-only .bcf and tempory depth interval
  (.tmp)\n\nTool homepage: https://github.com/Illumina/agg"
inputs:
  - id: input_gvcf
    type: File
    doc: Input gVCF file
    inputBinding:
      position: 1
  - id: fasta_ref
    type: File
    doc: reference sequence
    inputBinding:
      position: 102
      prefix: --fasta-ref
  - id: ignore_non_matching_ref
    type:
      - 'null'
      - boolean
    doc: skip non-matching ref alleles (will warn)
    inputBinding:
      position: 102
      prefix: --ignore-non-matching-ref
outputs:
  - id: output_prefix
    type: File
    doc: agg will output output_prefix.bcf and output_prefix.tmp
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/agg:0.3.6--hd28b015_0
