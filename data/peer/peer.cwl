cwlVersion: v1.2
class: CommandLineTool
baseCommand: peer
label: peer
doc: "The provided text does not contain help information or usage instructions for
  the 'peer' tool. It consists of system error messages related to Singularity/Docker
  container image conversion and storage issues.\n\nTool homepage: https://github.com/PMBio/peer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/peer:1.3--h503566f_1
stdout: peer.out
