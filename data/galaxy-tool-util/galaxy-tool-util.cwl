cwlVersion: v1.2
class: CommandLineTool
baseCommand: galaxy-tool-util
label: galaxy-tool-util
doc: "The provided text does not contain help documentation. It is an error log indicating
  a failure to create a Singularity/Apptainer image due to insufficient disk space.\n
  \nTool homepage: https://galaxyproject.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/galaxy-tool-util:21.9.1--pyhdfd78af_0
stdout: galaxy-tool-util.out
