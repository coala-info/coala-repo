cwlVersion: v1.2
class: CommandLineTool
baseCommand: cycle_torchrun
label: cycle_torchrun
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be an error log from a container build process (Apptainer/Singularity)
  indicating a 'no space left on device' failure.\n\nTool homepage: https://github.com/junyanz/pytorch-CycleGAN-and-pix2pix"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/cycle:v0.3.1-14-deb_cv1
stdout: cycle_torchrun.out
