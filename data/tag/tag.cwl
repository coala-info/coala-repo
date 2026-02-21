cwlVersion: v1.2
class: CommandLineTool
baseCommand: tag
label: tag
doc: "The provided text does not contain help information or usage instructions for
  the tool 'tag'. It appears to be an error log from a container runtime (Apptainer/Singularity)
  failing to pull a Docker image.\n\nTool homepage: https://github.com/standage/tag/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tag:0.5.1--py_0
stdout: tag.out
