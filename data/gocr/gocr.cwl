cwlVersion: v1.2
class: CommandLineTool
baseCommand: gocr
label: gocr
doc: "GOCR is an OCR (Optical Character Recognition) program. (Note: The provided
  help text contains only container engine error logs and no command-line argument
  information.)\n\nTool homepage: https://jocr.sourceforge.net"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gocr:0.52--h7b50bb2_0
stdout: gocr.out
