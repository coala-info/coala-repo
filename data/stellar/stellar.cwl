cwlVersion: v1.2
class: CommandLineTool
baseCommand: stellar
label: stellar
doc: "The provided text does not contain help information for the tool 'stellar'.
  It appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  failing to fetch or build the tool's image.\n\nTool homepage: https://github.com/Stellarium/stellarium"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stellar:1.4.9--0
stdout: stellar.out
