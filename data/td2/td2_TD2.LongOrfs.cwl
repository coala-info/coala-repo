cwlVersion: v1.2
class: CommandLineTool
baseCommand: TD2.LongOrfs
label: td2_TD2.LongOrfs
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains system error messages related to container image handling
  and disk space.\n\nTool homepage: https://github.com/Markusjsommer/TD2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/td2:1.0.7--pyhdfd78af_0
stdout: td2_TD2.LongOrfs.out
