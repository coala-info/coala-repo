cwlVersion: v1.2
class: CommandLineTool
baseCommand: purge_dups_split_fa
label: purge_dups_split_fa
doc: "The provided text does not contain help information or a description for the
  tool; it is an error log from a container build process.\n\nTool homepage: https://github.com/dfguan/purge_dups"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/purge-dups-runner:2019.12.20--pyhdfd78af_0
stdout: purge_dups_split_fa.out
