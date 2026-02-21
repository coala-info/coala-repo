cwlVersion: v1.2
class: CommandLineTool
baseCommand: disco
label: disco
doc: "The provided text does not contain help information for the tool 'disco'. It
  contains system error messages related to a container runtime (Apptainer/Singularity)
  failing to pull or build the container image due to lack of disk space.\n\nTool
  homepage: http://disco.omicsbio.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/disco:1.3--h5ca1c30_0
stdout: disco.out
