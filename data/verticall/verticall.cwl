cwlVersion: v1.2
class: CommandLineTool
baseCommand: verticall
label: verticall
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  attempting to fetch the verticall image.\n\nTool homepage: https://github.com/rrwick/Verticall"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/verticall:0.4.3--pyhdfd78af_0
stdout: verticall.out
