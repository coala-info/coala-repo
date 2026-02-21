cwlVersion: v1.2
class: CommandLineTool
baseCommand: anvi-compute-functional-enrichment
label: plasmidomics_anvi-compute-functional-enrichment
doc: "The provided text does not contain help information for the tool. It is an error
  log indicating a failure to build or fetch the container image due to insufficient
  disk space.\n\nTool homepage: https://github.com/braddmg/Plasmidome-analysis"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/plasmidomics:v0.2.0-7-deb_cv1
stdout: plasmidomics_anvi-compute-functional-enrichment.out
