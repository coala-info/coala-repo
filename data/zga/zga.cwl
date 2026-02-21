cwlVersion: v1.2
class: CommandLineTool
baseCommand: zga
label: zga
doc: "The provided text does not contain help information or usage instructions for
  the tool 'zga'. It appears to be an error log from a container runtime (Apptainer/Singularity)
  attempting to fetch a Docker image.\n\nTool homepage: https://github.com/laxeye/zga"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/zga:0.1.1--pyhdfd78af_0
stdout: zga.out
