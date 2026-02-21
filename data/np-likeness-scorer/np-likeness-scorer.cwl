cwlVersion: v1.2
class: CommandLineTool
baseCommand: np-likeness-scorer
label: np-likeness-scorer
doc: 'A tool for scoring the Natural Product-likeness of molecules. (Note: The provided
  text is a system error log and does not contain usage instructions or argument definitions.)'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/np-likeness-scorer:2.1--py36_0
stdout: np-likeness-scorer.out
