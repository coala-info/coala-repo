cwlVersion: v1.2
class: CommandLineTool
baseCommand: livekraken-build
label: livekraken_livekraken-build
doc: "The provided text does not contain help information or usage instructions for
  livekraken-build; it contains system error logs related to a container execution
  failure (no space left on device).\n\nTool homepage: https://gitlab.com/SimonHTausch/LiveKraken"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/livekraken:1.0--pl5321h9948957_12
stdout: livekraken_livekraken-build.out
