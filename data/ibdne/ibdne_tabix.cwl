cwlVersion: v1.2
class: CommandLineTool
baseCommand: ibdne_tabix
label: ibdne_tabix
doc: "The provided text does not contain help information or usage instructions; it
  consists of system log messages indicating a container runtime error (no space left
  on device).\n\nTool homepage: https://github.com/hennlab/AS-IBDNe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ibdne:04Sep15.e78--0
stdout: ibdne_tabix.out
