cwlVersion: v1.2
class: CommandLineTool
baseCommand: cycle_python
label: cycle_python
doc: "The provided text does not contain help information or usage instructions. It
  appears to be an error log from a container build process (Apptainer/Singularity)
  failing due to insufficient disk space.\n\nTool homepage: https://github.com/junyanz/pytorch-CycleGAN-and-pix2pix"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/cycle:v0.3.1-14-deb_cv1
stdout: cycle_python.out
