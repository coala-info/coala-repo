cwlVersion: v1.2
class: CommandLineTool
baseCommand: scapp
label: scapp
doc: "The provided text does not contain help information for the tool 'scapp'. It
  appears to be a log of a failed container build/pull process.\n\nTool homepage:
  https://github.com/Shamir-Lab/SCAPP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scapp:0.1.4--py_0
stdout: scapp.out
