cwlVersion: v1.2
class: CommandLineTool
baseCommand: gatk
label: gatk
doc: "Genome Analysis Toolkit (GATK)\n\nTool homepage: https://www.broadinstitute.org/gatk/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gatk:3.8--py27_1
stdout: gatk.out
