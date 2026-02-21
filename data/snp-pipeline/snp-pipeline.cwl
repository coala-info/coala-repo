cwlVersion: v1.2
class: CommandLineTool
baseCommand: snp-pipeline
label: snp-pipeline
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a log of a failed container build/fetch process.\n\nTool
  homepage: https://github.com/CFSAN-Biostatistics/snp-pipeline"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snp-pipeline:2.2.1--pyh3252c3a_0
stdout: snp-pipeline.out
