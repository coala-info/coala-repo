cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepsignal-plant
label: deepsignal-plant_deepsignal_plant
doc: "A tool for detecting DNA methylation from Nanopore sequencing data in plants.
  (Note: The provided text is a container execution error log and does not contain
  CLI help information; therefore, no arguments could be extracted.)\n\nTool homepage:
  https://github.com/PengNi/deepsignal-plant"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepsignal-plant:0.1.6--pyhdfd78af_0
stdout: deepsignal-plant_deepsignal_plant.out
