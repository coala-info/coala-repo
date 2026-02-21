cwlVersion: v1.2
class: CommandLineTool
baseCommand: migmap
label: migmap
doc: "The provided text does not contain help information or usage instructions for
  the tool 'migmap'. It contains system error messages related to a container runtime
  (Apptainer/Singularity) failing to pull the image due to insufficient disk space.\n
  \nTool homepage: https://github.com/mikessh/migmap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/migmap:1.0.3--0
stdout: migmap.out
