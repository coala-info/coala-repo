cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyscaf_putup
label: pyscaf_putup
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a log of a failed container build or execution.\n\nTool
  homepage: https://github.com/pyscaffold/pyscaffold"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyscaf:0.12a4--py27_0
stdout: pyscaf_putup.out
