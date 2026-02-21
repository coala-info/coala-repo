cwlVersion: v1.2
class: CommandLineTool
baseCommand: kineticstools
label: kineticstools
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build or run the image due to lack of disk space.\n\nTool
  homepage: https://github.com/PacificBiosciences/kineticsTools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/kineticstools:v0.6.120161222-1-deb-py2_cv1
stdout: kineticstools.out
