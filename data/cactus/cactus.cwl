cwlVersion: v1.2
class: CommandLineTool
baseCommand: cactus
label: cactus
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a system error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build the image due to lack of disk space.\n\nTool homepage:
  https://github.com/ComparativeGenomicsToolkit/cactus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cactus:2019.03.01--py27hdbcaa40_0
stdout: cactus.out
