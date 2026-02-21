cwlVersion: v1.2
class: CommandLineTool
baseCommand: noah-cli
label: noah-cli
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container runtime (Apptainer/Singularity) indicating
  a failure to pull the container image due to lack of disk space.\n\nTool homepage:
  https://github.com/raymond-u/noah-cli"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/noah-cli:0.2.0--pyhdfd78af_0
stdout: noah-cli.out
