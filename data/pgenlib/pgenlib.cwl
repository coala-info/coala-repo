cwlVersion: v1.2
class: CommandLineTool
baseCommand: pgenlib
label: pgenlib
doc: "The provided text does not contain help information for pgenlib. It appears
  to be a fatal error log from a container runtime (Apptainer/Singularity) indicating
  a failure to build or pull the container image due to insufficient disk space ('no
  space left on device').\n\nTool homepage: https://github.com/chrchang/plink-ng"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pgenlib:0.93.0--py39h475c85d_0
stdout: pgenlib.out
