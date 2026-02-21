cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamvalidate
label: biobambam_bamvalidate
doc: "The provided text does not contain help information; it is an error log indicating
  a failure to build a container image due to insufficient disk space.\n\nTool homepage:
  https://gitlab.com/german.tischler/biobambam2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobambam:2.0.185--h02148a2_0
stdout: biobambam_bamvalidate.out
