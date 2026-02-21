cwlVersion: v1.2
class: CommandLineTool
baseCommand: ismapper
label: ismapper
doc: "The provided text does not contain help information for the tool. It appears
  to be a fatal error log from a container runtime (Apptainer/Singularity) indicating
  a 'no space left on device' error during image conversion.\n\nTool homepage: https://github.com/jhawkey/IS_mapper/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ismapper:2.0.2--pyhdfd78af_1
stdout: ismapper.out
