cwlVersion: v1.2
class: CommandLineTool
baseCommand: xtail
label: xtail
doc: "The provided text does not contain help information for the tool 'xtail'. It
  appears to be a log of a failed container image retrieval process.\n\nTool homepage:
  https://github.com/xryanglab/xtail"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xtail:1.1.5--r351_1
stdout: xtail.out
