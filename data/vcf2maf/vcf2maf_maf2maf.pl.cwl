cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcf2maf_maf2maf.pl
label: vcf2maf_maf2maf.pl
doc: "The provided text does not contain help information for the tool. It contains
  container runtime logs and a fatal error message indicating a failure to pull or
  build the image.\n\nTool homepage: https://github.com/mskcc/vcf2maf"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcf2maf:1.6.22--hdfd78af_1
stdout: vcf2maf_maf2maf.pl.out
