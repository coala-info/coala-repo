cwlVersion: v1.2
class: CommandLineTool
baseCommand: genologics
label: genologics
doc: "The provided text does not contain help information or usage instructions for
  the 'genologics' tool; it contains system error messages related to a container
  runtime environment.\n\nTool homepage: https://github.com/scilifelab/genologics"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genologics:0.4.1--py_0
stdout: genologics.out
