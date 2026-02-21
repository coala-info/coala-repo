cwlVersion: v1.2
class: CommandLineTool
baseCommand: neat
label: neat
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  indicating a failure to pull or build the container image due to insufficient disk
  space.\n\nTool homepage: https://github.com/ncsa/NEAT/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/neat:4.3.5--pyhdfd78af_0
stdout: neat.out
