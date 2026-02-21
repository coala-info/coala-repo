cwlVersion: v1.2
class: CommandLineTool
baseCommand: rabbitsketch
label: rabbitsketch_exe_main
doc: "The provided text does not contain help information for the tool. It appears
  to be a fatal error log from a container runtime (Apptainer/Singularity) attempting
  to fetch the tool's image.\n\nTool homepage: https://github.com/RabbitBio/RabbitSketch"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rabbitsketch:0.1.1--py39h5ca1c30_0
stdout: rabbitsketch_exe_main.out
