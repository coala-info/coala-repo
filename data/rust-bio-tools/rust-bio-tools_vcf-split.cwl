cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rbt
  - vcf-split
label: rust-bio-tools_vcf-split
doc: "Split a given VCF/BCF file into N chunks of approximately the same size. Breakends
  are kept together. Output type is always BCF.\n\nTool homepage: https://github.com/rust-bio/rust-bio-tools"
inputs:
  - id: input
    type: File
    doc: Input VCF/BCF that shall be splitted.
    inputBinding:
      position: 1
  - id: output
    type:
      type: array
      items: string
    doc: BCF files to split into. Breakends are kept together. Each file will 
      contain approximately the same number of records.
    inputBinding:
      position: 2
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: BCF chunk files
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rust-bio-tools:0.42.2--h4458251_0
