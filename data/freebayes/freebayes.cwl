cwlVersion: v1.2
class: CommandLineTool
baseCommand: freebayes
label: freebayes
doc: "The provided text does not contain help information or a description of the
  tool; it contains system error messages related to a container runtime failure (no
  space left on device).\n\nTool homepage: https://github.com/freebayes/freebayes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/freebayes:1.3.10--hbefcdb2_0
stdout: freebayes.out
