cwlVersion: v1.2
class: CommandLineTool
baseCommand: msamtools
label: msamtools
doc: "A tool for processing SAM/BAM files. (Note: The provided text is a container
  runtime error message and does not contain help documentation or argument definitions.)\n
  \nTool homepage: https://github.com/arumugamlab/msamtools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msamtools:1.1.3--h577a1d6_1
stdout: msamtools.out
