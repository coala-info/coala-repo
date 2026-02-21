cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ervmancer
  - tree
label: ervmancer_ervmancer_tree
doc: "Endogenous Retrovirus analysis tool - tree subcommand (Note: The provided help
  text contains only system error messages and no argument definitions).\n\nTool homepage:
  https://github.com/AuslanderLab/ervmancer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ervmancer:0.0.4--pyhdfd78af_0
stdout: ervmancer_ervmancer_tree.out
