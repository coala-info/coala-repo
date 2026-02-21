cwlVersion: v1.2
class: CommandLineTool
baseCommand: miniasm
label: miniasm
doc: "The provided text is an error log indicating a failure to pull or convert the
  miniasm container image due to insufficient disk space. It does not contain the
  help text or usage instructions for the tool.\n\nTool homepage: https://github.com/lh3/miniasm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/miniasm:0.3_r179--ha92aebf_0
stdout: miniasm.out
