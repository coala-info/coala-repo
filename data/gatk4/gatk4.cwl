cwlVersion: v1.2
class: CommandLineTool
baseCommand: gatk
label: gatk4
doc: "The Genome Analysis Toolkit (GATK) is a software package developed at the Broad
  Institute to analyze high-throughput sequencing data.\n\nTool homepage: https://www.broadinstitute.org/gatk/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gatk4:4.6.2.0--py310hdfd78af_1
stdout: gatk4.out
