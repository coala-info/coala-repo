cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - SURVIVOR
  - smaptovcf
label: survivor_smaptovcf
doc: "Converts the smap file (Bionano) to a VCF file (beta version)\n\nTool homepage: https://github.com/fritzsedlazeck/SURVIVOR"
inputs:
  - id: smap
    type: File
    doc: "*.smap file."
    inputBinding:
      position: 1
  - id: output
    type: string
    doc: "Output file."
    inputBinding:
      position: 2
outputs:
  - id: vcf
    type: File
    doc: "VCF file."
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
stdout: survivor_smaptovcf.out
