cwlVersion: v1.2
class: CommandLineTool
baseCommand: pydp
label: pydp
doc: "A Python wrapper for Google's Differential Privacy library. (Note: The provided
  text contains container build logs and error messages rather than CLI help documentation;
  therefore, no arguments could be extracted.)\n\nTool homepage: https://github.com/Roth-Lab/pydp/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pydp:0.2.4--py_0
stdout: pydp.out
