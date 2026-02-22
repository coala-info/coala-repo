cwlVersion: v1.2
class: CommandLineTool
baseCommand: braid-mrf
label: braid-mrf
doc: "The provided text does not contain help information for the tool; it consists
  of system error messages related to a container runtime (Singularity/Apptainer)
  failing to pull a Docker image due to insufficient disk space.\n\nTool homepage:
  https://github.com/wasineer-dev/braid.git"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/braid-mrf:1.0.9--pyhfa5458b_0
stdout: braid-mrf.out
