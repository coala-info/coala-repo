cwlVersion: v1.2
class: CommandLineTool
baseCommand: talon_label_reads
label: talon_talon_label_reads
doc: "The provided text does not contain help information for the tool. It appears
  to be a log of a failed container build process.\n\nTool homepage: https://github.com/mortazavilab/TALON"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/talon:6.0.1--pyhdfd78af_0
stdout: talon_talon_label_reads.out
