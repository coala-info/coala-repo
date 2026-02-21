cwlVersion: v1.2
class: CommandLineTool
baseCommand: purge_dups_ngstat
label: purge_dups_ngstat
doc: "The provided text does not contain help information for purge_dups_ngstat; it
  contains container runtime error messages. No arguments could be extracted.\n\n
  Tool homepage: https://github.com/dfguan/purge_dups"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/purge-dups-runner:2019.12.20--pyhdfd78af_0
stdout: purge_dups_ngstat.out
