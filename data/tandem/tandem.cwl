cwlVersion: v1.2
class: CommandLineTool
baseCommand: tandem
label: tandem
doc: "X! Tandem is a software for protein identification by tandem mass spectrometry.
  (Note: The provided text was an error log and did not contain usage instructions
  or argument definitions).\n\nTool homepage: https://github.com/tum-vision/tandem"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/tandem:v17-02-01-4_cv4
stdout: tandem.out
