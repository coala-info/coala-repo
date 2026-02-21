cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyfaidx
label: pyfaidx
doc: "The provided text does not contain help information for pyfaidx; it is a log
  of a failed container build process.\n\nTool homepage: https://github.com/mdshw5/pyfaidx"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfaidx:0.9.0.3--pyhdfd78af_0
stdout: pyfaidx.out
