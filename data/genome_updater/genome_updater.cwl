cwlVersion: v1.2
class: CommandLineTool
baseCommand: genome_updater
label: genome_updater
doc: "The provided text does not contain help information or a description for the
  tool. It appears to be an error log from a container runtime (Apptainer/Singularity)
  failure.\n\nTool homepage: https://github.com/pirovc/genome_updater"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genometools-genometools:1.6.6--py311h5faa0f1_0
stdout: genome_updater.out
