cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyquant-ms
label: pyquant-ms
doc: "No description available from the provided text.\n\nTool homepage: https://chris7.github.io/pyquant/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyquant-ms:0.2.4--py27hc1659b7_0
stdout: pyquant-ms.out
