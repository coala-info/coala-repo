cwlVersion: v1.2
class: CommandLineTool
baseCommand: bioepic
label: bioepic
doc: "The provided text does not contain help information or usage instructions for
  the tool 'bioepic'. It appears to be a log of a failed execution or container build
  process.\n\nTool homepage: https://github.com/bioepic-data/bioepic_skills"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bioepic:0.1.6--py27_0
stdout: bioepic.out
