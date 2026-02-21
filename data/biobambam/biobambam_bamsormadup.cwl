cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamsormadup
label: biobambam_bamsormadup
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container build failure (no space left on device).\n
  \nTool homepage: https://gitlab.com/german.tischler/biobambam2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobambam:2.0.185--h02148a2_0
stdout: biobambam_bamsormadup.out
