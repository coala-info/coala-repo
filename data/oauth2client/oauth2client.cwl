cwlVersion: v1.2
class: CommandLineTool
baseCommand: oauth2client
label: oauth2client
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to build the image due to insufficient disk space.\n\nTool homepage: https://github.com/nxtbgthng/OAuth2Client"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/oauth2client:1.5.2--py35_0
stdout: oauth2client.out
