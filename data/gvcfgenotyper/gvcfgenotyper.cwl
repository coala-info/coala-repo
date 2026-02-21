cwlVersion: v1.2
class: CommandLineTool
baseCommand: gvcfgenotyper
label: gvcfgenotyper
doc: "A tool for genotyper gVCF files (Note: The provided help text contains only
  container runtime error messages and no usage information).\n\nTool homepage: https://github.com/Illumina/gvcfgenotyper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gvcfgenotyper:2019.02.26--h13024bc_6
stdout: gvcfgenotyper.out
