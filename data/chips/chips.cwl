cwlVersion: v1.2
class: CommandLineTool
baseCommand: chips
label: chips
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container runtime (Apptainer/Singularity) indicating
  a failure to build or unpack the image due to insufficient disk space.\n\nTool homepage:
  https://github.com/gymreklab/chips"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chips:2.4--h43eeafb_7
stdout: chips.out
