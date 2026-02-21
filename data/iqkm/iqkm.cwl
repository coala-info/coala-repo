cwlVersion: v1.2
class: CommandLineTool
baseCommand: iqkm
label: iqkm
doc: "The provided text does not contain help information for the tool 'iqkm'. It
  contains error messages related to a container environment (Apptainer/Singularity)
  failing to pull the image due to insufficient disk space.\n\nTool homepage: https://github.com/lijingdi/iqKM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/iqkm:1.0--pyhdfd78af_0
stdout: iqkm.out
