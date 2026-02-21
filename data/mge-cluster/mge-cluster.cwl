cwlVersion: v1.2
class: CommandLineTool
baseCommand: mge-cluster
label: mge-cluster
doc: "The provided text does not contain help information for the tool. It consists
  of system error messages related to a container runtime (Apptainer/Singularity)
  failing to pull the image due to insufficient disk space.\n\nTool homepage: https://gitlab.com/sirarredondo/mge_cluster"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mge-cluster:1.1.0--pyh5ace695_0
stdout: mge-cluster.out
