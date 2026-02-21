cwlVersion: v1.2
class: CommandLineTool
baseCommand: libpdb-redo_rsync
label: libpdb-redo_rsync
doc: "The provided text does not contain help information or usage instructions; it
  is an error log indicating a failure to build a container image due to insufficient
  disk space.\n\nTool homepage: https://pdb-redo.eu"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/libpdb-redo:3.3.1--hb66fcc3_0
stdout: libpdb-redo_rsync.out
