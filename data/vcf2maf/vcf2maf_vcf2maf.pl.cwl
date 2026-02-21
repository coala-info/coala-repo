cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcf2maf.pl
label: vcf2maf_vcf2maf.pl
doc: "Convert VCF to MAF\n\nTool homepage: https://github.com/mskcc/vcf2maf"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcf2maf:1.6.22--hdfd78af_1
stdout: vcf2maf_vcf2maf.pl.out
