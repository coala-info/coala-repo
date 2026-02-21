cwlVersion: v1.2
class: CommandLineTool
baseCommand: dcm2niix
label: dcm2niix
doc: "The provided text does not contain help information for dcm2niix; it is an error
  log indicating a failure to build or run a container due to insufficient disk space.
  No arguments could be extracted from the provided text.\n\nTool homepage: https://github.com/rordenlab/dcm2niix"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/dcm2niix:v1.0.20181125-1-deb_cv1
stdout: dcm2niix.out
