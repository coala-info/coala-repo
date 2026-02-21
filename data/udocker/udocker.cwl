cwlVersion: v1.2
class: CommandLineTool
baseCommand: udocker
label: udocker
doc: "A tool to execute Docker containers in user space without root privileges (Note:
  The provided text appears to be an error log from a container build process rather
  than help text; no arguments could be extracted from the input).\n\nTool homepage:
  https://github.com/indigo-dc/udocker"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/udocker:1.1.1--py27_0
stdout: udocker.out
