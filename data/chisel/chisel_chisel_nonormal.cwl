cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - chisel
  - nonormal
label: chisel_chisel_nonormal
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log from a container runtime (Apptainer/Singularity) indicating
  a failure to build or extract the container image due to insufficient disk space
  ('no space left on device').\n\nTool homepage: https://github.com/raphael-group/chisel"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chisel:1.1.4--pyhdfd78af_0
stdout: chisel_chisel_nonormal.out
