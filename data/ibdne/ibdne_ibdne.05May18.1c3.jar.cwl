cwlVersion: v1.2
class: CommandLineTool
baseCommand: ibdne
label: ibdne_ibdne.05May18.1c3.jar
doc: "The provided text does not contain help information or a description of the
  tool; it contains system error messages related to a container runtime failure (no
  space left on device).\n\nTool homepage: https://github.com/hennlab/AS-IBDNe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ibdne:04Sep15.e78--0
stdout: ibdne_ibdne.05May18.1c3.jar.out
