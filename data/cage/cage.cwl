cwlVersion: v1.2
class: CommandLineTool
baseCommand: cage
label: cage
doc: "The provided text does not contain help information for the 'cage' tool; it
  is an error log from a container build process (Apptainer/Singularity) indicating
  a 'no space left on device' failure.\n\nTool homepage: https://github.com/docker/cagent"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cage:2016.05.13--he8c0b07_8
stdout: cage.out
