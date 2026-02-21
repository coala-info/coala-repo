cwlVersion: v1.2
class: CommandLineTool
baseCommand: provean
label: provean
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be an error log from a container runtime (Singularity/Apptainer)
  failing to fetch the tool's image.\n\nTool homepage: https://www.jcvi.org/research/provean"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/provean:1.1.5--h503566f_3
stdout: provean.out
