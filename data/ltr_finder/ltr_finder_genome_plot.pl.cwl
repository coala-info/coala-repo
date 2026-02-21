cwlVersion: v1.2
class: CommandLineTool
baseCommand: ltr_finder_genome_plot.pl
label: ltr_finder_genome_plot.pl
doc: "A tool for generating genome plots based on LTR_FINDER output. (Note: The provided
  help text contains only system error messages and no usage information.)\n\nTool
  homepage: https://github.com/NBISweden/LTR_Finder/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ltr_harvest_parallel:1.2--hdfd78af_2
stdout: ltr_finder_genome_plot.pl.out
