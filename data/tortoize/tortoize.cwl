cwlVersion: v1.2
class: CommandLineTool
baseCommand: tortoize
label: tortoize
doc: "The provided text does not contain help information or usage instructions for
  the tool 'tortoize'. It appears to be an error log from a container runtime (Apptainer/Singularity)
  failing to fetch the tool's image.\n\nTool homepage: https://github.com/PDB-REDO/tortoize"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tortoize:2.0.16--haf24da9_0
stdout: tortoize.out
