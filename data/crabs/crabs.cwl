cwlVersion: v1.2
class: CommandLineTool
baseCommand: crabs
label: crabs
doc: "The provided text does not contain help information or usage instructions for
  the 'crabs' tool; it is an error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build the image due to insufficient disk space.\n\nTool
  homepage: https://github.com/gjeunen/reference_database_creator"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crabs:1.14.0--pyhdfd78af_0
stdout: crabs.out
