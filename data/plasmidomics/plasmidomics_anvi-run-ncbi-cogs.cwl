cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - anvi-run-ncbi-cogs
label: plasmidomics_anvi-run-ncbi-cogs
doc: "The provided text does not contain help information for the tool. It appears
  to be a log of a failed container build process (Singularity/Apptainer) due to insufficient
  disk space.\n\nTool homepage: https://github.com/braddmg/Plasmidome-analysis"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/plasmidomics:v0.2.0-7-deb_cv1
stdout: plasmidomics_anvi-run-ncbi-cogs.out
