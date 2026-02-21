cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcf2maf
label: vcf2maf
doc: "The provided text does not contain help information or usage instructions; it
  is a log of a failed container build process.\n\nTool homepage: https://github.com/mskcc/vcf2maf"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcf2maf:1.6.22--hdfd78af_1
stdout: vcf2maf.out
