cwlVersion: v1.2
class: CommandLineTool
baseCommand: tn93
label: tn93
doc: "The provided text does not contain help information or usage instructions for
  the 'tn93' tool. It appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  failing to fetch or build the OCI image.\n\nTool homepage: https://github.com/veg/tn93"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tn93:1.0.15--h9948957_0
stdout: tn93.out
