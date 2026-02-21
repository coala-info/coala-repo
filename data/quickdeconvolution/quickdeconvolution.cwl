cwlVersion: v1.2
class: CommandLineTool
baseCommand: quickdeconvolution
label: quickdeconvolution
doc: "Quick deconvolution tool (Note: The provided text is a container build log and
  does not contain the tool's help documentation or argument list).\n\nTool homepage:
  https://github.com/RolandFaure/QuickDeconvolution"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quickdeconvolution:1.2--h9f5acd7_1
stdout: quickdeconvolution.out
