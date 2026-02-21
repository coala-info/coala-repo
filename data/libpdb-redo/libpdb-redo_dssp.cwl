cwlVersion: v1.2
class: CommandLineTool
baseCommand: libpdb-redo_dssp
label: libpdb-redo_dssp
doc: "The provided text does not contain help information; it consists of system error
  messages related to a container runtime failure (no space left on device).\n\nTool
  homepage: https://pdb-redo.eu"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/libpdb-redo:3.3.1--hb66fcc3_0
stdout: libpdb-redo_dssp.out
