cwlVersion: v1.2
class: CommandLineTool
baseCommand: ibdne
label: ibdne_shapeit
doc: "The provided text does not contain help information or usage instructions. It
  contains system log messages and a fatal error regarding container image conversion
  and disk space.\n\nTool homepage: https://github.com/hennlab/AS-IBDNe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ibdne:04Sep15.e78--0
stdout: ibdne_shapeit.out
