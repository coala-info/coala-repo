cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - SURVIVOR
  - bedpetovcf
label: survivor_bedpetovcf
doc: "Convert a BEDPE file to a VCF file (beta version)\n\nTool homepage: https://github.com/fritzsedlazeck/SURVIVOR"
inputs:
  - id: bedpe
    type: File
    doc: "Bedpe file."
    inputBinding:
      position: 1
  - id: output
    type: string
    doc: "Output: vcf file."
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
stdout: survivor_bedpetovcf.out
