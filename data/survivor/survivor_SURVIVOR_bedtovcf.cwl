cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - SURVIVOR
  - bedtovcf
label: survivor_bedtovcf
doc: "Convert a BED file to a VCF file\n\nTool homepage: https://github.com/fritzsedlazeck/SURVIVOR"
inputs:
  - id: bed
    type: File
    doc: "Bed file (chr, start, stop)."
    inputBinding:
      position: 1
  - id: type
    type: string
    doc: "SV type given to all entries (e.g. DEL)."
    inputBinding:
      position: 2
  - id: output
    type: string
    doc: "Output vcf file."
    inputBinding:
      position: 3
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
stdout: survivor_bedtovcf.out
