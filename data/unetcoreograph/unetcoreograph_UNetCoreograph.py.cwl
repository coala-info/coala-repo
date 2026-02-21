cwlVersion: v1.2
class: CommandLineTool
baseCommand: unetcoreograph_UNetCoreograph.py
label: unetcoreograph_UNetCoreograph.py
doc: "UNetCoreograph tool (Note: The provided text contains container build logs and
  error messages rather than CLI help documentation. No arguments could be extracted
  from the input.)\n\nTool homepage: https://github.com/HMS-IDAC/UNetCoreograph"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unetcoreograph:2.4.6--hdfd78af_0
stdout: unetcoreograph_UNetCoreograph.py.out
