cwlVersion: v1.2
class: CommandLineTool
baseCommand: purge_dups_get_seqs
label: purge_dups_get_seqs
doc: "The provided text does not contain help information for the tool. It contains
  container runtime error messages.\n\nTool homepage: https://github.com/dfguan/purge_dups"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/purge-dups-runner:2019.12.20--pyhdfd78af_0
stdout: purge_dups_get_seqs.out
