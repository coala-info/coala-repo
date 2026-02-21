cwlVersion: v1.2
class: CommandLineTool
baseCommand: cif-validate
label: cif-tools_cif-validate
doc: "A tool for validating CIF (Crystallographic Information Framework) files. Note:
  The provided help text contains only system error logs and does not list specific
  command-line arguments.\n\nTool homepage: https://github.com/PDB-REDO/cif-tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cif-tools:1.0.12--h077b44d_0
stdout: cif-tools_cif-validate.out
