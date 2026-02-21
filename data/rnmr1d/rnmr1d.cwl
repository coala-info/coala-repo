cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnmr1d
label: rnmr1d
doc: "The provided text does not contain help information for rnmr1d; it is an error
  log from a container runtime (Apptainer/Singularity) failing to pull the image.\n
  \nTool homepage: https://github.com/INRA/Rnmr1D"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rnmr1d:phenomenal-v1.2.22_cv0.3.49
stdout: rnmr1d.out
