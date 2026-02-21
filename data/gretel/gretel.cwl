cwlVersion: v1.2
class: CommandLineTool
baseCommand: gretel
label: gretel
doc: "A tool for recovery of haplotypes from metagenomes (Note: The provided text
  is a container runtime error log and does not contain help documentation or argument
  definitions).\n\nTool homepage: https://github.com/SamStudio8/gretel"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gretel:0.0.94--pyh864c0ab_1
stdout: gretel.out
