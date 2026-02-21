cwlVersion: v1.2
class: CommandLineTool
baseCommand: unifrac-binaries
label: unifrac-binaries
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  attempting to fetch a Docker image.\n\nTool homepage: https://github.com/biocore/unifrac-binaries"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unifrac-binaries:1.6--h9d55e78_0
stdout: unifrac-binaries.out
