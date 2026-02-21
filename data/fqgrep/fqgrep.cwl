cwlVersion: v1.2
class: CommandLineTool
baseCommand: fqgrep
label: fqgrep
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build the container due to insufficient disk space.\n\n
  Tool homepage: https://github.com/fulcrumgenomics/fqgrep"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fqgrep:1.1.1--ha6fb395_0
stdout: fqgrep.out
