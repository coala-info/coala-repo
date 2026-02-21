cwlVersion: v1.2
class: CommandLineTool
baseCommand: darkprofiler
label: darkprofiler
doc: "The provided text does not contain a description of the tool's functionality,
  as it consists of system logs and a fatal error message during a container build
  process.\n\nTool homepage: https://pypi.org/project/darkprofiler/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/darkprofiler:0.1.3--pyhdfd78af_0
stdout: darkprofiler.out
