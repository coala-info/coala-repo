cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyteomics
label: pyteomics
doc: "A collection of tools for proteomics data analysis. (Note: The provided text
  is an error log and does not contain CLI help information; arguments could not be
  extracted.)\n\nTool homepage: https://github.com/levitsky/pyteomics"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyteomics:4.7.5--pyh7e72e81_0
stdout: pyteomics.out
