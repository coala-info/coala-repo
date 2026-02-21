cwlVersion: v1.2
class: CommandLineTool
baseCommand: ibridges
label: ibridges
doc: "iBridges: A command-line interface and Python library for interacting with iRODS.\n
  \nTool homepage: https://github.com/iBridges-for-iRODS/iBridges"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ibridges:2.0.1--pyhdfd78af_0
stdout: ibridges.out
