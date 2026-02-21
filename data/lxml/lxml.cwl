cwlVersion: v1.2
class: CommandLineTool
baseCommand: lxml
label: lxml
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain help information or usage instructions for the lxml tool.\n
  \nTool homepage: https://github.com/lxml/lxml"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lxml:4.9.1
stdout: lxml.out
