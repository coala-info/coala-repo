cwlVersion: v1.2
class: CommandLineTool
baseCommand: sompy
label: sompy
doc: "Somatic variant comparison tool (Note: The provided text contains container
  runtime logs and error messages rather than the tool's help documentation. No arguments
  could be extracted from the input.)\n\nTool homepage: https://github.com/ttlg/sompy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sompy:0.1.1--py27h24bf2e0_0
stdout: sompy.out
