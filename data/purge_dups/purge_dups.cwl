cwlVersion: v1.2
class: CommandLineTool
baseCommand: purge_dups
label: purge_dups
doc: "The provided text does not contain help information for purge_dups; it contains
  container runtime error logs.\n\nTool homepage: https://github.com/dfguan/purge_dups"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/purge-dups-runner:2019.12.20--pyhdfd78af_0
stdout: purge_dups.out
