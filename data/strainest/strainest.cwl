cwlVersion: v1.2
class: CommandLineTool
baseCommand: strainest
label: strainest
doc: "Strain identification and quantification from metagenomic sequencing data.\n
  \nTool homepage: https://github.com/compmetagen/strainest"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strainest:1.2.4--py36h2d50403_2
stdout: strainest.out
