cwlVersion: v1.2
class: CommandLineTool
baseCommand: raxml
label: raxml
doc: "The provided text does not contain help documentation for the tool; it is an
  error log from a container runtime (Apptainer/Singularity) failing to fetch the
  RAxML image.\n\nTool homepage: http://sco.h-its.org/exelixis/web/software/raxml/index.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/raxml:8.2.13--h7b50bb2_3
stdout: raxml.out
