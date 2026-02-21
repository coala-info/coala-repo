cwlVersion: v1.2
class: CommandLineTool
baseCommand: clermonTyping.sh
label: clermontyping_clermonTyping.sh
doc: "The provided text is an error log indicating a failure to build or extract a
  container image (no space left on device) and does not contain help documentation
  or argument definitions.\n\nTool homepage: https://github.com/happykhan/ClermonTyping"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clermontyping:24.02--py312hdfd78af_1
stdout: clermontyping_clermonTyping.sh.out
