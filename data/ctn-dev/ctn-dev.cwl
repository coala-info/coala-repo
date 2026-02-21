cwlVersion: v1.2
class: CommandLineTool
baseCommand: ctn-dev
label: ctn-dev
doc: "The provided text appears to be a container build log rather than help text
  for the 'ctn-dev' tool. As a result, no command-line arguments, flags, or positional
  parameters could be extracted from this specific input.\n\nTool homepage: https://github.com/cTn-dev/Phoenix-FlightController"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ctn-dev:v3.2.0dfsg-5-deb_cv1
stdout: ctn-dev.out
