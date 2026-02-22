cwlVersion: v1.2
class: CommandLineTool
baseCommand: pbpigeon
label: pbpigeon
doc: "The provided text is a system error log (Singularity/Apptainer failure) and
  does not contain help information or usage instructions for the pbpigeon tool.\n\
  \nTool homepage: https://github.com/PacificBiosciences/pigeon"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pbpigeon:1.4.0--h9948957_0
stdout: pbpigeon.out
