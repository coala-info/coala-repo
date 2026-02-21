cwlVersion: v1.2
class: CommandLineTool
baseCommand: pbcstat
label: purge_dups_pbcstat
doc: "The provided text does not contain help information for the tool; it is a container
  runtime error log. No arguments could be extracted.\n\nTool homepage: https://github.com/dfguan/purge_dups"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/purge-dups-runner:2019.12.20--pyhdfd78af_0
stdout: purge_dups_pbcstat.out
