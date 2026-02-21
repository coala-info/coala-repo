cwlVersion: v1.2
class: CommandLineTool
baseCommand: smafa
label: smafa
doc: "The provided text does not contain help information for the tool 'smafa'; it
  is an error log from a container runtime (Apptainer/Singularity) failing to fetch
  a Docker image.\n\nTool homepage: https://github.com/wwood/smafa"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smafa:0.8.0--hc1c3326_1
stdout: smafa.out
