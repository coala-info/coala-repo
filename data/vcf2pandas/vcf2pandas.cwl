cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcf2pandas
label: vcf2pandas
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a log of a failed container build process.\n\nTool homepage:
  https://github.com/trentzz/vcf2pandas"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcf2pandas:0.2.0--pyhdfd78af_0
stdout: vcf2pandas.out
