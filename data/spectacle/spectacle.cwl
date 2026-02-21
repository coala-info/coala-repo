cwlVersion: v1.2
class: CommandLineTool
baseCommand: spectacle
label: spectacle
doc: "The provided text does not contain help information or a description for the
  tool 'spectacle'. It appears to be a log from a container build process (Apptainer/Singularity)
  that failed.\n\nTool homepage: https://github.com/eczarny/spectacle"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spectacle:1.4--1
stdout: spectacle.out
