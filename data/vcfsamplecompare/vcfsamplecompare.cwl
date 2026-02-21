cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcfsamplecompare
label: vcfsamplecompare
doc: "A tool for comparing VCF samples. (Note: The provided help text contains container
  runtime error messages and does not list specific command-line arguments.)\n\nTool
  homepage: https://github.com/hepcat72/vcfSampleCompare"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcfsamplecompare:2.013--pl526_0
stdout: vcfsamplecompare.out
