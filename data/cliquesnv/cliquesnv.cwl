cwlVersion: v1.2
class: CommandLineTool
baseCommand: cliquesnv
label: cliquesnv
doc: "CliqueSNV is a tool for reconstructing viral haplotypes from next-generation
  sequencing data. (Note: The provided help text contains only system error logs and
  no usage information; therefore, no arguments could be extracted.)\n\nTool homepage:
  https://github.com/vtsyvina/CliqueSNV"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cliquesnv:2.0.3--hdfd78af_0
stdout: cliquesnv.out
