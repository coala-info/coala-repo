cwlVersion: v1.2
class: CommandLineTool
baseCommand: anvi-script-reformat-fasta
label: plasmidomics_anvi-script-reformat-fasta
doc: "The provided text is an error log from a container runtime (Singularity/Apptainer)
  indicating a failure to build or extract the OCI image due to insufficient disk
  space ('no space left on device'). It does not contain the help text or usage information
  for the tool.\n\nTool homepage: https://github.com/braddmg/Plasmidome-analysis"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/plasmidomics:v0.2.0-7-deb_cv1
stdout: plasmidomics_anvi-script-reformat-fasta.out
