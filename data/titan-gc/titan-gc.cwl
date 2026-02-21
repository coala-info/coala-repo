cwlVersion: v1.2
class: CommandLineTool
baseCommand: titan-gc
label: titan-gc
doc: "A tool for calculating GC content and mappability for TitanCNA (Titan Genomic
  Characterization).\n\nTool homepage: https://github.com/theiagen/public_health_viral_genomics"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/titan-gc:1.5.3--hdfd78af_1
stdout: titan-gc.out
