cwlVersion: v1.2
class: CommandLineTool
baseCommand: tepeaks
label: tepeaks
doc: "The provided text does not contain help information for the tool 'tepeaks'.
  It appears to be an error log from a container runtime (Apptainer/Singularity) failing
  to fetch a Docker image.\n\nTool homepage: http://hammelllab.labsites.cshl.edu/software/#TEpeaks"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tepeaks:0.1--h3e6c209_7
stdout: tepeaks.out
