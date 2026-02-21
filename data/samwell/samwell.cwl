cwlVersion: v1.2
class: CommandLineTool
baseCommand: samwell
label: samwell
doc: "No description available in the provided text.\n\nTool homepage: https://pypi.org/project/samwell/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samwell:0.0.4--py39hf95cd2a_2
stdout: samwell.out
