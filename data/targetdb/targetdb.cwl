cwlVersion: v1.2
class: CommandLineTool
baseCommand: targetdb
label: targetdb
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be an error log from a container build/fetch process.\n\n
  Tool homepage: https://github.com/sdecesco/targetDB"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/targetdb:1.3.3--pyhdfd78af_0
stdout: targetdb.out
