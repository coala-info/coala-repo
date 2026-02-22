cwlVersion: v1.2
class: CommandLineTool
baseCommand: colombo
label: colombo
doc: "The provided text is an error log from a container runtime (Singularity/Apptainer)
  indicating a failure to pull or convert the image due to lack of disk space. It
  does not contain the tool's help text or argument definitions.\n\nTool homepage:
  https://www.uni-goettingen.de/en/research/185810.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/colombo:v4.0--1
stdout: colombo.out
