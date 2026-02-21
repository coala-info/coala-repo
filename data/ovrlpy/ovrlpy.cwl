cwlVersion: v1.2
class: CommandLineTool
baseCommand: ovrlpy
label: ovrlpy
doc: "The provided text does not contain help information for the tool 'ovrlpy'. It
  contains system error messages related to a container runtime (Apptainer/Singularity)
  failing to pull the image due to insufficient disk space.\n\nTool homepage: https://github.com/HiDiHlabs/ovrl.py"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ovrlpy:1.1.0--pyhdfd78af_0
stdout: ovrlpy.out
