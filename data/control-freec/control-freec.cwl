cwlVersion: v1.2
class: CommandLineTool
baseCommand: freec
label: control-freec
doc: "Control-FREEC is a tool for detection of copy number alterations and allelic
  imbalances (including LOH) using deep-sequencing data.\n\nTool homepage: https://github.com/BoevaLab/FREEC"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/control-freec:11.6--hdbdd923_3
stdout: control-freec.out
