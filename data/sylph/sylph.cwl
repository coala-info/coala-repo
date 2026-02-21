cwlVersion: v1.2
class: CommandLineTool
baseCommand: sylph
label: sylph
doc: "The provided text does not contain help information for the tool 'sylph'. It
  appears to be a fatal error log from a container runtime (Singularity/Apptainer)
  attempting to fetch the sylph image.\n\nTool homepage: https://github.com/bluenote-1577/sylph"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sylph:0.9.0--ha6fb395_0
stdout: sylph.out
