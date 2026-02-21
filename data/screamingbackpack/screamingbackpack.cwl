cwlVersion: v1.2
class: CommandLineTool
baseCommand: screamingbackpack
label: screamingbackpack
doc: "The provided text is a system error log regarding a container build failure
  (no space left on device) and does not contain help text or usage information for
  the tool 'screamingbackpack'.\n\nTool homepage: https://github.com/minillinim/ScreamingBackpack"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/screamingbackpack:0.2.333--py_1
stdout: screamingbackpack.out
