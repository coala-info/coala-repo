cwlVersion: v1.2
class: CommandLineTool
baseCommand: secedo
label: secedo
doc: "Secedo is a tool for somatic variant calling from single-cell DNA sequencing
  data. (Note: The provided text appears to be a system error log regarding container
  extraction and does not contain CLI help documentation.)\n\nTool homepage: https://github.com/ratschlab/secedo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/secedo:1.0.7--ha041835_4
stdout: secedo.out
