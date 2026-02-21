cwlVersion: v1.2
class: CommandLineTool
baseCommand: microbegps
label: microbegps
doc: 'MicrobeGPS is a bioinformatics tool for the taxonomic profiling of metagenomic
  samples. (Note: The provided help text contains only system error messages regarding
  container execution and does not list specific tool arguments.)'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/microbegps:v1.0.0-3-deb_cv1
stdout: microbegps.out
