cwlVersion: v1.2
class: CommandLineTool
baseCommand: maxit
label: maxit
doc: "The provided text does not contain help information for the tool 'maxit'. It
  contains error messages related to a container runtime (Apptainer/Singularity) failing
  to pull the image due to insufficient disk space.\n\nTool homepage: https://sw-tools.rcsb.org/apps/MAXIT"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/maxit:11.400--h503566f_0
stdout: maxit.out
