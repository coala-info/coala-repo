cwlVersion: v1.2
class: CommandLineTool
baseCommand: trinculo
label: trinculo
doc: "The provided text does not contain help information or usage instructions for
  the tool; it is a log of a failed container image build (Apptainer/Singularity)
  due to insufficient disk space.\n\nTool homepage: https://github.com/Trinculo54/trinculo54.github.io"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trinculo:0.96--h470a237_2
stdout: trinculo.out
