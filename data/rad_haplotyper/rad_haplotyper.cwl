cwlVersion: v1.2
class: CommandLineTool
baseCommand: rad_haplotyper
label: rad_haplotyper
doc: "A tool for haplotyping RAD-seq data. (Note: The provided text contains container
  runtime error logs rather than CLI help documentation; therefore, no arguments could
  be extracted.)\n\nTool homepage: https://github.com/chollenbeck/rad_haplotyper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rad:0.6.0--h077b44d_0
stdout: rad_haplotyper.out
