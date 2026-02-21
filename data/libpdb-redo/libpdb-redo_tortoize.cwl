cwlVersion: v1.2
class: CommandLineTool
baseCommand: tortoize
label: libpdb-redo_tortoize
doc: "The provided text is an error message from a container runtime (Apptainer/Singularity)
  and does not contain help information or argument definitions for the tool libpdb-redo_tortoize.\n
  \nTool homepage: https://pdb-redo.eu"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/libpdb-redo:3.3.1--hb66fcc3_0
stdout: libpdb-redo_tortoize.out
