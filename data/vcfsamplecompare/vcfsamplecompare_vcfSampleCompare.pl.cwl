cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcfSampleCompare.pl
label: vcfsamplecompare_vcfSampleCompare.pl
doc: "A tool to compare samples within VCF files. Note: The provided input text contains
  system logs and error messages rather than the tool's help documentation, so no
  arguments could be extracted.\n\nTool homepage: https://github.com/hepcat72/vcfSampleCompare"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcfsamplecompare:2.013--pl526_0
stdout: vcfsamplecompare_vcfSampleCompare.pl.out
