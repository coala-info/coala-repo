cwlVersion: v1.2
class: CommandLineTool
baseCommand: htsinfer
label: htsinfer
doc: "The provided text is an error log indicating a failure to initialize the tool
  container due to insufficient disk space; no help text or usage information was
  available to parse.\n\nTool homepage: https://github.com/zavolanlab/htsinfer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/htsinfer:1.0.0_rc.1--pyhdfd78af_0
stdout: htsinfer.out
