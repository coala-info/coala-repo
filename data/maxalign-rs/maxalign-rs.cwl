cwlVersion: v1.2
class: CommandLineTool
baseCommand: maxalign-rs
label: maxalign-rs
doc: "A tool for sequence alignment (Note: The provided input text contains system
  error messages regarding container execution and does not include the tool's help
  documentation or usage instructions).\n\nTool homepage: https://github.com/apcamargo/maxalign-rs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/maxalign-rs:0.1.0--h4349ce8_0
stdout: maxalign-rs.out
