cwlVersion: v1.2
class: CommandLineTool
baseCommand: ocrad
label: ocrad
doc: "GNU Ocrad is an OCR (Optical Character Recognition) program based on a feature
  extraction method. It reads images in pbm (bitmap), pgm (greyscale) or ppm (color)
  formats and produces text in byte (8-bit) or UTF-8 formats.\n\nTool homepage: https://github.com/antimatter15/ocrad.js"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ocrad:0.21--h470a237_1
stdout: ocrad.out
