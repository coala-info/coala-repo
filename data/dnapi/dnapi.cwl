cwlVersion: v1.2
class: CommandLineTool
baseCommand: dnapi
label: dnapi
doc: "The provided text does not contain help information for the tool. It consists
  of error messages from a container runtime (Apptainer/Singularity) indicating a
  failure to build or run the container due to lack of disk space.\n\nTool homepage:
  https://github.com/XWangLabTHU/cfDNApipe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dnapi:1.1--py35_2
stdout: dnapi.out
