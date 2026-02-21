cwlVersion: v1.2
class: CommandLineTool
baseCommand: pubmlst_client
label: pubmlst_client
doc: "A client for interacting with the PubMLST database. (Note: The provided help
  text contains only system logs and error messages; no specific arguments or usage
  instructions were found in the input.)\n\nTool homepage: https://github.com/Public-Health-Bioinformatics/pubmlst_client"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pubmlst_client:0.2.0--py_0
stdout: pubmlst_client.out
