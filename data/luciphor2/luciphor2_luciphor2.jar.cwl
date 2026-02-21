cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - java
  - -jar
  - luciphor2.jar
label: luciphor2_luciphor2.jar
doc: "Luciphor2 is a tool for site localization of post-translational modifications
  (PTMs) from tandem mass spectrometry data. Note: The provided text appears to be
  a system error log rather than help text; therefore, no arguments could be extracted
  from the input.\n\nTool homepage: http://luciphor2.sourceforge.net/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/luciphor2:2020_04_03--hdfd78af_1
stdout: luciphor2_luciphor2.jar.out
