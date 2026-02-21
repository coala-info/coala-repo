cwlVersion: v1.2
class: CommandLineTool
baseCommand: minvar
label: minvar
doc: "The provided text does not contain help information for the tool 'minvar'. It
  contains error logs from a container runtime (Apptainer/Singularity) indicating
  a failure to build or pull the container image due to lack of disk space.\n\nTool
  homepage: https://git.io/minvar"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/minvar:2.2.2--py35_0
stdout: minvar.out
