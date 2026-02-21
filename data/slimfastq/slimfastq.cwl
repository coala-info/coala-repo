cwlVersion: v1.2
class: CommandLineTool
baseCommand: slimfastq
label: slimfastq
doc: "The provided text does not contain help information or a description of the
  tool; it consists of error logs from a container runtime (Apptainer/Singularity)
  failing to fetch the image.\n\nTool homepage: https://github.com/Infinidat/slimfastq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/slimfastq:2.04--h503566f_5
stdout: slimfastq.out
