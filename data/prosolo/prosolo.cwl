cwlVersion: v1.2
class: CommandLineTool
baseCommand: prosolo
label: prosolo
doc: "The provided text does not contain help information or usage instructions for
  the tool 'prosolo'. It appears to be a fatal error log from a container engine (Apptainer/Singularity)
  attempting to fetch a Docker image.\n\nTool homepage: https://github.com/PROSIC/prosolo/tree/v0.2.0"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prosolo:0.6.1--h2138d71_0
stdout: prosolo.out
