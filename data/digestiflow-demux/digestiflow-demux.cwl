cwlVersion: v1.2
class: CommandLineTool
baseCommand: digestiflow-demux
label: digestiflow-demux
doc: "Digestiflow Demux is a tool for demultiplexing Illumina sequencing runs.\n\n
  Tool homepage: https://github.com/bihealth/digestiflow-demux"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/digestiflow-demux:0.5.3--pyhdfd78af_0
stdout: digestiflow-demux.out
