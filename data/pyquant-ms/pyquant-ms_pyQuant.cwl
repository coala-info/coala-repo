cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyQuant
label: pyquant-ms_pyQuant
doc: "A tool for mass spectrometry quantification. (Note: The provided input text
  appears to be a container build error log rather than CLI help text, so no arguments
  could be extracted.)\n\nTool homepage: https://chris7.github.io/pyquant/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyquant-ms:0.2.4--py27hc1659b7_0
stdout: pyquant-ms_pyQuant.out
