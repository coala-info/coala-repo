cwlVersion: v1.2
class: CommandLineTool
baseCommand: libopenms
label: libopenms
doc: "The provided text contains system error logs related to a container runtime
  failure (no space left on device) rather than the help text for the libopenms tool.
  Consequently, no arguments or tool descriptions could be extracted.\n\nTool homepage:
  https://github.com/OpenMS/OpenMS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/libopenms:3.5.0--hdd6e20e_0
stdout: libopenms.out
