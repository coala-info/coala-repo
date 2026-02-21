cwlVersion: v1.2
class: CommandLineTool
baseCommand: meraculous
label: meraculous
doc: "A de novo genome assembler for next-generation sequencing data. (Note: The provided
  text contains container runtime error messages and does not include the tool's help
  documentation; therefore, no arguments could be extracted.)\n\nTool homepage: https://jgi.doe.gov/data-and-tools/meraculous/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/meraculous:2.2.6--pl5321h9948957_9
stdout: meraculous.out
