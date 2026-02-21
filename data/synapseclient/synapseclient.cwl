cwlVersion: v1.2
class: CommandLineTool
baseCommand: synapse
label: synapseclient
doc: "The Synapse Client provides an interface to Synapse, a collaborative platform
  for data sharing and analysis.\n\nTool homepage: https://www.synapse.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/synapseclient:4.11.0--pyhdfd78af_0
stdout: synapseclient.out
