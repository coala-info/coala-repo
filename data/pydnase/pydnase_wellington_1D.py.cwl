cwlVersion: v1.2
class: CommandLineTool
baseCommand: pydnase_wellington_1D.py
label: pydnase_wellington_1D.py
doc: "The provided text does not contain help information for the tool, as it appears
  to be a container execution error log. No arguments could be extracted.\n\nTool
  homepage: http://jpiper.github.io/pyDNase"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pydnase:0.3.0--py35_0
stdout: pydnase_wellington_1D.py.out
