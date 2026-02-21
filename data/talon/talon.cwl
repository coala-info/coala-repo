cwlVersion: v1.2
class: CommandLineTool
baseCommand: talon
label: talon
doc: "The provided text does not contain help information or usage instructions for
  the 'talon' tool. It contains system logs and a fatal error message regarding a
  container image build failure.\n\nTool homepage: https://github.com/mortazavilab/TALON"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/talon:6.0.1--pyhdfd78af_0
stdout: talon.out
