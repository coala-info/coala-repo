cwlVersion: v1.2
class: CommandLineTool
baseCommand: pixelmed-www
label: pixelmed-www
doc: "A tool from the PixelMed DICOM toolkit (description not available in provided
  text).\n\nTool homepage: https://github.com/ptrxwsmitt/pixelmed-dicom-toolkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/pixelmed-www:v20150917-1-deb_cv1
stdout: pixelmed-www.out
