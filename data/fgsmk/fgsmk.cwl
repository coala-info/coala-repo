cwlVersion: v1.2
class: CommandLineTool
baseCommand: fgsmk
label: fgsmk
doc: "The provided text does not contain help information for the tool 'fgsmk'. It
  contains system error messages related to a container runtime (Apptainer/Singularity)
  failing to build a SIF image due to insufficient disk space.\n\nTool homepage: https://pypi.org/project/fgsmk/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgsmk:0.1.2--pyhdfd78af_0
stdout: fgsmk.out
