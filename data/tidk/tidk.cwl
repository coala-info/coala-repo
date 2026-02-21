cwlVersion: v1.2
class: CommandLineTool
baseCommand: tidk
label: tidk
doc: "The provided text does not contain help information for the tool 'tidk'. It
  appears to be an error log from a container runtime (Singularity/Apptainer) failing
  to fetch a Docker image.\n\nTool homepage: https://github.com/tolkit/telomeric-identifier"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tidk:0.2.65--h3dc2dae_0
stdout: tidk.out
