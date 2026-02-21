cwlVersion: v1.2
class: CommandLineTool
baseCommand: rad_haplotyper_rad_haplotyper.pl
label: rad_haplotyper_rad_haplotyper.pl
doc: "A tool for haplotyping RADseq data. (Note: The provided text contains container
  runtime error logs rather than the tool's help documentation, so no arguments could
  be extracted.)\n\nTool homepage: https://github.com/chollenbeck/rad_haplotyper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rad:0.6.0--h077b44d_0
stdout: rad_haplotyper_rad_haplotyper.pl.out
