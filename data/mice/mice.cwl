cwlVersion: v1.2
class: CommandLineTool
baseCommand: mice
label: mice
doc: "The provided text does not contain help information for the tool 'mice'. It
  contains error messages from a container runtime (Apptainer/Singularity) indicating
  a failure to pull or build the container image due to insufficient disk space.\n
  \nTool homepage: https://github.com/gi-bielefeld/mice"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mice:0.1.2--h4349ce8_0
stdout: mice.out
