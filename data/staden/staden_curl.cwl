cwlVersion: v1.2
class: CommandLineTool
baseCommand: staden_curl
label: staden_curl
doc: "The provided text is a container build error log and does not contain help documentation
  or usage instructions for the tool.\n\nTool homepage: https://github.com/oshikiri/staden-outliner"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/staden:v2.0.0b11-4-deb_cv1
stdout: staden_curl.out
