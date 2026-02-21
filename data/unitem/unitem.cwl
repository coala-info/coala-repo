cwlVersion: v1.2
class: CommandLineTool
baseCommand: unitem
label: unitem
doc: "The provided text does not contain help information or a description for the
  tool 'unitem'. It appears to be an error log from a container build process.\n\n
  Tool homepage: https://github.com/dparks1134/UniteM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unitem:1.2.6--pyhdfd78af_0
stdout: unitem.out
