cwlVersion: v1.2
class: CommandLineTool
baseCommand: pythonnet
label: pythonnet
doc: "Python for .NET (Note: The provided text is a container build log and does not
  contain CLI help information or argument definitions.)\n\nTool homepage: https://github.com/pythonnet/pythonnet"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pythonnet:2.3.0--py27_1
stdout: pythonnet.out
