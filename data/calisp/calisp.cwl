cwlVersion: v1.2
class: CommandLineTool
baseCommand: calisp
label: calisp
doc: "The provided text does not contain help information or usage instructions for
  the tool 'calisp'. It contains system log messages and a fatal error regarding disk
  space during a container build process.\n\nTool homepage: https://github.com/kinestetika/Calisp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/calisp:3.1.4--pyhdfd78af_0
stdout: calisp.out
