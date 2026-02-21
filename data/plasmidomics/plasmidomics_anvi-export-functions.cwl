cwlVersion: v1.2
class: CommandLineTool
baseCommand: anvi-export-functions
label: plasmidomics_anvi-export-functions
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log regarding a failed container build (no space left on device).\n
  \nTool homepage: https://github.com/braddmg/Plasmidome-analysis"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/plasmidomics:v0.2.0-7-deb_cv1
stdout: plasmidomics_anvi-export-functions.out
