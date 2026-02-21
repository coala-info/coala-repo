cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyloh
label: pyloh
doc: "The provided text does not contain help information or a description for the
  tool. It appears to be a log of a failed container build process.\n\nTool homepage:
  https://github.com/uci-cbcl/PyLOH"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyloh:1.4.3--py27_0
stdout: pyloh.out
