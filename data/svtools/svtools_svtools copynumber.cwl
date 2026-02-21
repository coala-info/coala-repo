cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - svtools
  - copynumber
label: svtools_svtools copynumber
doc: "The provided text does not contain help information for the tool, but appears
  to be a container execution error log. No arguments could be extracted.\n\nTool
  homepage: https://github.com/hall-lab/svtools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svtools:0.5.1--py_0
stdout: svtools_svtools copynumber.out
