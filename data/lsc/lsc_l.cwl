cwlVersion: v1.2
class: CommandLineTool
baseCommand: lsc_l
label: lsc_l
doc: "The provided text does not contain help information or a description of the
  tool. It contains error logs related to a container runtime (Apptainer/Singularity)
  failure due to insufficient disk space.\n\nTool homepage: https://github.com/arismelachroinos/lscript"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lsc:2.0--py27pl5.22.0_0
stdout: lsc_l.out
