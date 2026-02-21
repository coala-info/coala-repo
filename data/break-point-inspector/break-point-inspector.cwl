cwlVersion: v1.2
class: CommandLineTool
baseCommand: Break-Point-Inspector
label: break-point-inspector
doc: "A second layer of filtering on top of Manta\n\nTool homepage: https://github.com/hartwigmedical/hmftools/tree/master/break-point-inspector"
inputs:
  - id: contamination_fraction
    type:
      - 'null'
      - float
    doc: fraction of allowable normal support per tumor support read
    inputBinding:
      position: 101
      prefix: -contamination_fraction
  - id: proximity
    type:
      - 'null'
      - int
    doc: distance to scan around breakpoint (optional, default=500)
    default: 500
    inputBinding:
      position: 101
      prefix: -proximity
  - id: ref
    type: File
    doc: the Reference BAM (required)
    inputBinding:
      position: 101
      prefix: -ref
  - id: tumor
    type: File
    doc: the Tumor BAM (required)
    inputBinding:
      position: 101
      prefix: -tumor
  - id: vcf
    type: File
    doc: Manta VCF file to batch inspect (required)
    inputBinding:
      position: 101
      prefix: -vcf
outputs:
  - id: output_vcf
    type:
      - 'null'
      - File
    doc: VCF output file (optional)
    outputBinding:
      glob: $(inputs.output_vcf)
  - id: ref_slice
    type:
      - 'null'
      - File
    doc: the sliced Reference BAM to output (optional)
    outputBinding:
      glob: $(inputs.ref_slice)
  - id: tumor_slice
    type:
      - 'null'
      - File
    doc: the sliced Tumor BAM to output (optional)
    outputBinding:
      glob: $(inputs.tumor_slice)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/break-point-inspector:1.5--0
