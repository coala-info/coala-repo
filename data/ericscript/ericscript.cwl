cwlVersion: v1.2
class: CommandLineTool
baseCommand: ericscript
label: ericscript
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log regarding a container execution failure (no space left
  on device).\n\nTool homepage: https://github.com/databio/ericscript"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ericscript:0.5.5--pl5.22.0r3.3.2_1
stdout: ericscript.out
