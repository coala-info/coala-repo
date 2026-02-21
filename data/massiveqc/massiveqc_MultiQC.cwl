cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - massiveqc
  - multiqc
label: massiveqc_MultiQC
doc: "MassiveQC MultiQC tool (Note: The provided help text contains only system error
  messages and no usage information; therefore, no arguments could be extracted.)\n
  \nTool homepage: https://github.com/shimw6828/MassiveQC"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/massiveqc:0.1.2--pyh086e186_0
stdout: massiveqc_MultiQC.out
