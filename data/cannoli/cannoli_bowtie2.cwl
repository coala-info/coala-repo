cwlVersion: v1.2
class: CommandLineTool
baseCommand: cannoli_bowtie2
label: cannoli_bowtie2
doc: "The provided text does not contain help information for the tool. It contains
  system log messages and a fatal error regarding disk space during a container build
  process.\n\nTool homepage: https://github.com/bigdatagenomics/cannoli"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cannoli:1.0.1--hdfd78af_0
stdout: cannoli_bowtie2.out
