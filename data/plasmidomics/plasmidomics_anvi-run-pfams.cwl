cwlVersion: v1.2
class: CommandLineTool
baseCommand: anvi-run-pfams
label: plasmidomics_anvi-run-pfams
doc: "The provided text does not contain help information or usage instructions for
  the tool. It is a system error log indicating a failure to build a Singularity/Apptainer
  image due to insufficient disk space.\n\nTool homepage: https://github.com/braddmg/Plasmidome-analysis"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/plasmidomics:v0.2.0-7-deb_cv1
stdout: plasmidomics_anvi-run-pfams.out
