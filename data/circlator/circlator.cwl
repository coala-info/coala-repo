cwlVersion: v1.2
class: CommandLineTool
baseCommand: circlator
label: circlator
doc: "A tool to circularize genome assemblies (Note: The provided input text is a
  system error log indicating a failure to pull the container image and does not contain
  help documentation or argument definitions).\n\nTool homepage: https://github.com/sanger-pathogens/circlator"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/circlator:v1.5.5-3-deb_cv1
stdout: circlator.out
