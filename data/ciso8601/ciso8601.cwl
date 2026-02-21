cwlVersion: v1.2
class: CommandLineTool
baseCommand: ciso8601
label: ciso8601
doc: "ciso8601 converts ISO 8601 or RFC 3339 date time strings into Python datetime
  objects.\n\nTool homepage: https://github.com/elasticsales/ciso8601"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ciso8601:1.0.5--py35_0
stdout: ciso8601.out
