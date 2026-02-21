cwlVersion: v1.2
class: CommandLineTool
baseCommand: dscr
label: dscr
doc: "The provided text does not contain help information or usage instructions for
  the tool 'dscr'. It consists of log messages from a container runtime (Apptainer/Singularity)
  reporting a fatal error due to insufficient disk space while attempting to pull
  a Docker image.\n\nTool homepage: https://github.com/PowerShell/DscResources"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dscr:2014.12.17--boost1.60_1
stdout: dscr.out
