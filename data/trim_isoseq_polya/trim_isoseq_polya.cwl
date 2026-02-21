cwlVersion: v1.2
class: CommandLineTool
baseCommand: trim_isoseq_polya
label: trim_isoseq_polya
doc: "The provided text does not contain help information or usage instructions; it
  is a system log indicating a failure to build or pull a container image due to insufficient
  disk space.\n\nTool homepage: https://github.com/PacificBiosciences/trim_isoseq_polyA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trim_isoseq_polya:0.0.3--h7c8eefc_0
stdout: trim_isoseq_polya.out
