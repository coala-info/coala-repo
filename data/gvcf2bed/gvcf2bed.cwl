cwlVersion: v1.2
class: CommandLineTool
baseCommand: gvcf2bed
label: gvcf2bed
doc: "Create a BED file from a gVCF. Regions are based on a minimum genotype quality.
  The gVCF file must contain a GQ field in its FORMAT fields. GQ scores of non-variants
  records have a different distribution from the GQ score distribution of variant
  records. Hence, an option is provided to set a different threshold for non-variant
  positions.\n\nTool homepage: https://github.com/sndrtj/gvcf2bed"
inputs:
  - id: bedgraph
    type:
      - 'null'
      - boolean
    doc: Output in bedgraph mode
    inputBinding:
      position: 101
      prefix: --bedgraph
  - id: input
    type: File
    doc: Input gVCF
    inputBinding:
      position: 101
      prefix: --input
  - id: non_variant_quality
    type:
      - 'null'
      - int
    doc: Minimum genotype quality for non-variant records
    default: 20
    inputBinding:
      position: 101
      prefix: --non-variant-quality
  - id: quality
    type:
      - 'null'
      - int
    doc: Minimum genotype quality
    default: 20
    inputBinding:
      position: 101
      prefix: --quality
  - id: sample
    type:
      - 'null'
      - string
    doc: Sample name in VCF file to use. Will default to first sample 
      (alphabetically) if not supplied
    inputBinding:
      position: 101
      prefix: --sample
outputs:
  - id: output
    type: File
    doc: Output bed file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gvcf2bed:0.3.1--py_0
