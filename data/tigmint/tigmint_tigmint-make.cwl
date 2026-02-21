cwlVersion: v1.2
class: CommandLineTool
baseCommand: tigmint-make
label: tigmint_tigmint-make
doc: "Tigmint is a tool to correct assembly errors using linked reads. (Note: The
  provided input text appears to be a container runtime error log rather than the
  tool's help documentation.)\n\nTool homepage: https://bcgsc.github.io/tigmint/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tigmint:1.2.10--py39h475c85d_4
stdout: tigmint_tigmint-make.out
