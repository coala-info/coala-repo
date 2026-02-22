cwlVersion: v1.2
class: CommandLineTool
baseCommand: samtools
label: biocontainers_samtools
doc: "The provided text is an error message indicating a failure to retrieve the container
  image (docker://biocontainers/biocontainers:08252016-4) and does not contain help
  documentation or argument definitions.\n\nTool homepage: https://github.com/BioContainers/containers"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/biocontainers:08252016-4
stdout: biocontainers_samtools.out
