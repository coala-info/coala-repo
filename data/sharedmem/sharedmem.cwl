cwlVersion: v1.2
class: CommandLineTool
baseCommand: sharedmem
label: sharedmem
doc: "The provided text is an error log from a container build process and does not
  contain help information or usage instructions for the 'sharedmem' tool.\n\nTool
  homepage: http://github.com/rainwoodman/sharedmem"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sharedmem:0.3.6--py_0
stdout: sharedmem.out
