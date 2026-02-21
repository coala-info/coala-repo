cwlVersion: v1.2
class: CommandLineTool
baseCommand: bbmapy
label: bbmapy
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  indicating a failure to extract the tool's image due to insufficient disk space.
  No help text or usage information was found in the input to extract arguments.\n
  \nTool homepage: https://github.com/urineri/bbmapy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bbmapy:0.0.51--pyhdfd78af_0
stdout: bbmapy.out
