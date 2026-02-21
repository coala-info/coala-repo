cwlVersion: v1.2
class: CommandLineTool
baseCommand: zarp
label: zarp
doc: "The provided text does not contain help information or usage instructions for
  the tool 'zarp'. It appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  attempting to fetch a Docker image.\n\nTool homepage: https://github.com/zavolanlab/zarp-cli"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/zarp:1.0.0--pyhdfd78af_0
stdout: zarp.out
