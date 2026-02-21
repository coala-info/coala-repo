cwlVersion: v1.2
class: CommandLineTool
baseCommand: taxburst
label: taxburst
doc: "TaxBurst (Note: The provided text contains system error logs regarding a container
  build failure and does not include the tool's help documentation or argument definitions).\n
  \nTool homepage: https://github.com/taxburst/taxburst"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxburst:0.3.2--pyhdfd78af_0
stdout: taxburst.out
