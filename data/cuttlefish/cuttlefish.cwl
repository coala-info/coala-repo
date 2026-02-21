cwlVersion: v1.2
class: CommandLineTool
baseCommand: cuttlefish
label: cuttlefish
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container runtime (Apptainer/Singularity) indicating
  a failure to build the image due to insufficient disk space.\n\nTool homepage: https://github.com/COMBINE-lab/cuttlefish"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cuttlefish:2.2.0--h6b3f7d6_5
stdout: cuttlefish.out
