cwlVersion: v1.2
class: CommandLineTool
baseCommand: galaxy-parsec
label: galaxy-parsec
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build a SIF image due to insufficient disk space.\n\nTool
  homepage: https://github.com/galaxy-iuc/parsec"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/galaxy-parsec:1.16.0--pyh5e36f6f_0
stdout: galaxy-parsec.out
