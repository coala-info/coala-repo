cwlVersion: v1.2
class: CommandLineTool
baseCommand: pysamstats
label: pysamstats
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a system log showing a fatal error during a container image build
  process.\n\nTool homepage: https://github.com/alimanfoo/pysamstats"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pysamstats:1.1.2--py311h384fd50_15
stdout: pysamstats.out
