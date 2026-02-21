cwlVersion: v1.2
class: CommandLineTool
baseCommand: hopla
label: hopla
doc: "The provided text does not contain help information for the tool 'hopla'. It
  contains system error messages related to a container runtime (Apptainer/Singularity)
  failing to pull the image due to lack of disk space.\n\nTool homepage: https://github.com/leraman/Hopla"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hopla:1.2.1--hdfd78af_1
stdout: hopla.out
