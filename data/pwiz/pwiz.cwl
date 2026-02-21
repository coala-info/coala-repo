cwlVersion: v1.2
class: CommandLineTool
baseCommand: pwiz
label: pwiz
doc: "The provided text is a container runtime error log and does not contain help
  documentation or usage instructions for the pwiz tool. As a result, no arguments
  could be extracted.\n\nTool homepage: https://github.com/ProteoWizard/pwiz"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/pwiz:phenomenal-v3.0.18205_cv1.2.54
stdout: pwiz.out
