cwlVersion: v1.2
class: CommandLineTool
baseCommand: snpomatic
label: snpomatic
doc: "The provided text does not contain help information or usage instructions for
  snpomatic; it is an error log from a container runtime (Apptainer/Singularity) indicating
  a failure to fetch or build the container image.\n\nTool homepage: https://github.com/magnusmanske/snpomatic"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/snpomatic:v1.0-4-deb_cv1
stdout: snpomatic.out
