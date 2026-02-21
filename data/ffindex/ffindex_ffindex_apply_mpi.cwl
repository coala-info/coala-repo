cwlVersion: v1.2
class: CommandLineTool
baseCommand: ffindex_apply_mpi
label: ffindex_ffindex_apply_mpi
doc: "The provided text does not contain help information for the tool. It appears
  to be an error log from a container runtime (Apptainer/Singularity) indicating a
  failure to pull or run the container due to lack of disk space.\n\nTool homepage:
  https://github.com/soedinglab/ffindex_soedinglab"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ffindex:0.98--h9948957_5
stdout: ffindex_ffindex_apply_mpi.out
