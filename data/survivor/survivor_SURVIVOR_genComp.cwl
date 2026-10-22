cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - SURVIVOR
  - genComp
label: survivor_genComp
doc: "Generate a pairwise comparison matrix from any multi sample VCF file\n\nTool homepage: https://github.com/fritzsedlazeck/SURVIVOR"
inputs:
  - id: merged_vcf
    type: File
    doc: "Merged VCF file."
    inputBinding:
      position: 1
  - id: normalize
    type: int
    doc: "Normalize output (1==yes, else no)."
    inputBinding:
      position: 2
  - id: output
    type: string
    doc: "Output: pairwise overlap matrix."
    inputBinding:
      position: 3
outputs:
  - id: matrix
    type: File
    doc: "Pairwise overlap matrix."
    outputBinding:
      glob: '$(inputs.output)'
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/survivor:1.0.7--h077b44d_7
stdout: survivor_genComp.out
