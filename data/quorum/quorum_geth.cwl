cwlVersion: v1.2
class: CommandLineTool
baseCommand: quorum_geth
label: quorum_geth
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a log of a failed container build/fetch process.\n\n
  Tool homepage: https://github.com/Consensys/quorum"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/quorum:v1.1.1-2-deb_cv1
stdout: quorum_geth.out
