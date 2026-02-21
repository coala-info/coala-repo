cwlVersion: v1.2
class: CommandLineTool
baseCommand: genometester_katk2vcf.pl
label: genometester_katk2vcf.pl
doc: "A tool to convert KAT (K-mer Analysis Toolkit) k-mer counts or similar output
  to VCF format.\n\nTool homepage: https://github.com/bioinfo-ut/GenomeTester4"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/genometester:v4.0git20180508.a9c14a6dfsg-1-deb_cv1
stdout: genometester_katk2vcf.pl.out
