cwlVersion: v1.2
class: CommandLineTool
baseCommand: plncpro
label: plncpro
doc: "The provided text is a system error log indicating a failure to build or run
  the container image (no space left on device) and does not contain the tool's help
  documentation or argument definitions.\n\nTool homepage: https://github.com/urmi-21/PLncPRO"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plncpro:1.2.2--py37hc9558a2_0
stdout: plncpro.out
