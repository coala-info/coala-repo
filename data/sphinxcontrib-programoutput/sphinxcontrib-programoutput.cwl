cwlVersion: v1.2
class: CommandLineTool
baseCommand: sphinxcontrib-programoutput
label: sphinxcontrib-programoutput
doc: "The provided text does not contain help information for the tool; it contains
  container build logs and a fatal error message regarding an OCI image URI.\n\nTool
  homepage: https://github.com/OpenNTI/sphinxcontrib-programoutput"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sphinxcontrib-programoutput:0.8--py36_0
stdout: sphinxcontrib-programoutput.out
