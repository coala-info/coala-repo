cwlVersion: v1.2
class: CommandLineTool
baseCommand: phaser
label: phaser
doc: "The provided text does not contain help information for the tool 'phaser'. It
  contains system error logs related to a container runtime (Apptainer/Singularity)
  failing to extract an image due to insufficient disk space.\n\nTool homepage: https://github.com/secastel/phaser"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phaser:0.1.1ad5f89--py27pl5321h9f5acd7_0
stdout: phaser.out
