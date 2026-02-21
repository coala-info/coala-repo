cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyscaf_pytest
label: pyscaf_pytest
doc: "The provided text contains container build logs and error messages rather than
  command-line help documentation. No arguments or tool descriptions could be extracted.\n
  \nTool homepage: https://github.com/pyscaffold/pyscaffold"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyscaf:0.12a4--py27_0
stdout: pyscaf_pytest.out
