cwlVersion: v1.2
class: CommandLineTool
baseCommand: cycle_conda
label: cycle_conda
doc: "The provided text does not contain help information or usage instructions; it
  appears to be a log of a failed container build process due to insufficient disk
  space.\n\nTool homepage: https://github.com/junyanz/pytorch-CycleGAN-and-pix2pix"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/cycle:v0.3.1-14-deb_cv1
stdout: cycle_conda.out
