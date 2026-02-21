cwlVersion: v1.2
class: CommandLineTool
baseCommand: mokapot
label: mokapot
doc: "The provided text is an error message regarding a container execution failure
  and does not contain help text or argument definitions for the tool 'mokapot'.\n
  \nTool homepage: https://github.com/wfondrie/mokapot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mokapot:0.10.0--pyhdfd78af_0
stdout: mokapot.out
