cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - apptainer
  - sif
label: apptainer_sif
doc: "Manipulate Singularity Image Format (SIF) images. A set of commands are provided
  to display elements such as the SIF global header, the data object descriptors and
  to dump data objects. It is also possible to modify a SIF file via this tool via
  the add/del commands.\n\nTool homepage: https://github.com/apptainer/apptainer"
inputs:
  - id: subcommand
    type: string
    doc: The SIF command to execute (add, del, dump, header, info, list, new, setprim)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/apptainer:latest
stdout: apptainer_sif.out
