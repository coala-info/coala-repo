cwlVersion: v1.2
class: CommandLineTool
baseCommand: beacon
label: beacon2-ri-tools_beacon
doc: "The provided text is a container execution error log and does not contain help
  documentation or argument definitions for the tool.\n\nTool homepage: https://github.com/EGA-archive/beacon2-ri-tools/tree/main"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/beacon2-ri-tools:2.0.5--py310hdfd78af_0
stdout: beacon2-ri-tools_beacon.out
