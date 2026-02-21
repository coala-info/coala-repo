cwlVersion: v1.2
class: CommandLineTool
baseCommand: slimfastq
label: slimfastq_slimfastq.multi
doc: "The provided text does not contain help documentation or usage instructions
  for the tool; it consists of container runtime (Apptainer/Singularity) error logs
  indicating a failure to fetch or build the OCI image.\n\nTool homepage: https://github.com/Infinidat/slimfastq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/slimfastq:2.04--h503566f_5
stdout: slimfastq_slimfastq.multi.out
