cwlVersion: v1.2
class: CommandLineTool
baseCommand: savvy
label: savvy
doc: "The provided text does not contain help information or usage instructions for
  the tool 'savvy'. It appears to be an error log from a container build process (Apptainer/Singularity).\n
  \nTool homepage: https://github.com/statgen/savvy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/savvy:2.1.0--h5b0a936_4
stdout: savvy.out
