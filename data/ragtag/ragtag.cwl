cwlVersion: v1.2
class: CommandLineTool
baseCommand: ragtag
label: ragtag
doc: "The provided text does not contain help information for the tool. It appears
  to be a fatal error log from a container runtime (Apptainer/Singularity) failing
  to fetch the ragtag image.\n\nTool homepage: https://github.com/malonge/RagTag"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ragtag:2.1.0--pyhb7b1952_0
stdout: ragtag.out
