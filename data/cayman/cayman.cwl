cwlVersion: v1.2
class: CommandLineTool
baseCommand: cayman
label: cayman
doc: "The provided text does not contain help information or usage instructions for
  the tool 'cayman'. It appears to be a log of a failed container build process (Apptainer/Singularity)
  due to insufficient disk space.\n\nTool homepage: https://github.com/zellerlab/cayman"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cayman:0.10.2--pyh7e72e81_0
stdout: cayman.out
