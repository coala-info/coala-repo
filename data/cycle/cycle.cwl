cwlVersion: v1.2
class: CommandLineTool
baseCommand: cycle
label: cycle
doc: "The provided text does not contain help information or usage instructions for
  the 'cycle' tool. It appears to be a log of a failed container build/extraction
  process (Apptainer/Singularity) due to insufficient disk space.\n\nTool homepage:
  https://github.com/junyanz/pytorch-CycleGAN-and-pix2pix"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/cycle:v0.3.1-14-deb_cv1
stdout: cycle.out
