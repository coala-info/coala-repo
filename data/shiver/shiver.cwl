cwlVersion: v1.2
class: CommandLineTool
baseCommand: shiver
label: shiver
doc: "The provided text does not contain help information for the tool 'shiver'. It
  appears to be an error log from a container build process (Apptainer/Singularity)
  that failed due to insufficient disk space.\n\nTool homepage: https://github.com/ChrisHIV/shiver"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shiver:1.7.3--hdfd78af_0
stdout: shiver.out
