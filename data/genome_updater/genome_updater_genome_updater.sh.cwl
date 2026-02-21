cwlVersion: v1.2
class: CommandLineTool
baseCommand: genome_updater.sh
label: genome_updater_genome_updater.sh
doc: "A tool for downloading and updating genomic data (Note: The provided text is
  a container execution error log and does not contain help documentation or argument
  definitions).\n\nTool homepage: https://github.com/pirovc/genome_updater"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genometools-genometools:1.6.6--py311h5faa0f1_0
stdout: genome_updater_genome_updater.sh.out
