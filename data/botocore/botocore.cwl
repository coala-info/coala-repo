cwlVersion: v1.2
class: CommandLineTool
baseCommand: botocore
label: botocore
doc: "Low-level, data-driven core of boto 3 (Note: The provided text is an error log
  and does not contain CLI help information).\n\nTool homepage: https://github.com/boto/botocore"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/botocore:1.3.6--py36_0
stdout: botocore.out
