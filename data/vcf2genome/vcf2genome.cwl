cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcf2genome
label: vcf2genome
doc: "The provided text is a container build log error and does not contain help information
  or usage instructions for the tool vcf2genome.\n\nTool homepage: https://github.com/apeltzer/vcf2genome"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcf2genome:0.91--hdfd78af_2
stdout: vcf2genome.out
