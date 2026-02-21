cwlVersion: v1.2
class: CommandLineTool
baseCommand: phastaf
label: phastaf
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  attempting to pull the phastaf image.\n\nTool homepage: https://github.com/tseemann/phastaf"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phastaf:0.1.0--0
stdout: phastaf.out
