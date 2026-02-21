cwlVersion: v1.2
class: CommandLineTool
baseCommand: anvi-run-hmms
label: plasmidomics_anvi-run-hmms
doc: "The provided text is an error log indicating a failure to build or fetch the
  container image (no space left on device) and does not contain help text or usage
  information for the tool.\n\nTool homepage: https://github.com/braddmg/Plasmidome-analysis"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/plasmidomics:v0.2.0-7-deb_cv1
stdout: plasmidomics_anvi-run-hmms.out
