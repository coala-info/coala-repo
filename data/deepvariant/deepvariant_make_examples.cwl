cwlVersion: v1.2
class: CommandLineTool
baseCommand: make_examples
label: deepvariant_make_examples
doc: "The provided text does not contain help information for the tool. It contains
  system error logs related to a container runtime (Singularity/Apptainer) failing
  to build an image due to lack of disk space.\n\nTool homepage: https://github.com/google/deepvariant"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepvariant:1.9.0--pyh697b589_0
stdout: deepvariant_make_examples.out
