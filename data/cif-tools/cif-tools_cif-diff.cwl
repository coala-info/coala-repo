cwlVersion: v1.2
class: CommandLineTool
baseCommand: cif-diff
label: cif-tools_cif-diff
doc: "The provided text does not contain help information for the tool. It contains
  error logs related to a container image build failure (no space left on device).\n
  \nTool homepage: https://github.com/PDB-REDO/cif-tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cif-tools:1.0.12--h077b44d_0
stdout: cif-tools_cif-diff.out
