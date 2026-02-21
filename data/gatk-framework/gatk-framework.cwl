cwlVersion: v1.2
class: CommandLineTool
baseCommand: gatk
label: gatk-framework
doc: "The Genome Analysis Toolkit (GATK) is a software package for analysis of high-throughput
  sequencing data, focusing on variant discovery and genotyping.\n\nTool homepage:
  https://gatk.broadinstitute.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gatk-framework:3.6.24--4
stdout: gatk-framework.out
