cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepsignal-plant
label: deepsignal-plant
doc: "A tool for detecting DNA methylation from Nanopore sequencing data in plants.
  (Note: The provided help text contains only container runtime error messages and
  does not list specific arguments or subcommands.)\n\nTool homepage: https://github.com/PengNi/deepsignal-plant"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepsignal-plant:0.1.6--pyhdfd78af_0
stdout: deepsignal-plant.out
