cwlVersion: v1.2
class: CommandLineTool
baseCommand: hilive2
label: hilive2
doc: "HiLive2: Real-time alignment of Illumina reads\n\nTool homepage: https://gitlab.com/rki_bioinformatics/HiLive2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hilive2:2.0--h06e6e9f_4
stdout: hilive2.out
