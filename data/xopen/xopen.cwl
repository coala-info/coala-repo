cwlVersion: v1.2
class: CommandLineTool
baseCommand: xopen
label: xopen
doc: "The provided text does not contain help information for the tool 'xopen'. It
  appears to be a log of a failed container build process.\n\nTool homepage: https://github.com/marcelm/xopen"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xopen:0.7.3--py_0
stdout: xopen.out
