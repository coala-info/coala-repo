cwlVersion: v1.2
class: CommandLineTool
baseCommand: hybkit
label: hybkit
doc: "The provided text is an error message indicating a system failure (no space
  left on device) during container execution and does not contain help text or argument
  definitions for the hybkit tool.\n\nTool homepage: https://github.com/RenneLab/hybkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hybkit:0.3.6--pyhdfd78af_0
stdout: hybkit.out
