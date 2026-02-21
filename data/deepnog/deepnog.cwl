cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepnog
label: deepnog
doc: "Deep learning based orthology prediction (Note: The provided text contains container
  runtime error messages rather than the tool's help documentation).\n\nTool homepage:
  https://github.com/univieCUBE/deepnog"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepnog:1.2.4--pyh7e72e81_0
stdout: deepnog.out
