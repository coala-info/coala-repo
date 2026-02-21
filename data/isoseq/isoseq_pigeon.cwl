cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - isoseq
  - pigeon
label: isoseq_pigeon
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a system error log related to a container runtime (Singularity/Apptainer)
  failure due to insufficient disk space.\n\nTool homepage: https://github.com/PacificBiosciences/pbbioconda"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isoseq:4.3.0--h9ee0642_0
stdout: isoseq_pigeon.out
