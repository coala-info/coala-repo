cwlVersion: v1.2
class: CommandLineTool
baseCommand: isee-galaxy
label: isee-galaxy
doc: "The provided text is an error log from a container runtime and does not contain
  help information or usage instructions for the tool.\n\nTool homepage: https://github.com/neoformit/galaxy-isee-dev"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/isee-galaxy:v3.13_cv1.0.0
stdout: isee-galaxy.out
