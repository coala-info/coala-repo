cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyhmmer_hmmbuild
label: pyhmmer_hmmbuild
doc: "The provided text does not contain help information or usage instructions for
  the tool; it is a log of a failed container build process. Consequently, no arguments
  could be extracted.\n\nTool homepage: https://github.com/althonos/pyhmmer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyhmmer:0.12.0--py313h366bbf7_0
stdout: pyhmmer_hmmbuild.out
