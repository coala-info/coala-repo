cwlVersion: v1.2
class: CommandLineTool
baseCommand: plasmidomics
label: plasmidomics
doc: "The provided text is an error log from a container build process and does not
  contain the help documentation for the 'plasmidomics' tool. As a result, no arguments
  could be extracted.\n\nTool homepage: https://github.com/braddmg/Plasmidome-analysis"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/plasmidomics:v0.2.0-7-deb_cv1
stdout: plasmidomics.out
