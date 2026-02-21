cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-sanger-cgp-vcf
label: perl-sanger-cgp-vcf
doc: "The provided text is an error log from a container build process (Apptainer/Singularity)
  and does not contain the help text or usage information for the tool. As a result,
  no arguments could be extracted.\n\nTool homepage: https://github.com/cancerit/cgpVcf"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-sanger-cgp-vcf:2.2.1--pl5321h7b50bb2_10
stdout: perl-sanger-cgp-vcf.out
