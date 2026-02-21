cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqcluster
label: seqcluster
doc: "The provided text does not contain help information or usage instructions for
  seqcluster. It contains error logs related to a failed container build (no space
  left on device).\n\nTool homepage: https://github.com/lpantano/seqclsuter"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqcluster:1.2.9--pyh5e36f6f_0
stdout: seqcluster.out
