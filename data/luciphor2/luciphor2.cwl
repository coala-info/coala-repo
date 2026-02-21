cwlVersion: v1.2
class: CommandLineTool
baseCommand: luciphor2
label: luciphor2
doc: "Luciphor2 is a tool for site localization of post-translational modifications
  (PTMs) from tandem mass spectrometry data.\n\nTool homepage: http://luciphor2.sourceforge.net/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/luciphor2:2020_04_03--hdfd78af_1
stdout: luciphor2.out
