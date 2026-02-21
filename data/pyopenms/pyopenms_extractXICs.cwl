cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyopenms_extractXICs
label: pyopenms_extractXICs
doc: "A tool from the pyOpenMS package for extracting Extracted Ion Chromatograms
  (XICs). Note: The provided help text contains container engine error messages and
  does not list specific command-line arguments.\n\nTool homepage: https://github.com/OpenMS/OpenMS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyopenms:3.4.1--py310h7ad0250_2
stdout: pyopenms_extractXICs.out
