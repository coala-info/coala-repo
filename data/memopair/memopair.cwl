cwlVersion: v1.2
class: CommandLineTool
baseCommand: memopair
label: memopair
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain help information or usage instructions for the 'memopair' tool.\n
  \nTool homepage: https://github.com/SorenHeidelbach/memopair"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/memopair:0.1.6--h4349ce8_0
stdout: memopair.out
