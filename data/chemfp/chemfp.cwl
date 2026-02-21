cwlVersion: v1.2
class: CommandLineTool
baseCommand: chemfp
label: chemfp
doc: "The provided text does not contain help information for the chemfp tool. It
  contains error logs from a container runtime (Apptainer/Singularity) indicating
  a failure to build or extract the container image due to insufficient disk space.\n
  \nTool homepage: https://chemfp.com"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chemfp:1.6.1--py27h9801fc8_2
stdout: chemfp.out
