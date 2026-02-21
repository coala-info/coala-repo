cwlVersion: v1.2
class: CommandLineTool
baseCommand: magmax
label: magmax
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container runtime (Apptainer/Singularity) indicating
  a failure to build the image due to lack of disk space.\n\nTool homepage: https://github.com/soedinglab/MAGmax"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/magmax:1.2.0--ha6fb395_0
stdout: magmax.out
