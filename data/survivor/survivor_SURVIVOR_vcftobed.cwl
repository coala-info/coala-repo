cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - SURVIVOR
  - vcftobed
label: survivor_vcftobed
doc: "Convert a VCF file to a BEDPE file\n\nTool homepage: https://github.com/fritzsedlazeck/SURVIVOR"
inputs:
  - id: vcf
    type: File
    doc: "VCF file."
    inputBinding:
      position: 1
  - id: min_size
    type: int
    doc: "Min size."
    inputBinding:
      position: 2
  - id: max_size
    type: int
    doc: "Max size."
    inputBinding:
      position: 3
  - id: output
    type: string
    doc: "Output file."
    inputBinding:
      position: 4
outputs:
  - id: bedpe
    type: File
    doc: "BEDPE file."
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
stdout: survivor_vcftobed.out
