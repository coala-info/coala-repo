cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcf2bed
label: bedops_vcf2bed
doc: "The provided text does not contain help information for the tool. It contains
  system log messages and a fatal error indicating a failure to build or extract a
  container image due to lack of disk space.\n\nTool homepage: http://bedops.readthedocs.io"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedops:2.4.42--hd6d6fdc_1
stdout: bedops_vcf2bed.out
