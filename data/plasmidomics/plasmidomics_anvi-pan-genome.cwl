cwlVersion: v1.2
class: CommandLineTool
baseCommand: anvi-pan-genome
label: plasmidomics_anvi-pan-genome
doc: "Note: The provided text is a system error log (Singularity/Apptainer) indicating
  a failure to build or extract the container image due to lack of disk space ('no
  space left on device'). It does not contain the help text or usage information for
  the tool.\n\nTool homepage: https://github.com/braddmg/Plasmidome-analysis"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/plasmidomics:v0.2.0-7-deb_cv1
stdout: plasmidomics_anvi-pan-genome.out
