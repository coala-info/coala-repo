cwlVersion: v1.2
class: CommandLineTool
baseCommand: purge_dups_pd_config.py
label: purge_dups_pd_config.py
doc: "A configuration script for the purge_dups tool suite.\n\nTool homepage: https://github.com/dfguan/purge_dups"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/purge-dups-runner:2019.12.20--pyhdfd78af_0
stdout: purge_dups_pd_config.py.out
