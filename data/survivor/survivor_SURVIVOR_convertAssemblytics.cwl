cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - SURVIVOR
  - convertAssemblytics
label: survivor_convertAssemblytics
doc: "Converts Assemblytics to a VCF file\n\nTool homepage: https://github.com/fritzsedlazeck/SURVIVOR"
inputs:
  - id: assemblytics_bed
    type: File
    doc: "Bed file from Assemblytics."
    inputBinding:
      position: 1
  - id: min_size
    type: int
    doc: "Min size to keep."
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
stdout: survivor_convertAssemblytics.out
