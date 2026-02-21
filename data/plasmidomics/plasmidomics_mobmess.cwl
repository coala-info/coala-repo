cwlVersion: v1.2
class: CommandLineTool
baseCommand: mobmess
label: plasmidomics_mobmess
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain help documentation or usage information for the tool. Consequently,
  no arguments could be extracted.\n\nTool homepage: https://github.com/braddmg/Plasmidome-analysis"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/plasmidomics:v0.2.0-7-deb_cv1
stdout: plasmidomics_mobmess.out
