cwlVersion: v1.2
class: CommandLineTool
baseCommand: piranha-polio
label: piranha-polio
doc: "The provided text does not contain help documentation or usage instructions;
  it contains system error messages related to a container execution failure (no space
  left on device).\n\nTool homepage: https://github.com/polio-nanopore/piranha"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/piranha-polio:1.5.3--pyhdfd78af_0
stdout: piranha-polio.out
