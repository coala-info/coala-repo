cwlVersion: v1.2
class: CommandLineTool
baseCommand: metaspace2020
label: metaspace2020
doc: "The provided text does not contain help information for the tool. It contains
  error logs related to a container runtime (Apptainer/Singularity) failing to pull
  the docker image due to insufficient disk space.\n\nTool homepage: https://github.com/metaspace2020/metaspace"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaspace2020:2.0.9--pyh7e72e81_0
stdout: metaspace2020.out
