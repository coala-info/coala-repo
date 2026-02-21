cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamsalvage
label: biobambam_bamsalvage
doc: "The provided text does not contain help information for the tool. It contains
  system logs and a fatal error regarding disk space during a container build process.\n
  \nTool homepage: https://gitlab.com/german.tischler/biobambam2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobambam:2.0.185--h02148a2_0
stdout: biobambam_bamsalvage.out
