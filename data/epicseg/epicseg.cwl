cwlVersion: v1.2
class: CommandLineTool
baseCommand: epicseg
label: epicseg
doc: "The provided text is an error log from a container runtime and does not contain
  help information or usage instructions for the tool.\n\nTool homepage: http://github.com/lamortenera/epicseg"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/epicseg:1.0--r40h516909a_3
stdout: epicseg.out
