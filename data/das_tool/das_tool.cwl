cwlVersion: v1.2
class: CommandLineTool
baseCommand: das_tool
label: das_tool
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a system error log related to a container build failure (no space
  left on device).\n\nTool homepage: https://github.com/cmks/DAS_Tool"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/dascrubber:v020160601-2-deb_cv1
stdout: das_tool.out
