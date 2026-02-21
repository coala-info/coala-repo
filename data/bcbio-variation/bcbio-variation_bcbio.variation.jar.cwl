cwlVersion: v1.2
class: CommandLineTool
baseCommand: bcbio-variation
label: bcbio-variation_bcbio.variation.jar
doc: "A tool for variant calling and analysis (Note: The provided help text contains
  only system error logs and no usage information).\n\nTool homepage: https://github.com/chapmanb/bcbio.variation"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcbio-variation:0.2.6--1
stdout: bcbio-variation_bcbio.variation.jar.out
