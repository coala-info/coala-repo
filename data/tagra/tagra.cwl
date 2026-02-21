cwlVersion: v1.2
class: CommandLineTool
baseCommand: tagra
label: tagra
doc: "The provided text does not contain help information for the tool 'tagra'. It
  contains error logs from a container build process (Apptainer/Singularity) attempting
  to fetch the 'tagra' image from a container registry.\n\nTool homepage: https://github.com/davidetorre92/TaGra"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tagra:0.2.5--pyhdfd78af_0
stdout: tagra.out
