cwlVersion: v1.2
class: CommandLineTool
baseCommand: plot-vcfstats
label: perl-bio-samtools_plot-vcfstats
doc: "A tool for plotting VCF statistics. (Note: The provided input text contains
  system error messages regarding container image creation and does not include the
  actual help documentation for the tool.)\n\nTool homepage: https://www.htslib.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-samtools:1.43--pl5321h577a1d6_6
stdout: perl-bio-samtools_plot-vcfstats.out
