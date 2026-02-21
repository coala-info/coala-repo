cwlVersion: v1.2
class: CommandLineTool
baseCommand: sunbeamlib
label: sunbeamlib
doc: "The provided text does not contain help information or usage instructions; it
  is a log of a failed container build process.\n\nTool homepage: https://github.com/sunbeam-labs/sunbeam"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sunbeamlib:5.2.2--pyhdfd78af_0
stdout: sunbeamlib.out
