cwlVersion: v1.2
class: CommandLineTool
baseCommand: blksheep
label: blksheep
doc: "The provided text contains system error messages related to a Singularity/Docker
  container execution failure (\"no space left on device\") and does not contain the
  actual help documentation or argument definitions for the blksheep tool.\n\nTool
  homepage: https://github.com/ruggleslab/blackSheep/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blksheep:0.0.7--py_0
stdout: blksheep.out
