cwlVersion: v1.2
class: CommandLineTool
baseCommand: patholive
label: patholive
doc: "The provided text does not contain help information or a description of the
  tool; it consists of error messages related to a Singularity container execution
  failure (disk space issues).\n\nTool homepage: https://gitlab.com/SimonHTausch/PathoLive"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/patholive:1.0--0
stdout: patholive.out
