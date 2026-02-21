cwlVersion: v1.2
class: CommandLineTool
baseCommand: wkhtmltopdf
label: wkhtmltopdf
doc: "The provided text does not contain help information for wkhtmltopdf; it is a
  log of a failed container build process.\n\nTool homepage: https://github.com/wkhtmltopdf/wkhtmltopdf"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wkhtmltopdf:0.12.3--0
stdout: wkhtmltopdf.out
