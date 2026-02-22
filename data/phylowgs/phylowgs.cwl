cwlVersion: v1.2
class: CommandLineTool
baseCommand: phylowgs
label: phylowgs
doc: "The provided text does not contain help information or documentation for the
  tool; it consists of system error messages related to a container runtime (Singularity/Apptainer)
  failing to pull a Docker image due to insufficient disk space.\n\nTool homepage:
  https://github.com/morrislab/phylowgs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylowgs:20181105--py27hc2ebfaa_0
stdout: phylowgs.out
