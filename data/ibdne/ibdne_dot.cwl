cwlVersion: v1.2
class: CommandLineTool
baseCommand: ibdne_dot
label: ibdne_dot
doc: "IBDNe utility (Note: The provided help text contains only system error messages
  regarding a container runtime failure and does not provide usage information or
  argument definitions).\n\nTool homepage: https://github.com/hennlab/AS-IBDNe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ibdne:04Sep15.e78--0
stdout: ibdne_dot.out
