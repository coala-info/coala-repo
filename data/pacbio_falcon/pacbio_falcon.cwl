cwlVersion: v1.2
class: CommandLineTool
baseCommand: pacbio_falcon
label: pacbio_falcon
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Singularity/Apptainer) failing
  to pull the image due to lack of disk space.\n\nTool homepage: https://github.com/PacificBiosciences/FALCON"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pacbio_falcon:052016--py27_0
stdout: pacbio_falcon.out
