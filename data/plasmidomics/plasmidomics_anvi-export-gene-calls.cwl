cwlVersion: v1.2
class: CommandLineTool
baseCommand: anvi-export-gene-calls
label: plasmidomics_anvi-export-gene-calls
doc: "The provided text is an error log indicating a system failure (no space left
  on device) during a container build and does not contain help text or usage information
  for the tool. As a result, no arguments could be extracted.\n\nTool homepage: https://github.com/braddmg/Plasmidome-analysis"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/plasmidomics:v0.2.0-7-deb_cv1
stdout: plasmidomics_anvi-export-gene-calls.out
