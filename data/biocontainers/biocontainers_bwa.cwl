cwlVersion: v1.2
class: CommandLineTool
baseCommand: bwa
label: biocontainers_bwa
doc: "The provided text is an error message indicating a failure to pull the container
  image and does not contain help documentation for the tool.\n\nTool homepage: https://github.com/BioContainers/containers"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/biocontainers:08252016-4
stdout: biocontainers_bwa.out
