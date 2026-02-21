cwlVersion: v1.2
class: CommandLineTool
baseCommand: vpt-cellpose2
label: vpt-cellpose2
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains system logs related to a failed container image build/fetch
  process.\n\nTool homepage: https://github.com/Vizgen/vpt-plugin-cellpose2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vpt-cellpose2:1.0.0--hdfd78af_0
stdout: vpt-cellpose2.out
