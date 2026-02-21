cwlVersion: v1.2
class: CommandLineTool
baseCommand: anvi-gen-contigs-database
label: plasmidomics_anvi-gen-contigs-database
doc: "The provided text is an error log from a container build process (Singularity/Apptainer)
  and does not contain help information or argument definitions for the tool 'anvi-gen-contigs-database'.\n
  \nTool homepage: https://github.com/braddmg/Plasmidome-analysis"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/plasmidomics:v0.2.0-7-deb_cv1
stdout: plasmidomics_anvi-gen-contigs-database.out
