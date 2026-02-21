cwlVersion: v1.2
class: CommandLineTool
baseCommand: pytables
label: pytables
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be an error log from a container build process (Apptainer/Singularity)
  attempting to fetch a pytables image.\n\nTool homepage: https://github.com/PyTables/PyTables"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pytables:3.4.4
stdout: pytables.out
