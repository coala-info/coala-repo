cwlVersion: v1.2
class: CommandLineTool
baseCommand: primalbedtools
label: primalbedtools
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  failing to fetch the tool's image.\n\nTool homepage: https://github.com/ChrisgKent/primalbedtools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/primalbedtools:1.0.0--pyhdfd78af_0
stdout: primalbedtools.out
