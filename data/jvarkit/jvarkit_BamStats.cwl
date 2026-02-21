cwlVersion: v1.2
class: CommandLineTool
baseCommand: jvarkit_BamStats
label: jvarkit_BamStats
doc: "The provided text does not contain help information or usage instructions. It
  contains log messages and a fatal error indicating a failure to build a container
  image due to insufficient disk space.\n\nTool homepage: https://github.com/lindenb/jvarkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jvarkit:2024.08.25--hdfd78af_2
stdout: jvarkit_BamStats.out
