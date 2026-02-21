cwlVersion: v1.2
class: CommandLineTool
baseCommand: gwas-fasp
label: gwas-fasp
doc: The provided text does not contain help information or usage instructions. It
  appears to be an error log from a container runtime (Apptainer/Singularity) indicating
  a failure to pull or build the container image due to lack of disk space.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/gwas-fasp:vv1.0.0_cv1
stdout: gwas-fasp.out
