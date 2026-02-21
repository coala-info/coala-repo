cwlVersion: v1.2
class: CommandLineTool
baseCommand: multivcfanalyzer
label: multivcfanalyzer
doc: "The provided text does not contain help information or a description of the
  tool; it contains system error messages related to a container runtime failure (no
  space left on device).\n\nTool homepage: https://github.com/alexherbig/MultiVCFAnalyzer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/multivcfanalyzer:0.85.2--hdfd78af_1
stdout: multivcfanalyzer.out
